package quiz.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import quiz.db.DBConnection;
import quiz.util.FileParser;

/**
 * Handles file uploads and delegates parsing logic to FileParser utility.
 */
@WebServlet("/admin/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Unauthorized");
            return;
        }

        String title = req.getParameter("title");
        int categoryId = Integer.parseInt(req.getParameter("category_id"));
        Part filePart = req.getPart("file");

        String fileName = filePart.getSubmittedFileName().toLowerCase();
        String extractedText = "";

        try (InputStream fileContent = filePart.getInputStream()) {
            if (fileName.endsWith(".txt")) {
                extractedText = FileParser.parseTxt(fileContent);
            } else if (fileName.endsWith(".pdf")) {
                extractedText = FileParser.parsePdf(fileContent);
            } else if (fileName.endsWith(".docx")) {
                extractedText = FileParser.parseDocx(fileContent);
            } else {
                res.sendRedirect(req.getContextPath() + "/pages/admin.jsp?error=Unsupported+Format");
                return;
            }

            // Parse text and insert into database
            parseAndSaveQuiz(title, categoryId, extractedText, (java.util.UUID) session.getAttribute("userId"));
            
            res.sendRedirect(req.getContextPath() + "/pages/admin.jsp?success=Quiz+Generated+Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/pages/admin.jsp?error=Processing+Failed");
        }
    }

    private void parseAndSaveQuiz(String title, int categoryId, String text, java.util.UUID adminId) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            String sqlQuiz = "INSERT INTO quizzes (title, category_id, created_by) VALUES (?, ?, ?) RETURNING id";
            try (PreparedStatement ps = conn.prepareStatement(sqlQuiz)) {
                ps.setString(1, title);
                ps.setInt(2, categoryId);
                ps.setObject(3, adminId);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int quizId = rs.getInt("id");
                        
                        // Parse Questions
                        String[] lines = text.split("\n");
                        String currentQ = "";
                        List<String> options = new ArrayList<>();
                        String correct = "A";
                        
                        String sqlQ = "INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement psQ = conn.prepareStatement(sqlQ)) {
                            for (String line : lines) {
                                line = line.trim();
                                if (line.isEmpty()) continue;
                                
                                if (line.endsWith("?")) {
                                    if (!currentQ.isEmpty() && options.size() >= 4) {
                                        psQ.setInt(1, quizId);
                                        psQ.setString(2, currentQ);
                                        psQ.setString(3, options.get(0));
                                        psQ.setString(4, options.get(1));
                                        psQ.setString(5, options.get(2));
                                        psQ.setString(6, options.get(3));
                                        psQ.setString(7, correct);
                                        psQ.executeUpdate();
                                    }
                                    currentQ = line;
                                    options.clear();
                                } else if (line.startsWith("Correct:")) {
                                    correct = line.replace("Correct:", "").trim().substring(0, 1).toUpperCase();
                                } else if (options.size() < 4) {
                                    String opt = line.replaceFirst("^[A-Da-d][\\)\\.]\\s*", "");
                                    options.add(opt);
                                }
                            }
                            
                            if (!currentQ.isEmpty() && options.size() >= 4) {
                                psQ.setInt(1, quizId);
                                psQ.setString(2, currentQ);
                                psQ.setString(3, options.get(0));
                                psQ.setString(4, options.get(1));
                                psQ.setString(5, options.get(2));
                                psQ.setString(6, options.get(3));
                                psQ.setString(7, correct);
                                psQ.executeUpdate();
                            }
                        }
                        conn.commit();
                    }
                }
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }
        }
    }
}
