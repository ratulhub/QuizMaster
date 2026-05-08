package quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import quiz.db.DBConnection;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Unauthorized");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            
            // Get total users
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) req.setAttribute("totalUsers", rs.getInt(1));
            }
            
            // Get total quizzes
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM quizzes");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) req.setAttribute("totalQuizzes", rs.getInt(1));
            }

            // Get categories for upload form
            // Let's just pass a simple flag for now, JSP can iterate or hardcode categories
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/pages/admin.jsp").forward(req, res);
    }
}
