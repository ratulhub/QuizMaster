<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>QuizMaster - Login</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
<script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "on-primary-fixed": "#001a41",
                      "primary-fixed": "#d8e2ff",
                      "surface": "#f9f9ff",
                      "on-secondary-fixed": "#141c26",
                      "tertiary-fixed": "#e1e3e4",
                      "on-primary-fixed-variant": "#004494",
                      "on-error-container": "#93000a",
                      "secondary-container": "#dbe3f1",
                      "on-secondary-fixed-variant": "#3f4752",
                      "tertiary": "#595c5d",
                      "on-primary": "#ffffff",
                      "primary-fixed-dim": "#adc6ff",
                      "surface-dim": "#d8d9e3",
                      "surface-container-low": "#f2f3fd",
                      "on-secondary": "#ffffff",
                      "on-tertiary": "#ffffff",
                      "error": "#ba1a1a",
                      "primary-container": "#2771df",
                      "outline": "#727785",
                      "on-tertiary-fixed": "#191c1d",
                      "on-surface": "#191b22",
                      "surface-bright": "#f9f9ff",
                      "tertiary-container": "#727576",
                      "surface-container": "#ecedf7",
                      "on-error": "#ffffff",
                      "tertiary-fixed-dim": "#c4c7c8",
                      "surface-tint": "#005ac1",
                      "inverse-surface": "#2e3038",
                      "background": "#f9f9ff",
                      "surface-container-lowest": "#ffffff",
                      "on-tertiary-container": "#fbfdfe",
                      "on-background": "#191b22",
                      "inverse-on-surface": "#eff0fa",
                      "inverse-primary": "#adc6ff",
                      "on-surface-variant": "#424753",
                      "surface-container-highest": "#e1e2eb",
                      "secondary": "#575f6b",
                      "secondary-fixed-dim": "#bfc7d4",
                      "on-primary-container": "#fefcff",
                      "outline-variant": "#c2c6d5",
                      "surface-container-high": "#e7e7f1",
                      "primary": "#0058bd",
                      "secondary-fixed": "#dbe3f1",
                      "on-secondary-container": "#5d6571",
                      "on-tertiary-fixed-variant": "#444748",
                      "surface-variant": "#e1e2eb",
                      "error-container": "#ffdad6"
              },
              "borderRadius": {
                      "DEFAULT": "1rem",
                      "lg": "2rem",
                      "xl": "3rem",
                      "full": "9999px"
              },
              "spacing": {
                      "container-max": "1120px",
                      "xxl": "48px",
                      "sm": "12px",
                      "gutter": "24px",
                      "lg": "24px",
                      "xl": "32px",
                      "md": "16px",
                      "base": "8px",
                      "xs": "4px"
              },
              "fontFamily": {
                      "headline-lg": ["Outfit"],
                      "body-lg": ["Outfit"],
                      "title-md": ["Outfit"],
                      "headline-sm": ["Outfit"],
                      "label-lg": ["Outfit"],
                      "headline-md": ["Outfit"],
                      "body-md": ["Outfit"],
                      "title-lg": ["Outfit"],
                      "display-lg": ["Outfit"],
                      "headline-lg-mobile": ["Outfit"]
              },
              "fontSize": {
                      "headline-lg": ["32px", {"lineHeight": "40px", "fontWeight": "500"}],
                      "body-lg": ["16px", {"lineHeight": "24px", "letterSpacing": "0.5px", "fontWeight": "400"}],
                      "title-md": ["16px", {"lineHeight": "24px", "letterSpacing": "0.15px", "fontWeight": "500"}],
                      "headline-sm": ["24px", {"lineHeight": "32px", "fontWeight": "500"}],
                      "label-lg": ["14px", {"lineHeight": "20px", "letterSpacing": "0.1px", "fontWeight": "500"}],
                      "headline-md": ["28px", {"lineHeight": "36px", "fontWeight": "500"}],
                      "body-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.25px", "fontWeight": "400"}],
                      "title-lg": ["22px", {"lineHeight": "28px", "fontWeight": "500"}],
                      "display-lg": ["57px", {"lineHeight": "64px", "letterSpacing": "-0.02em", "fontWeight": "600"}],
                      "headline-lg-mobile": ["28px", {"lineHeight": "36px", "fontWeight": "600"}]
              }
      },
          },
        }
    </script>
<style>
        body { font-family: 'Outfit', sans-serif; }
        .shadow-level-1 { box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.05); }
        .shadow-level-2 { box-shadow: 0px 4px 12px rgba(66, 133, 244, 0.12); }
    </style>
</head>
<body class="bg-surface-container-low min-h-screen flex items-center justify-center p-md text-on-surface antialiased">
<main class="w-full max-w-[480px]">
<!-- Main Card -->
<div class="bg-surface rounded-xl shadow-level-1 p-xl border border-outline-variant/10">
<!-- Header -->
<div class="text-center mb-xl">
<h1 id="authTitle" class="font-headline-md text-headline-md text-primary font-bold tracking-tight">Welcome Back</h1>

