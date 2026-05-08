<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <nav>
        <div class="logo gradient-text-accent">QuizMaster</div>
        <div class="nav-links">
            <span style="color: var(--text-secondary);">Welcome, <%= session.getAttribute("user") %></span>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary" style="padding: 8px 16px;">Admin</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary" style="padding: 8px 16px; border-color: var(--accent-red); color: var(--accent-red);">Logout</a>
        </div>
    </nav>

    <div class="container animate-fade-in">
        <h1 class="mb-4">Commander <span class="gradient-text-accent"><%= request.getAttribute("rank_title") != null ? request.getAttribute("rank_title") : "Novice" %></span></h1>
        
        <div class="grid grid-cols-3 mb-4 stagger-animate">
            <div class="stat-card glass-panel" style="padding: 1.5rem;">
                <div class="text-secondary">Total XP</div>
                <div class="stat-value text-accent-purple"><%= request.getAttribute("xp") != null ? request.getAttribute("xp") : "0" %></div>
            </div>
            <div class="stat-card glass-panel" style="padding: 1.5rem;">
                <div class="text-secondary">Quizzes Completed</div>
                <div class="stat-value text-accent-blue"><%= request.getAttribute("total_quizzes") != null ? request.getAttribute("total_quizzes") : "0" %></div>
            </div>
            <div class="stat-card glass-panel" style="padding: 1.5rem;">
                <div class="text-secondary">Current Streak</div>
                <div class="stat-value text-accent-green"><%= request.getAttribute("current_streak") != null ? request.getAttribute("current_streak") : "0" %> 🔥</div>
            </div>
        </div>

        <div class="glass-panel stagger-animate" style="text-align: center;">
            <h2 class="mb-2">Enter the Arena</h2>
            <p class="text-secondary mb-4">Choose your challenge mode and prove your worth.</p>
            <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="btn animate-float">Select Game Mode</a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
