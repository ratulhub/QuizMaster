<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - QuizMaster</title>
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
    </style>
</head>
<body>

    <div class="glass-panel auth-card">
        <h2 class="gradient-text">Join The Ranks</h2>
        <p style="color:var(--text-secondary); margin-bottom:30px;">Create your profile and start leveling up</p>

        <% String error = request.getParameter("error"); %>
        <% if(error != null) { %><div class="alert"><%= error %></div><% } %>

        <form action="../../register" method="post">
            <input type="text" name="username" class="input-field" placeholder="Choose Username" required>
            <input type="password" name="password" class="input-field" placeholder="Create Password" required>
            <button type="submit" class="btn" style="width:100%">Create Account</button>
        </form>

        <div class="auth-links">
            <a href="login.jsp">Already a member? Login here</a>
        </div>
    </div>

</body>
</html>