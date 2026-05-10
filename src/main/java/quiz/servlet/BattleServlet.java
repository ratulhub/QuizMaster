package quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import quiz.db.DBConnection;
import quiz.model.Models;

@WebServlet("/battle")
public class BattleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Render the battle lobby page
        req.getRequestDispatcher("/pages/battle.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String roomCode = req.getParameter("roomCode");

        if ("create".equals(action)) {
            // Generate a unique 6-character room code
            String newRoomCode = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            req.setAttribute("roomCode", newRoomCode);
            // Show the battle lobby with the room code displayed
            req.getRequestDispatcher("/pages/battle.jsp").forward(req, res);

        } else if ("join".equals(action) && roomCode != null && !roomCode.trim().isEmpty()) {
            // Join the room — redirect to quiz with battle mode and room code
            res.sendRedirect(req.getContextPath() + "/quiz?mode=battle&room=" + roomCode.trim().toUpperCase());

        } else {
            res.sendRedirect(req.getContextPath() + "/battle?error=Invalid+Action");
        }
    }
}
