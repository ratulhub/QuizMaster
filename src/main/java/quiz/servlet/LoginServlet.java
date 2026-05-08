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
import quiz.util.PasswordUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Empty+Fields");
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(pass);

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, username, role FROM users WHERE username=? AND password_hash=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user);
                ps.setString(2, hashedPassword);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        UUID userId = (UUID) rs.getObject("id");
                        String role = rs.getString("role");

                        HttpSession session = req.getSession();
                        session.setAttribute("user", user);
                        session.setAttribute("userId", userId);
                        session.setAttribute("role", role);
                        
                        // Update last login date
                        String updateStreak = "UPDATE streaks SET last_login = CURRENT_DATE WHERE user_id = ?";
                        try(PreparedStatement psStreak = conn.prepareStatement(updateStreak)){
                             psStreak.setObject(1, userId);
                             psStreak.executeUpdate();
                        }

                        res.sendRedirect(req.getContextPath() + "/dashboard"); // Redirect to servlet, not JSP directly
                    } else {
                        res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Invalid+Credentials");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Server+Error");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?success=Logged+Out+Successfully");
            return;
        }
        res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
    }
}