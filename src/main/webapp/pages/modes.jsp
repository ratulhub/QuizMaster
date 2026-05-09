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
        <div class="logo">QuizMaster</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="md-btn md-btn-outlined" style="padding: 8px 16px;">Back to Base</a>
        </div>
    </nav>

    <div class="blur-shape blur-primary" style="top: -5%; left: 30%; width: 40vw;"></div>

    <div class="container animate-fade-in" style="position: relative; z-index: 1;">
        <h1 class="mb-4 text-center text-primary" style="font-size: 3rem;">Select Protocol</h1>
        
        <div class="grid grid-cols-3 stagger-animate">
            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: var(--md-primary); font-size: 1.8rem;">Normal Mode</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">Standard assessment protocol. Balanced difficulty.</p>
                </div>
                <a href="${pageContext.request.contextPath}/quiz?mode=normal" class="md-btn md-btn-filled" style="width: 100%;">Engage</a>
            </div>
            
            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: #B3261E; font-size: 1.8rem;">Roast Mode</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">AI will roast your mistakes relentlessly.</p>
                </div>
                <a href="${pageContext.request.contextPath}/quiz?mode=roast" class="md-btn md-btn-filled" style="width: 100%; background: #B3261E;">Engage</a>
            </div>

            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: var(--md-tertiary); font-size: 1.8rem;">Sudden Death</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">One mistake and the simulation ends. 2x XP.</p>
                </div>
                <a href="${pageContext.request.contextPath}/quiz?mode=sudden_death" class="md-btn md-btn-filled" style="width: 100%; background: var(--md-tertiary);">Engage</a>
            </div>
            
            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: #b16a00; font-size: 1.8rem;">Teacher Mode</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">Receive detailed explanations for every answer.</p>
                </div>
                <a href="${pageContext.request.contextPath}/quiz?mode=teacher" class="md-btn md-btn-filled" style="width: 100%; background: #b16a00;">Engage</a>
            </div>
            
            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: #386a20; font-size: 1.8rem;">Friend Battle</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">Compete head-to-head in real time.</p>
                </div>
                <form action="${pageContext.request.contextPath}/battle" method="post" class="flex-center" style="width: 100%;">
                    <input type="hidden" name="action" value="create">
                    <button type="submit" class="md-btn md-btn-filled" style="width: 100%; background: #386a20;">Host</button>
                </form>
            </div>
            
            <div class="md-card interactive text-center" style="display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h3 class="mb-1" style="color: #9c27b0; font-size: 1.8rem;">Bride Interview</h3>
                    <p class="text-secondary mb-4" style="font-size: 1rem;">Answer life scenario questions.</p>
                </div>
                <a href="${pageContext.request.contextPath}/quiz?mode=bride" class="md-btn md-btn-filled" style="width: 100%; background: #9c27b0;">Engage</a>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
