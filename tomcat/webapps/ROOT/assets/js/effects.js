// Effects Engine for Gamified UI
const Effects = {
    // Basic Audio cache
    audioContext: null,
    
    init() {
        try {
            window.AudioContext = window.AudioContext || window.webkitAudioContext;
            this.audioContext = new AudioContext();
        } catch(e) {
            console.warn("Web Audio API not supported");
        }
    },

    playBeep(freq = 440, type = 'sine', duration = 0.1, vol = 0.1) {
        if (!this.audioContext) return;
        const osc = this.audioContext.createOscillator();
        const gain = this.audioContext.createGain();
        osc.type = type;
        osc.frequency.setValueAtTime(freq, this.audioContext.currentTime);
        gain.gain.setValueAtTime(vol, this.audioContext.currentTime);
        gain.gain.exponentialRampToValueAtTime(0.001, this.audioContext.currentTime + duration);
        osc.connect(gain);
        gain.connect(this.audioContext.destination);
        osc.start();
        osc.stop(this.audioContext.currentTime + duration);
    },

    playCorrect() {
        this.playBeep(600, 'sine', 0.1);
        setTimeout(() => this.playBeep(800, 'sine', 0.2), 100);
    },

    playWrong() {
        this.playBeep(300, 'sawtooth', 0.3, 0.2);
    },

    playHeartbeat() {
        this.playBeep(100, 'sine', 0.2, 0.3);
        setTimeout(() => this.playBeep(100, 'sine', 0.2, 0.3), 200);
    },

    showRoast(message) {
        const toast = document.getElementById('roastToast');
        toast.innerText = message;
        toast.classList.add('show');
        setTimeout(() => toast.classList.remove('show'), 3000);
    },

    flashRed() {
        document.body.classList.add('mode-panic-active');
        setTimeout(() => document.body.classList.remove('mode-panic-active'), 500);
    },
    
    shakeScreen() {
        document.body.classList.add('animate-shake');
        setTimeout(() => document.body.classList.remove('animate-shake'), 400);
    }
};

// Initialize effects on first click to bypass browser auto-play policies
document.addEventListener('click', () => {
    if(!Effects.audioContext) Effects.init();
}, {once:true});
