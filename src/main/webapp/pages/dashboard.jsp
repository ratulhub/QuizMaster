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
    <div id="globalLoader" class="loader-overlay">
        <div class="cyber-loader"></div>
    </div>

    <nav class="navbar animate-fade-up">
        <div class="navbar-brand">
            <span style="color: var(--accent-primary);">⚡</span> QuizMaster
        </div>
        <div class="nav-links">
            <span class="text-muted" style="font-family: var(--font-heading);">Agent: <span class="text-primary"><%= session.getAttribute("user") %></span></span>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="${pageContext.request.contextPath}/admin" class="btn btn-outline" style="padding: 0.5rem 1rem; font-size: 0.9rem;">Admin Panel</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-danger" style="padding: 0.5rem 1rem; font-size: 0.9rem;">Disconnect</a>
        </div>
    </nav>

    <div class="container" style="margin-top: 3rem;">
        <div class="text-center animate-fade-up stagger-1 mb-8">
            <h1 style="font-size: 3.5rem;">Commander <span class="text-gradient"><%= request.getAttribute("rank_title") != null ? request.getAttribute("rank_title") : "Novice" %></span></h1>
            <p class="text-muted mt-2" style="font-size: 1.2rem;">Your current standing in the arena.</p>
        </div>
        
        <div class="grid grid-cols-3 mb-8 animate-fade-up stagger-2">
            <div class="glass-card interactive text-center">
                <div class="text-muted" style="font-size: 1.1rem; text-transform: uppercase; letter-spacing: 2px;">Total XP</div>
                <div class="stat-value"><%= request.getAttribute("xp") != null ? request.getAttribute("xp") : "0" %></div>
            </div>
            <div class="glass-card interactive text-center" style="border-color: rgba(0, 229, 255, 0.3);">
                <div class="text-muted" style="font-size: 1.1rem; text-transform: uppercase; letter-spacing: 2px;">Missions</div>
                <div class="stat-value" style="background: linear-gradient(to bottom, #00e5ff, #0088ff); -webkit-background-clip: text;"><%= request.getAttribute("total_quizzes") != null ? request.getAttribute("total_quizzes") : "0" %></div>
            </div>
            <div class="glass-card interactive text-center" style="border-color: rgba(0, 255, 136, 0.3);">
                <div class="text-muted" style="font-size: 1.1rem; text-transform: uppercase; letter-spacing: 2px;">Current Streak</div>
                <div class="stat-value" style="background: linear-gradient(to bottom, #00ff88, #00cc66); -webkit-background-clip: text;"><%= request.getAttribute("current_streak") != null ? request.getAttribute("current_streak") : "0" %> 🔥</div>
            </div>
        </div>

        <div class="glass-card interactive text-center animate-fade-up stagger-3" style="padding: 4rem 2rem;">
            <h2 class="mb-2 text-gradient" style="font-size: 2.5rem;">Enter the Arena</h2>
            <p class="text-muted mb-4" style="font-size: 1.1rem;">Choose your challenge mode and prove your worth.</p>
            <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="btn btn-glow" style="font-size: 1.2rem; padding: 1rem 3rem;">Select Game Mode</a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
    <script>
        // Check for returning from quiz
        window.onload = () => {
            const urlParams = new URLSearchParams(window.location.search);
            if(urlParams.get('welcome')) {
                if(window.showToast) showToast('Welcome back, Commander.', 'success');
            }
        };
    </script>
</body>
</html>
