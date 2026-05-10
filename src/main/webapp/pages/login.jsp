<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Login - QuizMaster</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
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
              },
              "fontFamily": {
                      "ui-medium": ["Inter"],
                      "label-caps": ["Inter"],
                      "headline-sm": ["Playfair Display"],
                      "headline-md": ["Playfair Display"],
                      "display-lg-mobile": ["Playfair Display"],
                      "body-md": ["Inter"],
                      "display-lg": ["Playfair Display"],
                      "body-lg": ["Inter"]
              }
            }
          }
        }
      </script>
<style>
        .material-symbols-outlined {
          font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 24;
        }
      </style>
</head>
<body class="bg-surface-bright min-h-screen flex items-center justify-center p-6 md:p-16 antialiased selection:bg-primary-container selection:text-on-primary-container">
<!-- Museum Canvas Wrapper -->
<main class="w-full max-w-[480px] relative">
<!-- Artifact Card -->
<div class="bg-surface-container-lowest border border-outline-variant/60 p-10 md:p-14 flex flex-col items-center relative z-10">
<!-- Branding Header -->
<header class="w-full flex flex-col items-center mb-12">
<!-- QuizMaster Logo -->
<div class="flex items-center justify-center mb-8">
    <span class="font-label-caps text-xs text-primary uppercase tracking-[0.15em] border border-primary px-4 py-2">QuizMaster</span>
</div>
<h1 class="font-display-lg-mobile md:text-[48px] text-on-surface text-center leading-tight mb-4" style="font-family: 'Playfair Display', serif; font-weight: 700; letter-spacing: -0.02em;">
    Welcome Back
</h1>
<p class="text-[16px] text-on-surface-variant text-center max-w-[280px]" style="font-family: 'Inter', sans-serif;">
    Enter your credentials to access the editorial selection.
</p>

<% String error = request.getParameter("error");
   if (error != null) { %>
   <div class="text-error mt-4 w-full text-center bg-error-container text-on-error-container p-3 text-sm font-medium"><%= error %></div>
<% } %>

<% String success = request.getParameter("success");
   if (success != null) { %>
   <div class="mt-4 w-full text-center bg-primary-container text-on-primary-container p-3 text-sm font-medium"><%= success %></div>
<% } %>

</header>
<!-- Authentication Form -->
<form action="${pageContext.request.contextPath}/login" method="post" class="w-full flex flex-col gap-8">
<!-- Username Field -->
<div class="flex flex-col gap-2 group">
<label class="text-[12px] uppercase tracking-[0.1em] text-on-surface-variant font-semibold transition-colors group-focus-within:text-primary" for="username" style="font-family: 'Inter', sans-serif;">
    Username
</label>
<div class="relative">
<input name="username" class="w-full bg-transparent border-0 border-b border-outline-variant py-3 px-0 text-[16px] text-on-surface placeholder:text-outline-variant/70 focus:ring-0 focus:border-primary focus:bg-surface-container-low transition-all duration-300 outline-none" id="username" placeholder="Enter your identifier" required="" type="text" style="font-family: 'Inter', sans-serif;"/>
</div>
</div>
<!-- Password Field -->
<div class="flex flex-col gap-2 group">
<div class="flex justify-between items-baseline">
<label class="text-[12px] uppercase tracking-[0.1em] text-on-surface-variant font-semibold transition-colors group-focus-within:text-primary" for="password" style="font-family: 'Inter', sans-serif;">
    Password
</label>
</div>
<div class="relative">
<input name="password" class="w-full bg-transparent border-0 border-b border-outline-variant py-3 px-0 text-[16px] text-on-surface placeholder:text-outline-variant/70 focus:ring-0 focus:border-primary focus:bg-surface-container-low transition-all duration-300 outline-none" id="password" placeholder="••••••••" required="" type="password" style="font-family: 'Inter', sans-serif;"/>
</div>
</div>
<!-- Primary Action Button -->
<button class="mt-6 w-full bg-primary text-on-primary py-4 px-6 flex items-center justify-between hover:bg-on-primary-fixed-variant transition-colors duration-300 group cursor-pointer border border-transparent" type="submit">
<span class="text-[14px] font-medium tracking-wide" style="font-family: 'Inter', sans-serif;">Sign In</span>
<span class="material-symbols-outlined text-[20px] group-hover:translate-x-1 transition-transform duration-300" data-icon="arrow_forward">arrow_forward</span>
</button>
</form>
<!-- Footer Links -->
<footer class="mt-12 text-center w-full pt-8 border-t border-outline-variant/30">
<span class="text-[16px] text-on-surface-variant" style="font-family: 'Inter', sans-serif;">
    New to QuizMaster? 
</span>
<a class="text-[14px] font-medium text-primary border-b border-primary/30 pb-0.5 hover:border-primary hover:text-on-primary-fixed-variant transition-all duration-300 ml-1" href="${pageContext.request.contextPath}/pages/register.jsp" style="font-family: 'Inter', sans-serif;">
    Sign Up
</a>
</footer>
</div>
<!-- Subtle background decorative element (Abstract Glass Panel) -->
<div class="absolute -top-8 -right-8 w-64 h-64 bg-surface-container-highest/20 backdrop-blur-3xl border border-outline-variant/20 -z-10 pointer-events-none"></div>
<div class="absolute -bottom-12 -left-12 w-48 h-48 bg-primary-container/10 backdrop-blur-2xl border border-primary-container/20 -z-10 pointer-events-none"></div>
</main>
</body></html>
