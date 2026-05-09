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
    <div class="blur-shape blur-primary"></div>
    <div class="blur-shape blur-tertiary"></div>

    <div class="min-h-screen flex-center">
        <div class="auth-container md-card animate-fade-in">
            <h1 id="authTitle" class="text-center mb-4 text-primary" style="font-size: 2.5rem;">Welcome Back</h1>
            
            <% String error = request.getParameter("error");
               if (error != null) { %>
               <div class="error-msg"><%= error %></div>
            <% } %>
            
            <% String success = request.getParameter("success");
               if (success != null) { %>
               <div style="color: var(--md-primary); background-color: var(--md-secondary-container); padding: 12px; border-radius: 8px; margin-bottom: 16px; text-align: center;"><%= success %></div>
            <% } %>

            <!-- Login Form -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <div class="md-input-container">
                    <input type="text" name="username" class="md-input" placeholder=" " required id="login-user">
                    <label class="md-input-label" for="login-user">Username</label>
                </div>
                <div class="md-input-container">
                    <input type="password" name="password" class="md-input" placeholder=" " required id="login-pass">
                    <label class="md-input-label" for="login-pass">Password</label>
                </div>
                <button type="submit" class="md-btn md-btn-filled" style="width: 100%; height: 48px; font-size: 16px;">Initiate Sequence</button>
                <p class="text-center mt-4 text-secondary">
                    New contender? <button type="button" class="toggle-link">Register</button>
                </p>
            </form>

            <!-- Register Form (Hidden by default) -->
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" class="hidden" style="display: none;">
                <div class="md-input-container">
                    <input type="text" name="username" class="md-input" placeholder=" " required id="reg-user">
                    <label class="md-input-label" for="reg-user">Choose Username</label>
                </div>
                <div class="md-input-container">
                    <input type="password" name="password" class="md-input" placeholder=" " required id="reg-pass">
                    <label class="md-input-label" for="reg-pass">Create Password</label>
                </div>
                <button type="submit" class="md-btn md-btn-filled" style="width: 100%; height: 48px; font-size: 16px;">Create Profile</button>
                <p class="text-center mt-4 text-secondary">
                    Already enrolled? <button type="button" class="toggle-link">Login</button>
                </p>
            </form>
        </div>
    </div>
    
    <script>
        // Inline JS for toggling to replace app.js dependency for this simple action
        // since we changed span to button for accessibility
        document.querySelectorAll('.toggle-link').forEach(btn => {
            btn.addEventListener('click', () => {
                const loginForm = document.getElementById('loginForm');
                const registerForm = document.getElementById('registerForm');
                const title = document.getElementById('authTitle');
                
                if (loginForm.style.display !== 'none') {
                    loginForm.style.display = 'none';
                    registerForm.style.display = 'block';
                    title.textContent = 'Join the Arena';
                } else {
                    loginForm.style.display = 'block';
                    registerForm.style.display = 'none';
                    title.textContent = 'Welcome Back';
                }
            });
        });
    </script>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
