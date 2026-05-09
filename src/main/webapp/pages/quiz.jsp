<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, quiz.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Arena</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <style>
        .roast-overlay {
            position: fixed;
            top: 20px; left: 50%; transform: translateX(-50%);
            background: rgba(255, 0, 85, 0.9);
            color: white;
            padding: 15px 30px;
            border-radius: 12px;
            font-family: var(--font-heading);
            font-size: 1.5rem;
            z-index: 1000;
            box-shadow: 0 10px 30px rgba(255,0,85,0.5);
            display: none;
            animation: slideDown 0.5s ease-out;
        }
        @keyframes slideDown { from { top: -100px; } to { top: 20px; } }
    </style>
</head>
<body>
    <div id="roastOverlay" class="roast-overlay"></div>

    <div class="container animate-fade-up" style="max-width: 800px; margin-top: 2rem;">
        <div class="glass-card" style="padding: 3rem;">
            <div class="flex-between mb-4">
                <div>
                    <span class="text-muted" style="text-transform: uppercase; letter-spacing: 1px;">Mode:</span>
                    <span class="text-gradient" style="font-weight: bold; font-family: var(--font-heading);"><%= session.getAttribute("modeCode") %></span>
                </div>
                <div class="timer-display" id="timerDisplay">--</div>
            </div>

            <div class="quiz-progress-bar">
                <div class="quiz-progress-fill" id="progressFill"></div>
            </div>

            <%
                List<Question> questions = (List<Question>) session.getAttribute("quizQuestions");
                Integer currentIndexObj = (Integer) session.getAttribute("currentQuestionIndex");
                int currentIndex = currentIndexObj != null ? currentIndexObj : 0;
                
                if (questions != null && currentIndex < questions.size()) {
                    Question q = questions.get(currentIndex);
            %>
            
            <h2 class="mb-8" style="font-size: 2rem; line-height: 1.4;"><%= (currentIndex + 1) %>. <%= q.getQuestionText() %></h2>
            
            <form id="quizForm" action="${pageContext.request.contextPath}/quiz" method="post">
                <input type="hidden" name="action" value="submitAnswer">
                <input type="hidden" name="questionId" value="<%= q.getId() %>">
                <input type="hidden" id="timeTaken" name="timeTaken" value="0">
                
                <%
                    String optionsStr = q.getOptions();
                    // Basic parsing for format {"A": "Option 1", "B": "Option 2"}
                    optionsStr = optionsStr.replace("{", "").replace("}", "").replace("\"", "");
                    String[] opts = optionsStr.split(",");
                    for (String opt : opts) {
                        String[] pair = opt.split(":");
                        if (pair.length == 2) {
                            String key = pair[0].trim();
                            String val = pair[1].trim();
                %>
                <div class="animate-fade-up stagger-1">
                    <input type="radio" id="opt_<%= key %>" name="answer" value="<%= key %>" class="option-input" required>
                    <label for="opt_<%= key %>" class="option-label"><%= val %></label>
                </div>
                <%
                        }
                    }
                %>
                
                <div class="mt-8 text-center animate-fade-up stagger-2">
                    <button type="submit" class="btn btn-glow" style="width: 100%; font-size: 1.2rem;">Confirm Answer</button>
                </div>
            </form>
            
            <% } else { %>
                <div class="text-center">
                    <h2 class="text-gradient mb-4">Transmission Complete</h2>
                    <p class="text-muted mb-8">Calculating your results...</p>
                    <form action="${pageContext.request.contextPath}/quiz" method="post">
                        <input type="hidden" name="action" value="finish">
                        <button type="submit" class="btn btn-glow">View Results</button>
                    </form>
                </div>
            <% } %>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
    <script>
        // Update Progress Bar
        const total = <%= questions != null ? questions.size() : 1 %>;
        const current = <%= currentIndex %>;
        const progress = ((current) / total) * 100;
        document.getElementById('progressFill').style.width = progress + '%';

        // Timer Logic based on mode
        let timeLeft = 15; // default
        const mode = '<%= session.getAttribute("modeCode") %>';
        if (mode === 'sudden_death') timeLeft = 10;
        else if (mode === 'teacher') timeLeft = 60;
        
        const display = document.getElementById('timerDisplay');
        const timeTakenInput = document.getElementById('timeTaken');
        let startTime = Date.now();
        
        const timer = setInterval(() => {
            if(document.getElementById('quizForm') == null) {
                clearInterval(timer);
                return; // quiz is over
            }
            timeLeft--;
            display.textContent = timeLeft;
            
            if (timeLeft <= 5) {
                display.classList.add('timer-danger');
            }
            
            if (timeLeft <= 0) {
                clearInterval(timer);
                // Auto submit empty answer
                timeTakenInput.value = Math.floor((Date.now() - startTime) / 1000);
                document.getElementById('quizForm').submit();
            }
        }, 1000);
        
        // Track time taken on manual submit
        document.getElementById('quizForm')?.addEventListener('submit', () => {
            timeTakenInput.value = Math.floor((Date.now() - startTime) / 1000);
            clearInterval(timer);
        });

        // Show roast message if it exists in session (from previous wrong answer)
        <% String roast = (String) session.getAttribute("currentRoast");
           if (roast != null) { 
               session.removeAttribute("currentRoast"); // consume it
        %>
        const overlay = document.getElementById('roastOverlay');
        overlay.textContent = "<%= roast %>";
        overlay.style.display = "block";
        setTimeout(() => { overlay.style.display = 'none'; }, 4000);
        <% } %>
    </script>
</body>
</html>
