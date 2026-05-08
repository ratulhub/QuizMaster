package quiz.servlet;

import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/battle")
public class BattleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Logic to render the battle lobby or join room
        req.getRequestDispatcher("/pages/modes.jsp").forward(req, res);
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
            // Create a new battle room logic
            String newRoomCode = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            req.setAttribute("roomCode", newRoomCode);
            req.getRequestDispatcher("/pages/quiz.jsp?mode=battle&room=" + newRoomCode).forward(req, res);
        } else if ("join".equals(action) && roomCode != null) {
            // Join an existing battle room logic
            req.getRequestDispatcher("/pages/quiz.jsp?mode=battle&room=" + roomCode).forward(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/dashboard");
        }
    }
}