<% String error = request.getParameter("error");
   if (error != null) { %>
   <div class="error-msg mt-4"><%= error %></div>
<% } %>

<% String success = request.getParameter("success");
   if (success != null) { %>
   <div style="color: var(--md-primary); background-color: var(--md-secondary-container); padding: 12px; border-radius: 8px; margin-top: 16px; text-align: center;"><%= success %></div>
<% } %>

</div>
<!-- Toggle (Login/Signup) -->
<div class="bg-surface-container p-xs rounded-full flex mb-xl relative">
<button id="toggle-login" class="flex-1 py-sm rounded-full bg-surface shadow-level-1 text-primary font-label-lg text-label-lg transition-all z-10 toggle-link" type="button">
                    Log In
                </button>
<button id="toggle-signup" class="flex-1 py-sm rounded-full text-on-surface-variant font-label-lg text-label-lg hover:text-on-surface transition-all z-10 toggle-link" type="button">
                    Sign Up
                </button>
</div>

<!-- Login Form -->
<form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" class="flex flex-col gap-md">
<!-- Username Input -->
<div class="relative">
<span class="material-symbols-outlined absolute left-gutter top-1/2 -translate-y-1/2 text-outline">person</span>
<input name="username" class="w-full rounded-full border border-outline-variant bg-surface pl-[56px] pr-gutter py-md font-body-md text-body-md text-on-surface placeholder:text-on-surface-variant focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all" placeholder="Username" required="" type="text"/>
</div>
<!-- Password Input -->
<div class="relative">
<span class="material-symbols-outlined absolute left-gutter top-1/2 -translate-y-1/2 text-outline">lock</span>
<input name="password" class="w-full rounded-full border border-outline-variant bg-surface pl-[56px] pr-gutter py-md font-body-md text-body-md text-on-surface placeholder:text-on-surface-variant focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all" placeholder="Password" required="" type="password"/>
</div>

<!-- Primary Action -->
<button class="w-full bg-primary text-on-primary rounded-full py-md mt-sm font-label-lg text-label-lg shadow-level-2 hover:bg-surface-tint active:scale-[0.98] transition-all flex items-center justify-center gap-sm" type="submit">
                    Sign In
                    <span class="material-symbols-outlined text-[20px]">arrow_forward</span>
</button>
</form>

<!-- Register Form -->
<form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" class="flex flex-col gap-md hidden">
<!-- Username Input -->
<div class="relative">
<span class="material-symbols-outlined absolute left-gutter top-1/2 -translate-y-1/2 text-outline">person</span>
<input name="username" class="w-full rounded-full border border-outline-variant bg-surface pl-[56px] pr-gutter py-md font-body-md text-body-md text-on-surface placeholder:text-on-surface-variant focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all" placeholder="Choose Username" required="" type="text"/>
</div>
<!-- Password Input -->
<div class="relative">
<span class="material-symbols-outlined absolute left-gutter top-1/2 -translate-y-1/2 text-outline">lock</span>
<input name="password" class="w-full rounded-full border border-outline-variant bg-surface pl-[56px] pr-gutter py-md font-body-md text-body-md text-on-surface placeholder:text-on-surface-variant focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all" placeholder="Create Password" required="" type="password"/>
</div>
<!-- Primary Action -->
<button class="w-full bg-primary text-on-primary rounded-full py-md mt-sm font-label-lg text-label-lg shadow-level-2 hover:bg-surface-tint active:scale-[0.98] transition-all flex items-center justify-center gap-sm" type="submit">
                    Create Profile
                    <span class="material-symbols-outlined text-[20px]">arrow_forward</span>
</button>
</form>

</div>
</main>
<script>
    document.querySelectorAll('.toggle-link').forEach(btn => {
        btn.addEventListener('click', () => {
            const btnLogin = document.getElementById('toggle-login');
            const btnSignup = document.getElementById('toggle-signup');
            if (btnLogin.classList.contains('bg-surface')) {
                // Currently on login, switch to signup
                btnLogin.classList.remove('bg-surface', 'shadow-level-1', 'text-primary');
                btnLogin.classList.add('text-on-surface-variant');
                
                btnSignup.classList.add('bg-surface', 'shadow-level-1', 'text-primary');
                btnSignup.classList.remove('text-on-surface-variant');
            } else {
                // Switch to login
                btnSignup.classList.remove('bg-surface', 'shadow-level-1', 'text-primary');
                btnSignup.classList.add('text-on-surface-variant');
                
                btnLogin.classList.add('bg-surface', 'shadow-level-1', 'text-primary');
                btnLogin.classList.remove('text-on-surface-variant');
            }
        });
    });
</script>
<script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body></html>
