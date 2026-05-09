<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Active Session</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <style>
        .radio-option {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            background-color: var(--md-surface-container-low);
            border-radius: 12px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: var(--transition-fast);
            border: 1px solid transparent;
        }
        .radio-option:hover {
            background-color: var(--md-secondary-container);
        }
        .radio-option input[type="radio"] {
            margin-right: 12px;
            accent-color: var(--md-primary);
            transform: scale(1.2);
        }
    </style>
</head>
<body>
    <div class="blur-shape blur-tertiary" style="top: 20%; left: 10%; width: 30vw;"></div>
    
    <div class="container min-h-screen flex-center animate-fade-in">
        <div class="md-card" style="max-width: 800px; width: 100%;">
            <div class="flex-between mb-4" style="border-bottom: 1px solid var(--md-surface-container-low); padding-bottom: 1rem;">
                <h2 class="text-primary" style="font-size: 2rem;">Protocol Active</h2>
                <div style="background: var(--md-primary); color: var(--md-on-primary); padding: 4px 12px; border-radius: 9999px; font-size: 0.8rem; font-weight: 500;">
                    MODE: <%= request.getParameter("mode") != null ? request.getParameter("mode").toUpperCase() : "NORMAL" %>
                </div>
            </div>

            <form id="quizForm" action="${pageContext.request.contextPath}/submit" method="post">
                <input type="hidden" name="mode" value="<%= request.getParameter("mode") != null ? request.getParameter("mode") : "normal" %>">
                <input type="hidden" name="total" value="3">
                     
                <!-- Simulated Question 1 -->
                <div class="mb-4">
                    <h3 class="mb-2" style="font-family: var(--font-main); font-weight: 500; font-size: 1.2rem;">1. What is the size of int variable in Java?</h3>
                    <div style="display: flex; flex-direction: column;">
                        <label class="radio-option"><input type="radio" name="q1" value="8 bit"> 8 bit</label>
                        <label class="radio-option"><input type="radio" name="q1" value="16 bit"> 16 bit</label>
                        <label class="radio-option"><input type="radio" name="q1" value="32 bit"> 32 bit</label>
                        <label class="radio-option"><input type="radio" name="q1" value="64 bit"> 64 bit</label>
                    </div>
                </div>

                <!-- Simulated Question 2 -->
                <div class="mb-4">
                    <h3 class="mb-2" style="font-family: var(--font-main); font-weight: 500; font-size: 1.2rem;">2. What is the entry point of a Java program?</h3>
                    <div style="display: flex; flex-direction: column;">
                        <label class="radio-option"><input type="radio" name="q2" value="main()"> main()</label>
                        <label class="radio-option"><input type="radio" name="q2" value="start()"> start()</label>
                        <label class="radio-option"><input type="radio" name="q2" value="init()"> init()</label>
                        <label class="radio-option"><input type="radio" name="q2" value="run()"> run()</label>
                    </div>
                </div>

                <!-- Simulated Question 3 -->
                <div class="mb-4">
                    <h3 class="mb-2" style="font-family: var(--font-main); font-weight: 500; font-size: 1.2rem;">3. Which keyword is used to define a namespace?</h3>
                    <div style="display: flex; flex-direction: column;">
                        <label class="radio-option"><input type="radio" name="q3" value="namespace"> namespace</label>
                        <label class="radio-option"><input type="radio" name="q3" value="package"> package</label>
                        <label class="radio-option"><input type="radio" name="q3" value="import"> import</label>
                        <label class="radio-option"><input type="radio" name="q3" value="include"> include</label>
                    </div>
                </div>
                
                <!-- Simulated Score Input -->
                <div class="md-input-container" style="max-width: 250px;">
                    <input type="number" name="score" id="sim-score" class="md-input" placeholder=" " min="0" max="3" required>
                    <label class="md-input-label" for="sim-score">Simulated Score (0-3)</label>
                </div>

                <div class="flex-center mt-4">
                    <button type="submit" class="md-btn md-btn-filled" style="font-size: 1.1rem; padding: 12px 32px;">Terminate Session & Submit</button>
                </div>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
