<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Enter the Arena</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <div class="min-h-screen flex-center">
        <div class="auth-container glass-panel animate-fade-in">
            <h2 id="authTitle" class="text-center mb-4 gradient-text">Welcome Back</h2>
            
            <% String error = request.getParameter("error");
               if (error != null) { %>
               <div style="color: var(--accent-red); margin-bottom: 1rem; text-align: center;"><%= error %></div>
            <% } %>
            
            <% String success = request.getParameter("success");
               if (success != null) { %>
               <div style="color: var(--accent-green); margin-bottom: 1rem; text-align: center;"><%= success %></div>
            <% } %>

            <!-- Login Form -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="username" class="input-field" placeholder="Username" required>
                <input type="password" name="password" class="input-field" placeholder="Password" required>
                <button type="submit" class="btn" style="width: 100%;">Initiate Sequence</button>
                <p class="text-center mt-4 text-secondary">
                    New contender? <span class="toggle-link">Register</span>
                </p>
            </form>

            <!-- Register Form (Hidden by default) -->
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" class="hidden">
                <input type="text" name="username" class="input-field" placeholder="Choose Username" required>
                <input type="password" name="password" class="input-field" placeholder="Create Password" required>
                <button type="submit" class="btn" style="width: 100%;">Create Profile</button>
                <p class="text-center mt-4 text-secondary">
                    Already enrolled? <span class="toggle-link">Login</span>
                </p>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
