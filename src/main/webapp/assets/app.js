/**
 * QuizMaster App JS
 * Handles UI interactions, toasts, simple particles, and loader.
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Loader Logic
    const loader = document.getElementById('globalLoader');
    if (loader) {
        setTimeout(() => {
            loader.classList.add('hidden');
        }, 500); // Small delay to allow initial render
    }

    // 2. Simple Particles System (Vanilla JS, no heavy dependencies)
    initParticles();

    // 3. Setup Toast Container
    if (!document.getElementById('toast-container')) {
        const toastContainer = document.createElement('div');
        toastContainer.id = 'toast-container';
        document.body.appendChild(toastContainer);
    }
});

// Toast Notification System
window.showToast = function(message, type = 'success') {
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    
    // Icon based on type
    const icon = type === 'error' ? '⚠️' : (type === 'success' ? '✅' : 'ℹ️');
    
    toast.innerHTML = `
        <div style="font-size: 1.2rem;">${icon}</div>
        <div>${message}</div>
    `;
    
    container.appendChild(toast);
    
    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 10);
    
    // Remove after 3 seconds
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
};

// Particles System
function initParticles() {
    const canvas = document.createElement('canvas');
    canvas.id = 'particles-js';
    document.body.prepend(canvas);
    
    const ctx = canvas.getContext('2d');
    let width, height, particles;
    
    function resize() {
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
    }
    
    window.addEventListener('resize', resize);
    resize();
    
    class Particle {
        constructor() {
            this.x = Math.random() * width;
            this.y = Math.random() * height;
            this.size = Math.random() * 2 + 0.5;
            this.speedX = Math.random() * 1 - 0.5;
            this.speedY = Math.random() * 1 - 0.5;
            this.color = Math.random() > 0.5 ? 'rgba(0, 229, 255, 0.4)' : 'rgba(138, 43, 226, 0.4)';
        }
        update() {
            this.x += this.speedX;
            this.y += this.speedY;
            if (this.x > width) this.x = 0;
            if (this.x < 0) this.x = width;
            if (this.y > height) this.y = 0;
            if (this.y < 0) this.y = height;
        }
        draw() {
            ctx.fillStyle = this.color;
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
            ctx.fill();
        }
    }
    
    function init() {
        particles = [];
        const numParticles = Math.min(window.innerWidth / 15, 100); // Scale by screen size, max 100
        for (let i = 0; i < numParticles; i++) {
            particles.push(new Particle());
        }
    }
    
    function animate() {
        ctx.clearRect(0, 0, width, height);
        for (let i = 0; i < particles.length; i++) {
            particles[i].update();
            particles[i].draw();
        }
        requestAnimationFrame(animate);
    }
    
    init();
    animate();
}

// Intercept forms for loader (optional smooth UX)
document.querySelectorAll('form:not([target])').forEach(form => {
    form.addEventListener('submit', () => {
        const loader = document.getElementById('globalLoader');
        if (loader) loader.classList.remove('hidden');
    });
});
