<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Mission Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
</head>
<body>
    <div id="globalLoader" class="loader-overlay">
        <div class="cyber-loader"></div>
    </div>

    <div class="container animate-fade-up flex-center min-h-screen">
        <div class="glass-card text-center" style="max-width: 600px; width: 100%; padding: 4rem 2rem;">
            <h1 class="text-gradient mb-2" style="font-size: 2.5rem;">Mission Report</h1>
            <p class="text-muted mb-8" style="font-size: 1.2rem;">Analyzing your performance...</p>
            
            <div class="mb-8">
                <div class="text-muted" style="text-transform: uppercase; letter-spacing: 2px; font-size: 0.9rem;">Final Score</div>
                <div class="result-score"><%= request.getAttribute("score") %> / <%= request.getAttribute("total") %></div>
            </div>
            
            <div class="grid grid-cols-2 mb-8">
                <div style="background: rgba(255,255,255,0.05); padding: 1.5rem; border-radius: 12px; border: 1px solid rgba(255,255,255,0.1);">
                    <div class="text-muted mb-2">XP Earned</div>
                    <div class="text-gradient" style="font-size: 2rem; font-family: var(--font-heading); font-weight: bold;">+<%= request.getAttribute("xpEarned") != null ? request.getAttribute("xpEarned") : "0" %></div>
                </div>
                <div style="background: rgba(255,255,255,0.05); padding: 1.5rem; border-radius: 12px; border: 1px solid rgba(255,255,255,0.1);">
                    <div class="text-muted mb-2">Mode</div>
                    <div style="color: var(--accent-secondary); font-size: 1.5rem; font-family: var(--font-heading); font-weight: bold; margin-top: 0.5rem;"><%= request.getAttribute("mode") != null ? request.getAttribute("mode") : "Unknown" %></div>
                </div>
            </div>
            
            <div class="flex-center mt-8 gap-4">
                <a href="${pageContext.request.contextPath}/pages/dashboard.jsp?welcome=1" class="btn btn-outline" style="width: 100%;">Return to Base</a>
                <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="btn btn-glow" style="width: 100%;">Play Again</a>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
    <script>
        // Confetti Effect based on score
        window.onload = () => {
            const score = parseInt('<%= request.getAttribute("score") %>');
            const total = parseInt('<%= request.getAttribute("total") %>');
            
            if (total > 0 && (score / total) >= 0.5) {
                const duration = 3000;
                const end = Date.now() + duration;

                (function frame() {
                    confetti({
                        particleCount: 5,
                        angle: 60,
                        spread: 55,
                        origin: { x: 0 },
                        colors: ['#8a2be2', '#00e5ff', '#00ff88']
                    });
                    confetti({
                        particleCount: 5,
                        angle: 120,
                        spread: 55,
                        origin: { x: 1 },
                        colors: ['#8a2be2', '#00e5ff', '#00ff88']
                    });

                    if (Date.now() < end) {
                        requestAnimationFrame(frame);
                    }
                }());
            } else if (total > 0 && (score / total) == 0) {
                 if(window.showToast) showToast('Ouch. Complete failure.', 'error');
            }
        };
    </script>
</body>
</html>
