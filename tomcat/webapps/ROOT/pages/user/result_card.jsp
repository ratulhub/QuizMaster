<%@ page session="true" %>
<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}
String user = (String) session.getAttribute("user");
Integer score = (Integer) request.getAttribute("score");
Integer total = (Integer) request.getAttribute("total");
Integer xpEarned = (Integer) request.getAttribute("xpEarned");
String mode = (String) request.getAttribute("mode");
String rank = (String) request.getAttribute("rank");

if (score == null) {
    response.sendRedirect("dashboard.jsp");
    return;
}

// Simple Title generation
String title = "Participant";
if (score == total) title = "Absolute God";
else if (score >= total * 0.8) title = "Brainiac";
else if (score >= total * 0.5) title = "Average Joe";
else title = "Certified Noob";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Result - QuizMaster</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/vars.css">
    <link rel="stylesheet" href="../../assets/css/animations.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <style>
        body { display: flex; flex-direction: column; justify-content: center; align-items: center; min-height: 100vh; overflow-y: auto; padding: 20px; }
        
        .result-container { margin-top: 40px; text-align: center; }
        
        /* The Canvas Card to Share */
        .share-card {
            background: linear-gradient(135deg, #1e293b, #0f172a);
            border: 2px solid var(--accent-blue);
            border-radius: 24px;
            padding: 40px;
            width: 400px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5), inset 0 0 0 1px rgba(255,255,255,0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
            display: inline-block;
            text-align: center;
        }

        .share-card::before {
            content: '';
            position: absolute;
            top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(59,130,246,0.1) 0%, transparent 50%);
            z-index: 0;
        }

        .share-card > * { position: relative; z-index: 1; }
        
        .score-circle {
            width: 150px; height: 150px; border-radius: 50%;
            background: rgba(0,0,0,0.3); border: 4px solid var(--accent-purple);
            display: flex; justify-content: center; align-items: center;
            margin: 0 auto 20px; font-size: 3rem; font-weight: 900;
            color: white; text-shadow: 0 0 20px var(--accent-purple);
        }

        .share-btn {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            margin-bottom: 10px;
        }

        #confetti { position: fixed; inset: 0; pointer-events: none; z-index: 1000; }
    </style>
</head>
<body>

    <canvas id="confetti"></canvas>

    <div class="result-container animate-slide-up">
        <h1 style="font-size:3rem; margin-bottom:10px;" class="gradient-text">BATTLE OVER</h1>
        
        <!-- This card gets screenshotted -->
        <div class="share-card" id="captureCard">
            <div class="badge" style="margin-bottom: 20px; background: rgba(59,130,246,0.3); border-color: var(--accent-blue);">
                <%= mode %> MATCH
            </div>

            <div class="score-circle">
                <%= score %>/<%= total %>
            </div>

            <h2 style="font-size:2rem; margin:0 0 5px;"><%= user.toUpperCase() %></h2>
            <p style="color:var(--accent-blue); font-weight:bold; margin:0 0 20px;">[ <%= rank %> ]</p>
            
            <div style="background:rgba(0,0,0,0.3); padding:15px; border-radius:12px; margin-bottom:20px;">
                <h3 style="margin:0 0 5px; color:var(--text-secondary); font-size:0.9rem;">ACHIEVED TITLE</h3>
                <h2 style="margin:0; font-size:1.5rem; color:var(--accent-green);">"<%= title %>"</h2>
            </div>
            
            <p style="color:var(--text-muted); font-size:0.9rem; margin:0;">
                +<%= xpEarned %> XP EARNED
            </p>
        </div>

        <div>
            <button class="btn share-btn" style="width: 400px;" onclick="downloadCard()">
                📸 Download Image to Share
            </button>
            <br>
            <a href="dashboard.jsp" class="btn btn-outline" style="width: 365px; display: inline-block; text-align: center;">
                Return to Dashboard
            </a>
        </div>
    </div>

    <script>
        // Confetti logic
        const canvas = document.getElementById('confetti');
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        
        let particles = [];
        const colors = ['#3b82f6', '#8b5cf6', '#22c55e', '#ef4444', '#f59e0b'];
        
        for(let i = 0; i < 150; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height - canvas.height,
                r: Math.random() * 6 + 2,
                dx: Math.random() * 4 - 2,
                dy: Math.random() * 5 + 2,
                color: colors[Math.floor(Math.random() * colors.length)]
            });
        }
        
        function animate() {
            requestAnimationFrame(animate);
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            particles.forEach(p => {
                ctx.beginPath(); ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fillStyle = p.color; ctx.fill();
                p.x += p.dx; p.y += p.dy;
                if(p.y > canvas.height) p.y = -10;
            });
        }
        
        <% if(score >= total * 0.5) { %> animate(); <% } %>

        // HTML2Canvas
        function downloadCard() {
            const btn = document.querySelector('.share-btn');
            btn.innerText = "Generating...";
            
            html2canvas(document.getElementById('captureCard'), {
                backgroundColor: '#0f172a',
                scale: 2 // High-res
            }).then(canvas => {
                const link = document.createElement('a');
                link.download = '<%= user %>_quiz_result.png';
                link.href = canvas.toDataURL('image/png');
                link.click();
                btn.innerText = "📸 Download Image to Share";
            });
        }
    </script>
</body>
</html>
