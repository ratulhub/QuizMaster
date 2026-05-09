// Main App JS - Consolidated Logic

document.addEventListener('DOMContentLoaded', () => {
    // 0. Inject Global Loader
    const loaderHTML = `
        <div class="boxes">
            <div class="box">
                <div></div><div></div><div></div><div></div>
            </div>
            <div class="box">
                <div></div><div></div><div></div><div></div>
            </div>
            <div class="box">
                <div></div><div></div><div></div><div></div>
            </div>
            <div class="box">
                <div></div><div></div><div></div><div></div>
            </div>
        </div>
    `;
    const loaderOverlay = document.createElement('div');
    loaderOverlay.className = 'global-loader-overlay';
    loaderOverlay.innerHTML = loaderHTML;
    document.body.prepend(loaderOverlay);

    // Fade out loader on window load (or immediately if already loaded)
    const hideLoader = () => {
        loaderOverlay.classList.add('hidden');
    };
    
    if (document.readyState === 'complete') {
        hideLoader();
    } else {
        window.addEventListener('load', hideLoader);
    }

    // Handle Back/Forward Cache (BFCache) to ensure loader hides on back navigation
    window.addEventListener('pageshow', hideLoader);

    // Show loader on navigation or form submission
    const showLoader = () => {
        loaderOverlay.classList.remove('hidden');
    };

    document.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', (e) => {
            const href = link.getAttribute('href');
            // Don't show loader for javascript:, #, or target="_blank" links
            if (href && !href.startsWith('#') && !href.startsWith('javascript:') && link.target !== '_blank') {
                showLoader();
            }
        });
    });

    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            showLoader();
        });
    });


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
        if (el.classList.contains('grid')) {
            // If it's a grid container, stagger its children
            Array.from(el.children).forEach((child, childIndex) => {
                child.style.opacity = '0'; // Ensure hidden initially
                child.style.animationDelay = `${childIndex * 0.15}s`;
                observer.observe(child);
            });
        } else {
            // Otherwise apply to the element itself
            el.style.opacity = '0';
            el.style.animationDelay = `${index * 0.15}s`;
            observer.observe(el);
        }
    });

    // 3. Quiz Game Engine Logic (Simplified)
    const quizForm = document.getElementById('quizForm');
    if (quizForm) {
        quizForm.addEventListener('submit', (e) => {
            // Optional client-side validation
            const inputs = quizForm.querySelectorAll('input[type="radio"]:checked');
            if (inputs.length < 3) { // assuming 3 questions
                e.preventDefault();
                hideLoader(); // hide it back if validation failed
                alert('Please answer all questions before submitting.');
            }
        });
    }

});
