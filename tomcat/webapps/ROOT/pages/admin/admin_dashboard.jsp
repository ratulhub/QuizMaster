<%@ page session="true" %>
<%
if(session.getAttribute("user") == null || !"ADMIN".equals(session.getAttribute("role"))){
    response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp?error=Unauthorized");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - QuizMaster</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/vars.css">
    <link rel="stylesheet" href="../../assets/css/animations.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
    <style>
        .navbar { display: flex; justify-content: space-between; padding: 20px 40px; background: var(--glass-bg); backdrop-filter: blur(10px); border-bottom: 1px solid var(--glass-border); align-items: center; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .dashboard-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        
        .stats-row { display: flex; gap: 20px; }
        .stat-item { text-align: center; background: rgba(0,0,0,0.2); padding: 20px; border-radius: 12px; border: 1px solid var(--glass-border); }
        .stat-item h3 { margin: 0; color: var(--accent-blue); font-size: 2rem; }
        .stat-item p { margin: 5px 0 0 0; font-size: 0.9rem; color: var(--text-secondary); text-transform: uppercase; }

        .modes-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 20px; }
        .mode-card { padding: 25px; border-radius: 16px; background: var(--glass-bg); border: 1px solid var(--glass-border); }
        .mode-card h3 { margin: 0 0 10px 0; font-size: 1.5rem; }
        .mode-card p { margin: 0; color: var(--text-secondary); font-size: 0.9rem; line-height: 1.4; }
        
        .upload-panel { background: rgba(59,130,246,0.05); border: 1px dashed var(--accent-blue); padding: 40px; border-radius: 16px; text-align: center; margin-top: 20px; }
        .upload-form { display: flex; flex-direction: column; gap: 15px; max-width: 400px; margin: 0 auto; }
        
        .alert { background: rgba(239, 68, 68, 0.2); color: #f87171; padding: 10px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.4); text-align: center; }
        .success { background: rgba(34, 197, 94, 0.2); color: #4ade80; border-color: rgba(34, 197, 94, 0.4); }
    </style>
</head>
<body>

    <div class="navbar">
        <h1 class="gradient-text" style="margin:0; font-size:1.5rem;">ADMIN PANEL</h1>
        <div class="user-info">
            <a href="../user/dashboard.jsp" class="badge" style="text-decoration:none;">Exit Admin</a>
            <a href="../../logout" style="color:var(--text-secondary); text-decoration:none; margin-left:15px;">Logout</a>
        </div>
    </div>

    <div class="dashboard-container">
        
        <% String error = request.getParameter("error"); %>
        <% String success = request.getParameter("success"); %>
        <% if(error != null) { %><div class="alert"><%= error %></div><% } %>
        <% if(success != null) { %><div class="alert success"><%= success %></div><% } %>

        <div class="stats-row" style="margin-bottom: 40px;">
            <div class="stat-item" style="flex:1;">
                <h3>${totalUsers != null ? totalUsers : 0}</h3>
                <p>Registered Warriors</p>
            </div>
            <div class="stat-item" style="flex:1;">
                <h3>${totalQuizzes != null ? totalQuizzes : 0}</h3>
                <p>Active Quizzes</p>
            </div>
            <div class="stat-item" style="flex:1;">
                <h3 style="color:var(--accent-red)">12</h3>
                <p>Game Modes Online</p>
            </div>
        </div>

        <div class="header-section">
            <h2 style="margin:0;">Platform Controls</h2>
        </div>

        <div class="modes-grid">
            <div class="mode-card">
                <h3>Manage Users 👥</h3>
                <p>Ban users, reset passwords, or modify rank titles.</p>
                <button class="btn" style="margin-top:15px; width:100%; padding:10px; font-size:0.9rem;">Open Manager</button>
            </div>
            
            <div class="mode-card mode-roast">
                <h3>Roast Dictionary 💀</h3>
                <p>Add new brutal insults for the AI to use when students fail.</p>
                <button class="btn" style="margin-top:15px; width:100%; padding:10px; font-size:0.9rem;">Add Roasts</button>
            </div>
            
            <div class="mode-card mode-panic">
                <h3>Live Analytics 📈</h3>
                <p>Watch student panic levels and success rates in real-time.</p>
                <button class="btn" style="margin-top:15px; width:100%; padding:10px; font-size:0.9rem;">View Stats</button>
            </div>
        </div>

        <div class="header-section" style="margin-top: 40px;">
            <h2 style="margin:0;">AI Question Generator</h2>
        </div>
        
        <div class="upload-panel">
            <h3>Upload Course Material</h3>
            <p style="color:var(--text-secondary); font-size:0.9rem; margin-bottom:20px;">Upload a .TXT, .PDF, or .DOCX file and the AI will auto-extract multiple choice questions.</p>
            
            <form action="../../admin/upload" method="post" enctype="multipart/form-data" class="upload-form">
                <input type="text" name="title" class="input-field" placeholder="Quiz Title" required>
                <select name="category_id" class="input-field" style="background:#0f172a;" required>
                    <option value="1">Computer Science</option>
                    <option value="2">Mathematics</option>
                    <option value="3">General Knowledge</option>
                </select>
                <input type="file" name="file" accept=".txt,.pdf,.docx" style="color:white; margin:10px 0;" required>
                <button type="submit" class="btn">Generate Quiz</button>
            </form>
        </div>

    </div>

</body>
</html>
