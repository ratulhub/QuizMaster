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
    <!-- Global Loader -->
    <div id="globalLoader" class="loader-overlay">
        <div class="cyber-loader"></div>
    </div>

    <div class="min-h-screen flex-center">
        <div class="glass-card animate-fade-up" style="width: 100%; max-width: 440px; margin: 2rem;">
            <h1 id="authTitle" class="text-center mb-4 text-gradient" style="font-size: 2.5rem;">Welcome Back</h1>
            
            <% String error = request.getParameter("error");
               if (error != null) { %>
               <div style="background: rgba(255,0,85,0.1); border: 1px solid var(--accent-tertiary); color: #ffcccc; padding: 12px; border-radius: 8px; margin-bottom: 16px; text-align: center;">
                   <%= error %>
               </div>
               <script>
                   window.onload = () => { if(window.showToast) showToast('<%= error %>', 'error'); };
               </script>
            <% } %>
            
            <% String success = request.getParameter("success");
               if (success != null) { %>
               <div style="background: rgba(0,255,136,0.1); border: 1px solid var(--accent-success); color: #ccffcc; padding: 12px; border-radius: 8px; margin-bottom: 16px; text-align: center;">
                   <%= success %>
               </div>
               <script>
                   window.onload = () => { if(window.showToast) showToast('<%= success %>', 'success'); };
               </script>
            <% } %>

            <!-- Login Form -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" class="stagger-1">
                <div class="input-group">
                    <input type="text" name="username" class="input-field" placeholder=" " required id="login-user">
                    <label class="input-label" for="login-user">Username</label>
                </div>
                <div class="input-group">
                    <input type="password" name="password" class="input-field" placeholder=" " required id="login-pass">
                    <label class="input-label" for="login-pass">Password</label>
                </div>
                <button type="submit" class="btn btn-glow" style="width: 100%; margin-top: 1rem;">Initiate Sequence</button>
                <p class="text-center mt-4 text-muted">
                    New contender? <a href="#" class="text-primary" onclick="toggleAuth(event)">Register here</a>
                </p>
            </form>

            <!-- Register Form (Hidden by default) -->
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" style="display: none;">
                <div class="input-group">
                    <input type="text" name="username" class="input-field" placeholder=" " required id="reg-user">
                    <label class="input-label" for="reg-user">Choose Username</label>
                </div>
                <div class="input-group">
                    <input type="password" name="password" class="input-field" placeholder=" " required id="reg-pass">
                    <label class="input-label" for="reg-pass">Create Password</label>
                </div>
                <button type="submit" class="btn btn-glow" style="width: 100%; margin-top: 1rem;">Create Profile</button>
                <p class="text-center mt-4 text-muted">
                    Already enrolled? <a href="#" class="text-primary" onclick="toggleAuth(event)">Login here</a>
                </p>
            </form>
        </div>
    </div>
    
    <script>
        function toggleAuth(e) {
            e.preventDefault();
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            const title = document.getElementById('authTitle');
            
            if (loginForm.style.display !== 'none') {
                loginForm.style.display = 'none';
                registerForm.style.display = 'block';
                title.textContent = 'Join the Arena';
                // Trigger animation
                registerForm.classList.add('animate-fade-up');
            } else {
                loginForm.style.display = 'block';
                registerForm.style.display = 'none';
                title.textContent = 'Welcome Back';
                loginForm.classList.add('animate-fade-up');
            }
        }
    </script>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
