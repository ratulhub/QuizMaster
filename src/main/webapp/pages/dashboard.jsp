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
        <div class="logo">QuizMaster</div>
        <div class="nav-links">
            <span class="text-secondary" style="font-family: var(--font-heading); font-size: 1.2rem;">Welcome, <%= session.getAttribute("user") %></span>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="${pageContext.request.contextPath}/admin" class="md-btn md-btn-tonal" style="padding: 8px 16px;">Admin</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="md-btn md-btn-outlined" style="padding: 8px 16px; color: #B3261E; border-color: #B3261E;">Logout</a>
        </div>
    </nav>

    <div class="blur-shape blur-primary" style="top: 10%; left: 10%;"></div>
    <div class="blur-shape blur-tertiary" style="top: 40%; right: 10%;"></div>

    <div class="container animate-fade-in" style="position: relative; z-index: 1;">
        <h1 class="mb-4" style="font-size: 3rem;">Commander <span class="text-primary"><%= request.getAttribute("rank_title") != null ? request.getAttribute("rank_title") : "Novice" %></span></h1>
        
        <div class="grid grid-cols-3 mb-4 stagger-animate">
            <div class="md-card interactive text-center">
                <div class="text-secondary" style="font-weight: 500;">Total XP</div>
                <div class="stat-value"><%= request.getAttribute("xp") != null ? request.getAttribute("xp") : "0" %></div>
            </div>
            <div class="md-card interactive text-center">
                <div class="text-secondary" style="font-weight: 500;">Quizzes Completed</div>
                <div class="stat-value" style="color: var(--md-tertiary);"><%= request.getAttribute("total_quizzes") != null ? request.getAttribute("total_quizzes") : "0" %></div>
            </div>
            <div class="md-card interactive text-center">
                <div class="text-secondary" style="font-weight: 500;">Current Streak</div>
                <div class="stat-value" style="color: #386a20;"><%= request.getAttribute("current_streak") != null ? request.getAttribute("current_streak") : "0" %> 🔥</div>
            </div>
        </div>

        <div class="md-card stagger-animate text-center interactive" style="padding: 3rem 2rem;">
            <h2 class="mb-2" style="font-size: 2.5rem; color: var(--md-on-background);">Enter the Arena</h2>
            <p class="text-secondary mb-4" style="font-size: 1.1rem;">Choose your challenge mode and prove your worth.</p>
            <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="md-btn md-btn-filled" style="font-size: 1.1rem; padding: 12px 32px;">Select Game Mode</a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
