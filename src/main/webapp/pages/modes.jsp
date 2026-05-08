<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Select Mode</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <nav>
        <div class="logo gradient-text-accent">QuizMaster</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary" style="padding: 8px 16px;">Back to Base</a>
        </div>
    </nav>

    <div class="container animate-fade-in">
        <h1 class="mb-4 text-center">Select Protocol</h1>
        
        <div class="grid grid-cols-3 stagger-animate">
            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1 text-accent-blue">Normal Mode</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">Standard assessment protocol. Balanced difficulty.</p>
                <a href="${pageContext.request.contextPath}/quiz?mode=normal" class="btn" style="width: 100%;">Engage</a>
            </div>
            
            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1 text-accent-red">Roast Mode</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">AI will roast your mistakes relentlessly.</p>
                <a href="${pageContext.request.contextPath}/quiz?mode=roast" class="btn" style="width: 100%; background: var(--accent-red);">Engage</a>
            </div>

            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1 text-accent-purple">Sudden Death</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">One mistake and the simulation ends. 2x XP.</p>
                <a href="${pageContext.request.contextPath}/quiz?mode=sudden_death" class="btn" style="width: 100%; background: linear-gradient(135deg, #ef4444, #7928ca);">Engage</a>
            </div>
            
            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1" style="color: #fbbf24;">Teacher Mode</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">Receive detailed explanations for every answer.</p>
                <a href="${pageContext.request.contextPath}/quiz?mode=teacher" class="btn" style="width: 100%; background: #d97706;">Engage</a>
            </div>
            
            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1 text-accent-green">Friend Battle</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">Compete head-to-head in real time.</p>
                <form action="${pageContext.request.contextPath}/battle" method="post" class="flex-center" style="gap: 10px;">
                    <input type="hidden" name="action" value="create">
                    <button type="submit" class="btn" style="width: 100%; background: var(--accent-green);">Host</button>
                </form>
            </div>
            
            <div class="glass-panel" style="text-align: center;">
                <h3 class="mb-1" style="color: #ec4899;">Bride Interview</h3>
                <p class="text-secondary mb-2" style="font-size: 0.9rem;">Answer life scenario questions.</p>
                <a href="${pageContext.request.contextPath}/quiz?mode=bride" class="btn" style="width: 100%; background: #ec4899;">Engage</a>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
