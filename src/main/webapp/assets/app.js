// Main App JS - Consolidated Logic

document.addEventListener('DOMContentLoaded', () => {
    // 1. Auth Toggle (Login / Register)
    const toggleAuthLinks = document.querySelectorAll('.toggle-link');
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    const authTitle = document.getElementById('authTitle');

    toggleAuthLinks.forEach(link => {
        link.addEventListener('click', () => {
            if (loginForm && registerForm) {
                if (loginForm.classList.contains('hidden')) {
                    loginForm.classList.remove('hidden');
                    registerForm.classList.add('hidden');
                    if(authTitle) authTitle.innerText = "Welcome Back";
                } else {
                    loginForm.classList.add('hidden');
                    registerForm.classList.remove('hidden');
                    if(authTitle) authTitle.innerText = "Create Account";
                }
            }
        });
    });

    // 2. Simple Cinematic Animations Observer
    const observerOptions = {
        threshold: 0.1,
        rootMargin: "0px 0px -50px 0px"
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fade-in');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.stagger-animate').forEach((el, index) => {
        el.style.animationDelay = `${index * 0.15}s`;
        observer.observe(el);
    });

    // 3. Quiz Game Engine Logic (Simplified)
    const quizForm = document.getElementById('quizForm');
    if (quizForm) {
        quizForm.addEventListener('submit', (e) => {
            // Optional client-side validation
            const inputs = quizForm.querySelectorAll('input[type="radio"]:checked');
            if (inputs.length < 3) { // assuming 3 questions
                e.preventDefault();
                alert('Please answer all questions before submitting.');
            }
        });
    }

    // Add CSS rule for hidden class dynamically to keep it clean
    const style = document.createElement('style');
    style.innerHTML = `.hidden { display: none !important; }`;
    document.head.appendChild(style);
});
