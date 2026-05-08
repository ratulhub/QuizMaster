<%@ page session="true" %>
<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}
String mode = request.getParameter("mode");
if(mode == null) mode = "NORMAL";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= mode %> - QuizMaster Arena</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/vars.css">
    <link rel="stylesheet" href="../../assets/css/animations.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
    <style>
        body { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh; overflow: hidden; }
        
        .game-header { position: absolute; top: 0; left: 0; right: 0; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; z-index: 10; }
        
        .timer-bar-container { position: absolute; top: 0; left: 0; right: 0; height: 5px; background: rgba(0,0,0,0.5); z-index: 20; }
        .timer-bar { height: 100%; background: var(--accent-blue); width: 100%; transition: width 1s linear, background 0.3s; }
        
        .arena { max-width: 800px; width: 100%; text-align: center; position: relative; z-index: 5; }
        
        .question-box { font-size: 2rem; font-weight: 800; margin-bottom: 40px; line-height: 1.3; min-height: 100px; }
        
        .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        
        .option-btn { background: var(--glass-bg); border: 2px solid var(--glass-border); padding: 25px; border-radius: 16px; font-size: 1.2rem; font-weight: 600; color: white; cursor: pointer; transition: all 0.2s; position: relative; overflow: hidden; text-align: left; display: flex; align-items: center; }
        .option-btn:hover { border-color: var(--accent-blue); background: rgba(59,130,246,0.1); transform: scale(1.02); }
        .option-btn .letter { background: rgba(255,255,255,0.1); width: 40px; height: 40px; display: inline-flex; justify-content: center; align-items: center; border-radius: 8px; margin-right: 15px; font-weight: 800; }
        
        .option-btn.correct { background: rgba(34,197,94,0.2); border-color: #4ade80; animation: pulse 0.5s; }
        .option-btn.wrong { background: rgba(239,68,68,0.2); border-color: #f87171; animation: shake 0.4s; }
        
        /* Roast Toast */
        .roast-toast { position: fixed; bottom: -100px; left: 50%; transform: translateX(-50%); background: #ef4444; color: white; padding: 20px 40px; border-radius: 50px; font-weight: bold; font-size: 1.2rem; transition: bottom 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275); z-index: 100; box-shadow: 0 10px 30px rgba(239,68,68,0.5); }
        .roast-toast.show { bottom: 40px; }

        /* Fullscreen warning */
        .fullscreen-warning { position: fixed; inset: 0; background: rgba(239,68,68,0.9); z-index: 1000; display: none; flex-direction: column; justify-content: center; align-items: center; font-size: 3rem; font-weight: 900; }

        #particles { position: absolute; inset: 0; pointer-events: none; z-index: 1; }
    </style>
</head>
<body data-mode="<%= mode %>">

    <div class="timer-bar-container"><div class="timer-bar" id="timerBar"></div></div>

    <div class="game-header">
        <div class="badge" style="font-size:1rem; background:rgba(255,255,255,0.1); border-color:rgba(255,255,255,0.2); color:white;">
            MODE: <span style="color:var(--accent-blue)"><%= mode %></span>
        </div>
        <div style="font-size:1.5rem; font-weight:800; color:var(--text-secondary);">
            Score: <span id="scoreDisplay" style="color:white;">0</span>
        </div>
    </div>

    <canvas id="particles"></canvas>

    <div class="arena animate-slide-up" id="gameArena">
        <div class="badge" style="margin-bottom:20px; display:inline-block;" id="qCounter">Question 1/10</div>
        
        <div class="question-box" id="questionText">
            Loading next challenge from the database...
        </div>

        <div class="options-grid" id="optionsGrid">
            <button class="option-btn" onclick="checkAnswer('A')"><span class="letter">A</span> <span id="optA">Loading...</span></button>
            <button class="option-btn" onclick="checkAnswer('B')"><span class="letter">B</span> <span id="optB">Loading...</span></button>
            <button class="option-btn" onclick="checkAnswer('C')"><span class="letter">C</span> <span id="optC">Loading...</span></button>
            <button class="option-btn" onclick="checkAnswer('D')"><span class="letter">D</span> <span id="optD">Loading...</span></button>
        </div>
    </div>

    <div class="roast-toast" id="roastToast">You call that an answer?!</div>

    <div class="fullscreen-warning" id="cheatWarning">
        WARNING: TAB SWITCH DETECTED<br>
        <span style="font-size:1.5rem; margin-top:20px;">Return immediately or fail.</span>
    </div>

    <!-- Hidden form for submitting final score to backend -->
    <form id="scoreForm" action="../../GameEngineServlet" method="POST" style="display:none;">
        <input type="hidden" name="mode" value="<%= mode %>">
        <input type="hidden" name="score" id="finalScoreInput">
        <input type="hidden" name="total" id="finalTotalInput">
    </form>

    <script src="../../assets/js/effects.js"></script>
    <script src="../../assets/js/game_engine.js"></script>
</body>
</html>
