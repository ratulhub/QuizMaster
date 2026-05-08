<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Results</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <div class="container min-h-screen flex-center animate-fade-in">
        <div class="glass-panel text-center" style="max-width: 600px; width: 100%;">
            <h1 class="gradient-text-accent mb-2">Session Complete</h1>
            <p class="text-secondary mb-4">Mode: <%= request.getAttribute("mode") != null ? request.getAttribute("mode") : "Unknown" %></p>
            
            <div class="stat-value text-accent-blue mb-4" style="font-size: 4rem;">
                <%= request.getAttribute("score") != null ? request.getAttribute("score") : "0" %> / <%= request.getAttribute("total") != null ? request.getAttribute("total") : "3" %>
            </div>
            
            <div class="grid grid-cols-2 mb-4">
                <div style="background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); padding: 1rem; border-radius: 8px;">
                    <div class="text-secondary">XP Earned</div>
                    <div class="stat-value text-accent-green" style="font-size: 2rem;">+<%= request.getAttribute("xpEarned") != null ? request.getAttribute("xpEarned") : "0" %></div>
                </div>
                <div style="background: rgba(121, 40, 202, 0.1); border: 1px solid rgba(121, 40, 202, 0.3); padding: 1rem; border-radius: 8px;">
                    <div class="text-secondary">Current Rank</div>
                    <div class="stat-value text-accent-purple" style="font-size: 2rem;"><%= request.getAttribute("rank") != null ? request.getAttribute("rank") : "Novice" %></div>
                </div>
            </div>

            <div class="flex-center mt-4">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn">Return to Base</a>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
