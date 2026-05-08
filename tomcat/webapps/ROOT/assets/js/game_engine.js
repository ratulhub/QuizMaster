// Core Game Logic

const GameMode = document.body.getAttribute('data-mode') || 'NORMAL';

let currentQuestion = 0;
let score = 0;
let totalQuestions = 5; // Fallback
let isAnswered = false;
let timer = null;
let timeLeft = 100; // Percentage

// Fallback dummy questions for presentation if DB is empty
const dummyQuestions = [
    { q: "What is the primary key concept in RDBMS?", options: {A:"A unique identifier", B:"A data type", C:"A table", D:"A query"}, correct: "A" },
    { q: "Which of the following is NOT a Java access specifier?", options: {A:"Public", B:"Private", C:"Friendly", D:"Protected"}, correct: "C" },
    { q: "What does HTML stand for?", options: {A:"Hyper Text Markup Language", B:"High Text Machine Language", C:"Hyperlink Tool Multi Language", D:"Hyper Tool Machine Language"}, correct: "A" },
    { q: "In OOP, what is polymorphism?", options: {A:"Hiding data", B:"Many forms", C:"Binding data", D:"Inheriting classes"}, correct: "B" },
    { q: "Which HTTP method is idempotent?", options: {A:"POST", B:"PUT", C:"PATCH", D:"CONNECT"}, correct: "B" }
];

const roastMessages = [
    "My grandmother codes better than you!",
    "Are you trying to fail or is this natural talent?",
    "ChatGPT wouldn't even help you with that answer.",
    "Even Internet Explorer is faster than your brain right now.",
    "Did you learn programming from a TikTok video?"
];

function initGame() {
    // In a real app, we would fetch questions from an API endpoint here.
    // fetch('/api/questions?mode=' + GameMode).then(...)
    
    // Applying Mode Modifiers
    applyModeModifiers();
    loadQuestion();
}

function applyModeModifiers() {
    if (GameMode === 'TEACHER_EXAM') {
        document.addEventListener("visibilitychange", () => {
            if (document.visibilityState === 'hidden') {
                document.getElementById('cheatWarning').style.display = 'flex';
                Effects.playWrong();
                // Real app: submit score immediately or deduct points
            } else {
                document.getElementById('cheatWarning').style.display = 'none';
            }
        });
    }

    if (GameMode === 'PANIC') {
        setInterval(() => {
            if(!isAnswered) Effects.playHeartbeat();
        }, 1000);
    }
}

function loadQuestion() {
    if (currentQuestion >= dummyQuestions.length) {
        endGame();
        return;
    }

    isAnswered = false;
    const q = dummyQuestions[currentQuestion];
    
    document.getElementById('qCounter').innerText = `Question ${currentQuestion + 1}/${dummyQuestions.length}`;
    document.getElementById('questionText').innerText = q.q;
    
    document.getElementById('optA').innerText = q.options.A;
    document.getElementById('optB').innerText = q.options.B;
    document.getElementById('optC').innerText = q.options.C;
    document.getElementById('optD').innerText = q.options.D;

    // Reset button states
    document.querySelectorAll('.option-btn').forEach(btn => {
        btn.classList.remove('correct', 'wrong');
        btn.disabled = false;
    });

    // Reset Timer
    timeLeft = 100;
    document.getElementById('timerBar').style.width = '100%';
    clearInterval(timer);
    
    let speed = GameMode === 'SPEEDRUN' ? 2 : (GameMode === 'PANIC' ? 1.5 : 0.5);
    
    timer = setInterval(() => {
        timeLeft -= speed;
        document.getElementById('timerBar').style.width = timeLeft + '%';
        
        if(GameMode === 'PANIC' && timeLeft < 30) {
            document.getElementById('timerBar').style.background = '#ef4444';
            if(Math.random() > 0.8) Effects.shakeScreen();
        } else {
            document.getElementById('timerBar').style.background = 'var(--accent-blue)';
        }

        if (timeLeft <= 0) {
            clearInterval(timer);
            checkAnswer('TIMEOUT');
        }
    }, 100);
}

function checkAnswer(selected) {
    if (isAnswered) return;
    isAnswered = true;
    clearInterval(timer);

    const q = dummyQuestions[currentQuestion];
    const buttons = document.querySelectorAll('.option-btn');
    
    // Disable all
    buttons.forEach(b => b.disabled = true);

    const correctIndex = q.correct.charCodeAt(0) - 65; // A=0, B=1...
    
    if (selected === q.correct) {
        Effects.playCorrect();
        buttons[correctIndex].classList.add('correct');
        score++;
        document.getElementById('scoreDisplay').innerText = score;
    } else {
        Effects.playWrong();
        if(selected !== 'TIMEOUT') {
            const selectedIndex = selected.charCodeAt(0) - 65;
            buttons[selectedIndex].classList.add('wrong');
        }
        buttons[correctIndex].classList.add('correct');

        handleWrongAnswerMode();
    }

    setTimeout(() => {
        currentQuestion++;
        loadQuestion();
    }, 2000);
}

function handleWrongAnswerMode() {
    if (GameMode === 'ROAST') {
        const roast = roastMessages[Math.floor(Math.random() * roastMessages.length)];
        Effects.showRoast(roast);
    }
    
    if (GameMode === 'SUDDEN_DEATH') {
        setTimeout(() => endGame(), 1000); // Instantly end
    }
    
    if (GameMode === 'PANIC' || GameMode === 'HORROR') {
        Effects.flashRed();
        Effects.shakeScreen();
    }
}

function endGame() {
    document.getElementById('finalScoreInput').value = score;
    document.getElementById('finalTotalInput').value = dummyQuestions.length;
    // Submit form to Java Servlet to calculate XP and save to DB
    document.getElementById('scoreForm').submit();
}

// Start
initGame();
