<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - QuizMaster</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/vars.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
    <style>
        body { display: flex; justify-content: center; align-items: center; height: 100vh; }
        .auth-card { width: 400px; text-align: center; }
        h2 { font-size: 2rem; margin-top: 0; }
        .auth-card input { margin-bottom: 20px; }
        .auth-links { margin-top: 20px; }
        .auth-links a { color: var(--accent-blue); text-decoration: none; font-size: 0.9rem; }
        .alert { background: rgba(239, 68, 68, 0.2); color: #f87171; padding: 10px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.4); }
        .success { background: rgba(34, 197, 94, 0.2); color: #4ade80; border-color: rgba(34, 197, 94, 0.4); }
    </style>
</head>
<body>

    <div class="glass-panel auth-card">
        <h2 class="gradient-text">Welcome Back</h2>
        <p style="color:var(--text-secondary); margin-bottom:30px;">Enter the battle arena</p>

        <% String error = request.getParameter("error"); %>
        <% String success = request.getParameter("success"); %>
        <% if(error != null) { %><div class="alert"><%= error %></div><% } %>
        <% if(success != null) { %><div class="alert success"><%= success %></div><% } %>

        <form action="../../login" method="post">
            <input type="text" name="username" class="input-field" placeholder="Username" required>
            <input type="password" name="password" class="input-field" placeholder="Password" required>
            <button type="submit" class="btn" style="width:100%">Login</button>
        </form>

        <div class="auth-links">
            <a href="registration.jsp">New warrior? Register here</a>
        </div>
    </div>

</body>
</html>