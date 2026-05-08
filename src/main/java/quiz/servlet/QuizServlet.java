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
            req.getRequestDispatcher("/pages/quiz.jsp").forward(req, res);
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


}

