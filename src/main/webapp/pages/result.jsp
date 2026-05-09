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
    <div class="blur-shape blur-primary" style="top: 15%; left: 20%; width: 60vw;"></div>

    <div class="container min-h-screen flex-center animate-fade-in">
        <div class="md-card text-center" style="max-width: 600px; width: 100%; border-radius: 48px; padding: 4rem 2rem;">
            <h1 class="text-primary mb-2" style="font-size: 3.5rem;">Session Complete</h1>
            <p class="text-secondary mb-4" style="font-size: 1.2rem; font-family: var(--font-main);">Mode: <%= request.getAttribute("mode") != null ? request.getAttribute("mode") : "Unknown" %></p>
            
            <div class="stat-value text-primary mb-4" style="font-size: 5rem;">
                <%= request.getAttribute("score") != null ? request.getAttribute("score") : "0" %> <span style="font-size: 3rem; color: var(--md-outline);">/ <%= request.getAttribute("total") != null ? request.getAttribute("total") : "3" %></span>
            </div>
            
            <div class="grid grid-cols-2 mb-4">
                <div style="background: rgba(103, 80, 164, 0.08); padding: 1.5rem; border-radius: 24px;">
                    <div class="text-secondary" style="font-family: var(--font-main); font-weight: 500;">XP Earned</div>
                    <div class="stat-value text-primary" style="font-size: 2.5rem;">+<%= request.getAttribute("xpEarned") != null ? request.getAttribute("xpEarned") : "0" %></div>
                </div>
                <div style="background: rgba(125, 82, 96, 0.08); padding: 1.5rem; border-radius: 24px;">
                    <div class="text-secondary" style="font-family: var(--font-main); font-weight: 500;">Current Rank</div>
                    <div class="stat-value" style="color: var(--md-tertiary); font-size: 2.5rem;"><%= request.getAttribute("rank") != null ? request.getAttribute("rank") : "Novice" %></div>
                </div>
            </div>

            <div class="flex-center mt-4">
                <a href="${pageContext.request.contextPath}/dashboard" class="md-btn md-btn-filled" style="font-size: 1.1rem; padding: 12px 32px;">Return to Base</a>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
