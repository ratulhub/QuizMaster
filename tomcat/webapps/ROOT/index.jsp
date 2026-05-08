<%@ page session="true" %>
<%
if(session.getAttribute("user") != null){
    response.sendRedirect("pages/user/dashboard.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - The Ultimate Battle</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/vars.css">
    <link rel="stylesheet" href="css/animations.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }
        .hero h1 {
            font-size: 5rem;
            font-weight: 900;
            margin: 0;
            line-height: 1.1;
            letter-spacing: -2px;
            animation: slideInUp 1s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .hero p {
            font-size: 1.5rem;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 20px 0 40px;
            animation: slideInUp 1s cubic-bezier(0.16, 1, 0.3, 1) 0.2s both;
        }
        .action-btns {
            display: flex;
            gap: 20px;
            animation: slideInUp 1s cubic-bezier(0.16, 1, 0.3, 1) 0.4s both;
        }
        .btn-large {
            padding: 18px 40px;
            font-size: 1.2rem;
            border-radius: 50px;
            text-decoration: none;
        }
        .btn-secondary {
            background: transparent;
            border: 2px solid var(--glass-border);
            color: var(--text-primary);
        }
        .btn-secondary:hover {
            background: rgba(255,255,255,0.1);
        }
        .floating-element {
            position: absolute;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.5;
            z-index: -1;
        }
        .shape-1 { width: 300px; height: 300px; top: 10%; left: 10%; animation: float 6s infinite alternate; }
        .shape-2 { width: 400px; height: 400px; bottom: 10%; right: 10%; background: linear-gradient(135deg, var(--accent-purple), var(--accent-red)); animation: float 8s infinite alternate-reverse; }
    </style>
</head>
<body>

    <div class="floating-element shape-1"></div>
    <div class="floating-element shape-2"></div>

    <div class="hero">
        <div class="badge animate-slide-up" style="margin-bottom: 20px;">v2.0 MASTER UPGRADE</div>
        <h1 class="gradient-text">SURVIVE.<br>CONQUER.<br>ROAST.</h1>
        <p>12 insane game modes. Real-time battles. Zero mercy. Are you ready to prove your intelligence?</p>
        
        <div class="action-btns">
            <a href="pages/auth/registration.jsp" class="btn btn-large">Join The Battle</a>
            <a href="pages/auth/login.jsp" class="btn btn-large btn-secondary">Login</a>
        </div>
    </div>

</body>
</html>