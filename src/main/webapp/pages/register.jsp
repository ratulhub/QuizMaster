<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>QuizMaster - Join the Arena</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&amp;family=Playfair+Display:wght@500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-tertiary-fixed": "#171c1f",
                        "surface-container-lowest": "#ffffff",
                        "outline-variant": "#bec8ce",
                        "on-error": "#ffffff",
                        "primary-container": "#7dd3fc",
                        "surface-container-low": "#f1f4f7",
                        "secondary-fixed": "#e0e3e5",
                        "on-secondary-fixed": "#191c1e",
                        "inverse-surface": "#2d3134",
                        "primary-fixed": "#c0e8ff",
                        "inverse-on-surface": "#eef1f4",
                        "on-secondary": "#ffffff",
                        "on-primary-container": "#005b78",
                        "surface-bright": "#f7fafd",
                        "surface-variant": "#e0e3e6",
                        "on-secondary-fixed-variant": "#444749",
                        "on-background": "#181c1f",
                        "error": "#ba1a1a",
                        "primary": "#006686",
                        "on-primary": "#ffffff",
                        "surface-tint": "#006686",
                        "on-surface-variant": "#3f484e",
                        "tertiary-container": "#c5c9cd",
                        "surface-container-high": "#e5e8ec",
                        "tertiary-fixed": "#dfe3e7",
                        "tertiary-fixed-dim": "#c3c7cb",
                        "outline": "#6f787e",
                        "surface-dim": "#d7dade",
                        "on-error-container": "#93000a",
                        "error-container": "#ffdad6",
                        "background": "#f7fafd",
                        "on-secondary-container": "#626567",
                        "secondary-container": "#e0e3e5",
                        "surface": "#f7fafd",
                        "secondary-fixed-dim": "#c4c7c9",
                        "on-tertiary": "#ffffff",
                        "on-primary-fixed-variant": "#004d66",
                        "primary-fixed-dim": "#7bd1fa",
                        "inverse-primary": "#7bd1fa",
                        "on-tertiary-container": "#505458",
                        "on-surface": "#181c1f",
                        "on-primary-fixed": "#001e2b",
                        "secondary": "#5c5f61",
                        "on-tertiary-fixed-variant": "#43474b",
                        "tertiary": "#5a5f62",
                        "surface-container-highest": "#e0e3e6",
                        "surface-container": "#ebeef1"
                    }
                }
            }
        }
    </script>
<style>
        .glass-panel {
            background-color: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }
    </style>
</head>
<body class="bg-surface-bright min-h-screen flex items-center justify-center p-6 md:p-12 relative overflow-hidden">
<div class="absolute inset-0 opacity-20 pointer-events-none" style="background-image: radial-gradient(circle at 50% 0%, #7dd3fc 0%, transparent 50%);"></div>
<main class="w-full max-w-md relative z-10">
<div class="glass-panel border border-outline-variant rounded p-10 md:p-14 flex flex-col gap-10 shadow-lg">
<header class="flex flex-col gap-3 text-center">
<span class="text-[12px] text-primary uppercase tracking-[0.1em] font-semibold border border-primary/30 inline-block px-3 py-1 self-center" style="font-family: 'Inter', sans-serif;">QuizMaster</span>
<h1 class="text-[36px] text-on-tertiary-fixed font-bold leading-tight" style="font-family: 'Playfair Display', serif;">Join the Arena</h1>
<p class="text-[16px] text-on-surface-variant" style="font-family: 'Inter', sans-serif;">Forge your path to intellectual mastery.</p>

<% String error = request.getParameter("error");
   if (error != null) { %>
   <div class="text-error mt-2 w-full text-center bg-error-container text-on-error-container p-3 text-sm font-medium"><%= error %></div>
<% } %>

</header>
<form action="${pageContext.request.contextPath}/register" method="post" class="flex flex-col gap-8">
<div class="flex flex-col gap-2 relative">
<label class="text-[12px] uppercase tracking-[0.1em] text-on-surface-variant font-semibold pl-1" for="username" style="font-family: 'Inter', sans-serif;">Username</label>
<div class="relative flex items-center">
<span class="material-symbols-outlined absolute left-0 text-on-surface-variant/50 pb-2 pl-1" style="font-variation-settings: 'FILL' 0;">person</span>
<input name="username" class="w-full bg-transparent border-0 border-b border-outline-variant text-on-surface text-[16px] pl-9 pb-3 pt-2 focus:ring-0 focus:border-b-primary focus:bg-surface-container-low/50 transition-all duration-300 placeholder:text-on-surface-variant/40 outline-none" id="username" placeholder="Enter a unique handle" required="" type="text" style="font-family: 'Inter', sans-serif;"/>
</div>
</div>
<div class="flex flex-col gap-2 relative">
<label class="text-[12px] uppercase tracking-[0.1em] text-on-surface-variant font-semibold pl-1" for="password" style="font-family: 'Inter', sans-serif;">Password</label>
<div class="relative flex items-center">
<span class="material-symbols-outlined absolute left-0 text-on-surface-variant/50 pb-2 pl-1" style="font-variation-settings: 'FILL' 0;">lock</span>
<input name="password" class="w-full bg-transparent border-0 border-b border-outline-variant text-on-surface text-[16px] pl-9 pr-10 pb-3 pt-2 focus:ring-0 focus:border-b-primary focus:bg-surface-container-low/50 transition-all duration-300 placeholder:text-on-surface-variant/40 outline-none" id="password" placeholder="Create a secure password" required="" type="password" style="font-family: 'Inter', sans-serif;"/>
</div>
</div>
<button class="w-full mt-2 bg-primary text-on-primary text-[14px] font-medium py-4 px-8 rounded flex items-center justify-center gap-3 hover:bg-on-primary-fixed-variant transition-colors duration-300 group" type="submit" style="font-family: 'Inter', sans-serif;">
    Create Account
    <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform duration-300" style="font-variation-settings: 'FILL' 0;">arrow_forward</span>
</button>
</form>
<div class="text-center mt-2 border-t border-outline-variant/30 pt-8">
<p class="text-[16px] text-on-surface-variant" style="font-family: 'Inter', sans-serif;">
    Already have an account? 
    <a class="text-primary text-[14px] font-medium hover:text-on-primary-fixed-variant transition-colors ml-1" href="${pageContext.request.contextPath}/pages/login.jsp">Sign In</a>
</p>
</div>
</div>
</main>
</body></html>
