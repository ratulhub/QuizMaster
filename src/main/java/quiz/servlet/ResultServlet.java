package quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import quiz.db.DBConnection;

@WebServlet("/submit")
public class ResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        UUID userId = (UUID) session.getAttribute("userId");
        String mode = req.getParameter("mode");
        
        String questionIdsParam = req.getParameter("questionIds");
        int score = 0;
        int total = 0;
        
        if (questionIdsParam != null && !questionIdsParam.trim().isEmpty()) {
            String[] qIds = questionIdsParam.split(",");
            total = qIds.length;
            
            try (Connection conn = DBConnection.getConnection()) {
                StringBuilder placeholders = new StringBuilder();
                for (int i = 0; i < qIds.length; i++) {
                    placeholders.append("?");
                    if (i < qIds.length - 1) placeholders.append(",");
                }
                
                String sql = "SELECT id, correct_option FROM questions WHERE id IN (" + placeholders.toString() + ")";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    for (int i = 0; i < qIds.length; i++) {
                        ps.setInt(i + 1, Integer.parseInt(qIds[i].trim()));
                    }
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            int qId = rs.getInt("id");
                            String correctAns = rs.getString("correct_option");
                            String userAns = req.getParameter("q_" + qId);
                            
                            if (correctAns != null && correctAns.equalsIgnoreCase(userAns)) {
                                score++;
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // fallback if someone skipped the form
            total = req.getParameter("total") != null ? Integer.parseInt(req.getParameter("total")) : 0;
        }

        // Simplified XP Calculation
        int xpMultiplier = mode != null && mode.equalsIgnoreCase("sudden_death") ? 2 : 1;
        int xpEarned = score * 10 * xpMultiplier;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            String sqlAttempt = "INSERT INTO quiz_attempts (user_id, mode_id, score, total_questions, xp_earned) " +
                                "VALUES (?, (SELECT id FROM quiz_modes WHERE code = ?), ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sqlAttempt)) {
                ps.setObject(1, userId);
                ps.setString(2, mode);
                ps.setInt(3, score);
                ps.setInt(4, total);
                ps.setInt(5, xpEarned);
                ps.executeUpdate();
            }

            String sqlProfile = "UPDATE profiles SET xp = xp + ?, total_quizzes_taken = total_quizzes_taken + 1, " +
                                "correct_answers = correct_answers + ?, wrong_answers = wrong_answers + ? " +
                                "WHERE user_id = ? RETURNING xp";
            int newXp = 0;
            try (PreparedStatement ps = conn.prepareStatement(sqlProfile)) {
                ps.setInt(1, xpEarned);
                ps.setInt(2, score);
                ps.setInt(3, total - score);
                ps.setObject(4, userId);
                try(ResultSet rs = ps.executeQuery()) {
                    if(rs.next()) newXp = rs.getInt("xp");
                }
            }

            // Simplified Rank Calculation
            String newRank = "Novice";
            if (newXp >= 1000) newRank = "Master";
            else if (newXp >= 500) newRank = "Expert";
            else if (newXp >= 200) newRank = "Intermediate";

            String sqlRank = "UPDATE profiles SET rank_title = ? WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlRank)) {
                ps.setString(1, newRank);
                ps.setObject(2, userId);
                ps.executeUpdate();
            }

            conn.commit();

            req.setAttribute("score", score);
            req.setAttribute("total", total);
            req.setAttribute("xpEarned", xpEarned);
            req.setAttribute("mode", mode);
            req.setAttribute("rank", newRank);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/pages/dashboard.jsp");
            return;
        }

        req.getRequestDispatcher("/pages/result.jsp").forward(req, res);
    }
}
