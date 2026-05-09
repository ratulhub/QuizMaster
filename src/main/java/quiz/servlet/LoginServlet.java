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

/**
 * The LoginServlet handles user authentication.
 * 
 * WHY IT EXISTS:
 * This servlet acts as the main entry point for the user. It validates their credentials against 
 * the database securely.
 * 
 * HOW DATA FLOWS:
 * 1. The client submits a POST request containing 'username' and 'password' from login.jsp.
 * 2. This servlet reads those parameters.
 * 3. It hashes the password using SHA-256 (PasswordUtil) to ensure plain-text passwords are never compared.
 * 4. It uses a PreparedStatement to query the 'users' table securely, preventing SQL injection.
 * 5. If a match is found, an HttpSession is created to maintain their logged-in state across the app.
 * 6. Finally, the user is redirected to the dashboard.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // Security Check: Ensure inputs are not empty before proceeding to database
        if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Empty+Fields");
            return;
        }

        // We hash the incoming password first. The database only stores hashes!
        String hashedPassword = PasswordUtil.hashPassword(pass);

        // Try-With-Resources: This guarantees that the Connection is closed automatically,
        // preventing memory and connection leaks, even if an exception occurs.
        try (Connection conn = DBConnection.getConnection()) {
            
            // We use PreparedStatement (?) instead of standard Statement. 
            // This tells PostgreSQL to treat the input as literal data, preventing SQL Injection attacks.
            String sql = "SELECT id, username, role FROM users WHERE username=? AND password_hash=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user);
                ps.setString(2, hashedPassword);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // User exists and password hash matches!
                        UUID userId = (UUID) rs.getObject("id");
                        String role = rs.getString("role");

                        // Create an HttpSession (or retrieve existing).
                        // This cookie-based session tells the server the user is authenticated.
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