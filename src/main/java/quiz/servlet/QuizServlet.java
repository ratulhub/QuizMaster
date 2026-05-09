package quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import quiz.model.Models;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import quiz.db.DBConnection;

@WebServlet(urlPatterns = {"/dashboard", "/quiz"})
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getServletPath();
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        if ("/dashboard".equals(path)) {
            handleDashboard(req, res, session);
        } else if ("/quiz".equals(path)) {
            handleQuiz(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getServletPath();
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        if ("/quiz".equals(path)) {
            // Quiz logic if needed via POST
        }
    }

    private void handleDashboard(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws ServletException, IOException {
        UUID userId = (UUID) session.getAttribute("userId");

        try (Connection conn = DBConnection.getConnection()) {
            String sqlProfile = "SELECT xp, rank_title, total_quizzes_taken, correct_answers, wrong_answers FROM profiles WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlProfile)) {
                ps.setObject(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        req.setAttribute("xp", rs.getInt("xp"));
                        req.setAttribute("rank_title", rs.getString("rank_title"));
                        req.setAttribute("total_quizzes", rs.getInt("total_quizzes_taken"));
                        req.setAttribute("correct_answers", rs.getInt("correct_answers"));
                        req.setAttribute("wrong_answers", rs.getInt("wrong_answers"));
                    }
                }
            }

            String sqlStreak = "SELECT current_streak, highest_streak FROM streaks WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlStreak)) {
                ps.setObject(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        req.setAttribute("current_streak", rs.getInt("current_streak"));
                        req.setAttribute("highest_streak", rs.getInt("highest_streak"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/pages/dashboard.jsp").forward(req, res);
    }

    private void handleQuiz(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<Models.Question> questions = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, quiz_id, question_text, " +
                         "options->>'A' AS option_a, " +
                         "options->>'B' AS option_b, " +
                         "options->>'C' AS option_c, " +
                         "options->>'D' AS option_d " +
                         "FROM questions ORDER BY RANDOM() LIMIT 5";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Models.Question q = new Models.Question();
                        q.setId(rs.getInt("id"));
                        q.setQuizId(rs.getInt("quiz_id"));
                        q.setText(rs.getString("question_text"));
                        q.setOptionA(rs.getString("option_a"));
                        q.setOptionB(rs.getString("option_b"));
                        q.setOptionC(rs.getString("option_c"));
                        q.setOptionD(rs.getString("option_d"));
                        questions.add(q);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        req.setAttribute("questions", questions);
        
        StringBuilder ids = new StringBuilder();
        for (int i = 0; i < questions.size(); i++) {
            ids.append(questions.get(i).getId());
            if (i < questions.size() - 1) ids.append(",");
        }
        req.setAttribute("questionIds", ids.toString());
        req.setAttribute("total", questions.size());

        req.getRequestDispatcher("/pages/quiz.jsp").forward(req, res);
    }
}

