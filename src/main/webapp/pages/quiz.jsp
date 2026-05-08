<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Active Session</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <div class="container min-h-screen flex-center animate-fade-in">
        <div class="glass-panel" style="max-width: 800px; width: 100%;">
            <div class="flex-center mb-4" style="justify-content: space-between; border-bottom: 1px solid var(--glass-border); padding-bottom: 1rem;">
                <h2 class="gradient-text-accent">Protocol Active</h2>
                <div class="badge">Mode: <%= request.getParameter("mode") != null ? request.getParameter("mode").toUpperCase() : "NORMAL" %></div>
            </div>

            <form id="quizForm" action="${pageContext.request.contextPath}/submit" method="post">
                <input type="hidden" name="mode" value="<%= request.getParameter("mode") != null ? request.getParameter("mode") : "normal" %>">
                <input type="hidden" name="total" value="3">
                <!-- In a real app, this hidden input should be managed securely, 
                     but for simplicity in this university project, we simulate the score tracking here -->
                     
                <!-- Simulated Question 1 -->
                <div class="mb-4">
                    <h3 class="mb-2">1. What is the size of int variable in Java?</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <label><input type="radio" name="q1" value="8 bit"> 8 bit</label>
                        <label><input type="radio" name="q1" value="16 bit"> 16 bit</label>
                        <label><input type="radio" name="q1" value="32 bit"> 32 bit</label>
                        <label><input type="radio" name="q1" value="64 bit"> 64 bit</label>
                    </div>
                </div>

                <!-- Simulated Question 2 -->
                <div class="mb-4">
                    <h3 class="mb-2">2. What is the entry point of a Java program?</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <label><input type="radio" name="q2" value="main()"> main()</label>
                        <label><input type="radio" name="q2" value="start()"> start()</label>
                        <label><input type="radio" name="q2" value="init()"> init()</label>
                        <label><input type="radio" name="q2" value="run()"> run()</label>
                    </div>
                </div>

                <!-- Simulated Question 3 -->
                <div class="mb-4">
                    <h3 class="mb-2">3. Which keyword is used to define a namespace?</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <label><input type="radio" name="q3" value="namespace"> namespace</label>
                        <label><input type="radio" name="q3" value="package"> package</label>
                        <label><input type="radio" name="q3" value="import"> import</label>
                        <label><input type="radio" name="q3" value="include"> include</label>
                    </div>
                </div>
                
                <!-- Temporary Score Input for Demonstration Purposes without Database Questions -->
                <!-- In a full execution, GameEngine would validate against DB -->
                <input type="number" name="score" placeholder="Enter simulated score (0-3)" class="input-field" min="0" max="3" required style="max-width: 250px;">

                <div class="flex-center mt-4">
                    <button type="submit" class="btn">Terminate Session & Submit</button>
                </div>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
