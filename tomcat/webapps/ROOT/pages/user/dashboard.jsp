<%@ page session="true" %>
<%
String user = (String) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - QuizMaster</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/vars.css">
    <link rel="stylesheet" href="../../assets/css/animations.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
    <style>
        .navbar { display: flex; justify-content: space-between; padding: 20px 40px; background: var(--glass-bg); backdrop-filter: blur(10px); border-bottom: 1px solid var(--glass-border); align-items: center; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: var(--accent-purple); display: flex; align-items: center; justify-content: center; font-weight: bold; }
        
        .dashboard-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        
        .profile-banner { display: flex; justify-content: space-between; align-items: center; background: linear-gradient(135deg, rgba(59,130,246,0.1), rgba(139,92,246,0.1)); padding: 30px; border-radius: 16px; border: 1px solid var(--glass-border); margin-bottom: 40px; }
        .rank-info h2 { margin: 0 0 10px 0; font-size: 2rem; }
        .xp-bar-container { width: 300px; height: 10px; background: rgba(0,0,0,0.3); border-radius: 5px; overflow: hidden; margin-top: 10px; }
        .xp-bar { height: 100%; background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple)); width: 60%; } /* Dynamic width later */
        
        .stats-row { display: flex; gap: 20px; }
        .stat-item { text-align: center; background: rgba(0,0,0,0.2); padding: 15px 25px; border-radius: 12px; border: 1px solid var(--glass-border); }
        .stat-item h3 { margin: 0; color: var(--accent-blue); font-size: 1.5rem; }
        .stat-item p { margin: 5px 0 0 0; font-size: 0.8rem; color: var(--text-secondary); text-transform: uppercase; }

        .modes-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .mode-card { position: relative; overflow: hidden; padding: 25px; border-radius: 16px; background: var(--glass-bg); border: 1px solid var(--glass-border); transition: var(--transition-smooth); cursor: pointer; text-decoration: none; color: white; display: block; }
        .mode-card:hover { transform: translateY(-5px) scale(1.02); background: rgba(255,255,255,0.05); border-color: var(--accent-blue); box-shadow: 0 10px 30px rgba(59,130,246,0.2); }
        
        .mode-card h3 { margin: 0 0 10px 0; font-size: 1.5rem; }
        .mode-card p { margin: 0; color: var(--text-secondary); font-size: 0.9rem; line-height: 1.4; }
        
        /* Specific Mode Styles */
        .mode-roast:hover { border-color: var(--accent-red); box-shadow: 0 10px 30px rgba(239,68,68,0.2); }
        .mode-panic:hover { animation: shake 0.5s infinite; border-color: var(--accent-red); }
        .mode-teacher:hover { border-color: #f59e0b; box-shadow: 0 10px 30px rgba(245,158,11,0.2); }
        .mode-brainrot:hover { animation: glitch 0.3s infinite; }
        
        .header-section { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: flex-end; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1 class="gradient-text" style="margin:0; font-size:1.5rem;">QUIZMASTER</h1>
        <div class="user-info">
            <% if("ADMIN".equals(role)) { %>
                <a href="admin" class="badge" style="text-decoration:none;">Admin Panel</a>
            <% } %>
            <div class="avatar"><%= user.substring(0,1).toUpperCase() %></div>
            <span><%= user %></span>
            <a href="../../logout" style="color:var(--text-secondary); text-decoration:none; margin-left:15px;">Logout</a>
        </div>
    </div>

    <div class="dashboard-container">
        
        <div class="profile-banner">
            <div class="rank-info">
                <h2>Level 5 <span class="gradient-text">${rank_title != null ? rank_title : "Initiate"}</span></h2>
                <div style="display:flex; justify-content:space-between; width:300px; font-size:0.8rem; color:var(--text-secondary);">
                    <span>XP: ${xp != null ? xp : 0}</span>
                    <span>Next Rank: 1000 XP</span>
                </div>
                <div class="xp-bar-container">
                    <div class="xp-bar" style="width: 45%;"></div>
                </div>
            </div>
            
            <div class="stats-row">
                <div class="stat-item">
                    <h3>🔥 ${current_streak != null ? current_streak : 0}</h3>
                    <p>Day Streak</p>
                </div>
                <div class="stat-item">
                    <h3>${total_quizzes != null ? total_quizzes : 0}</h3>
                    <p>Battles Fought</p>
                </div>
                <div class="stat-item">
                    <h3 style="color:var(--accent-green)">${correct_answers != null ? correct_answers : 0}</h3>
                    <p>Perfect Hits</p>
                </div>
            </div>
        </div>

        <div class="header-section">
            <h2 style="margin:0;">Select Game Mode</h2>
            <div class="badge">12 Modes Available</div>
        </div>

        <div class="modes-grid">
            <a href="../modes/quiz_room.jsp?mode=NORMAL" class="mode-card">
                <h3>Normal Mode 🧠</h3>
                <p>Classic multiple choice questions to test your raw knowledge safely.</p>
            </a>
            
            <a href="../modes/quiz_room.jsp?mode=ROAST" class="mode-card mode-roast">
                <h3>Roast Mode 💀</h3>
                <p>Get an answer wrong, and the AI will absolutely destroy your self-esteem.</p>
            </a>

            <a href="../modes/quiz_room.jsp?mode=PANIC" class="mode-card mode-panic">
                <h3>Panic Attack ⏱️</h3>
                <p>Fast countdowns, heartbeat audio, shaking screen. Don't freeze.</p>
            </a>

            <a href="../modes/quiz_room.jsp?mode=TEACHER_EXAM" class="mode-card mode-teacher">
                <h3>Teacher Exam 👨‍🏫</h3>
                <p>Strict rules. If you switch tabs, you fail instantly. High tension.</p>
            </a>

            <a href="../modes/quiz_room.jsp?mode=SUDDEN_DEATH" class="mode-card mode-roast">
                <h3>Sudden Death ⚔️</h3>
                <p>One mistake and it's game over. See how long you can survive.</p>
            </a>

            <a href="../modes/quiz_room.jsp?mode=BRAINROT" class="mode-card mode-brainrot">
                <h3>Brainrot 🤪</h3>
                <p>Skibidi rizz questions only. No cap. Fr fr.</p>
            </a>
            
            <!-- More modes can be dynamically loaded here later -->
        </div>

    </div>

</body>
</html>
