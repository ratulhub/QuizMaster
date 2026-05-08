package quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import quiz.db.DBConnection;
import quiz.util.PasswordUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Empty+Fields");
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(pass);

        // Using try-with-resources to automatically close DB connections and prevent memory leaks
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // 1. Insert into users table
            String sqlUser = "INSERT INTO users (username, password_hash) VALUES (?, ?) RETURNING id";
            try (PreparedStatement psUser = conn.prepareStatement(sqlUser)) {
                psUser.setString(1, user);
                psUser.setString(2, hashedPassword);

                try (ResultSet rs = psUser.executeQuery()) {
                    if (rs.next()) {
                        UUID userId = (UUID) rs.getObject("id");

                        // 2. Insert into profiles table to initialize XP and stats
                        String sqlProfile = "INSERT INTO profiles (user_id) VALUES (?)";
                        try (PreparedStatement psProfile = conn.prepareStatement(sqlProfile)) {
                            psProfile.setObject(1, userId);
                            psProfile.executeUpdate();
                        }

                        // 3. Insert into streaks table
                        String sqlStreak = "INSERT INTO streaks (user_id) VALUES (?)";
                        try (PreparedStatement psStreak = conn.prepareStatement(sqlStreak)) {
                            psStreak.setObject(1, userId);
                            psStreak.executeUpdate();
                        }

                        conn.commit(); // Commit transaction
                        res.sendRedirect(req.getContextPath() + "/pages/login.jsp?success=Registration+Successful");
                    } else {
                        conn.rollback();
                        res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Registration+Failed");
                    }
                }
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Username+Already+Exists");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Server+Error");
        }
    }
}