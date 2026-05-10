<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Dashboard - QuizMaster</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<style>
        body {
            background-color: #f4f4f5;
            color: #111827;
            font-family: 'Inter', sans-serif;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.04'/%3E%3C/svg%3E");
        }
        .editorial-title {
            font-family: 'Playfair Display', serif;
            letter-spacing: -0.02em;
        }
        .font-display { font-family: 'Playfair Display', serif; }
</style>
</head>
<body class="bg-[#f4f4f5] text-gray-900 antialiased overflow-x-hidden min-h-screen flex flex-col md:flex-row">

<!-- TopNavBar (Mobile Only) -->
<nav class="md:hidden flex justify-between items-center w-full px-6 py-4 z-50 bg-[#f4f4f5] border-b-2 border-gray-900 sticky top-0">
    <div class="text-2xl font-display font-bold tracking-tighter text-gray-900">QM</div>
</nav>

<!-- SideNavBar (Desktop Only) -->
<nav class="hidden md:flex flex-col p-8 z-40 bg-transparent h-screen w-64 border-r-2 border-gray-900 fixed left-0 top-0">
    <div class="mb-16">
        <h1 class="text-5xl font-display font-bold text-gray-900 mb-2">QM</h1>
    </div>
    
    <div class="flex flex-col gap-6 flex-grow uppercase text-sm font-semibold tracking-widest text-gray-900">
        <!-- Active Tab -->
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity border-b-2 border-gray-900 w-max pb-1" href="${pageContext.request.contextPath}/dashboard">
            <span>Dashboard</span>
        </a>
        <!-- Inactive Tabs -->
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/modes">
            <span>The Arena</span>
        </a>
    </div>
    
    <div class="mt-auto flex flex-col gap-6 uppercase text-sm font-semibold tracking-widest text-gray-900 pt-8 border-t-2 border-gray-900">
        <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/pages/admin.jsp">
            <span>Admin Panel</span>
        </a>
        <% } %>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max text-red-700" href="${pageContext.request.contextPath}/login?action=logout">
            <span>Logout</span>
        </a>
    </div>
</nav>

<!-- Main Content Canvas -->
<main class="flex-1 md:ml-64 p-6 md:p-12 lg:p-20 overflow-y-auto">
    <div class="max-w-7xl mx-auto space-y-12">
        
        <!-- Header -->
        <header class="border-b-2 border-gray-900 pb-8 text-center">
            <h1 class="text-6xl md:text-8xl lg:text-[7rem] leading-none editorial-title font-bold text-gray-900 tracking-tighter uppercase mb-6">
                Commander <%= request.getAttribute("rank_title") != null ? request.getAttribute("rank_title") : "Novice" %>
            </h1>
            <p class="text-lg text-gray-700 max-w-2xl mx-auto font-medium">
                Welcome back to the command center, <%= session.getAttribute("user") %>. Review your latest intellect metrics and prepare for the next engagement.
            </p>
        </header>
        
        <!-- Stats Architectural Blocks -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-0 border-2 border-gray-900 bg-[#f4f4f5]">
            <!-- Stat Block 1 -->
            <div class="p-8 flex flex-col justify-between aspect-square md:aspect-auto md:h-56 border-b-2 md:border-b-0 md:border-r-2 border-gray-900 hover:bg-white transition-colors">
                <div class="text-sm text-gray-900 uppercase tracking-widest font-bold">Total XP</div>
                <div class="text-7xl font-display font-bold text-gray-900 mt-4"><%= request.getAttribute("xp") != null ? request.getAttribute("xp") : "0" %></div>
            </div>
            
            <!-- Stat Block 2 -->
            <div class="p-8 flex flex-col justify-between aspect-square md:aspect-auto md:h-56 border-b-2 md:border-b-0 md:border-r-2 border-gray-900 hover:bg-white transition-colors">
                <div class="text-sm text-gray-900 uppercase tracking-widest font-bold">Quizzes Completed</div>
                <div class="text-7xl font-display font-bold text-gray-900 mt-4"><%= request.getAttribute("total_quizzes") != null ? request.getAttribute("total_quizzes") : "0" %></div>
            </div>
            
            <!-- Stat Block 3 -->
            <div class="p-8 flex flex-col justify-between aspect-square md:aspect-auto md:h-56 hover:bg-white transition-colors">
                <div class="text-sm text-gray-900 uppercase tracking-widest font-bold">Current Streak</div>
                <div class="text-7xl font-display font-bold text-gray-900 mt-4"><%= request.getAttribute("current_streak") != null ? request.getAttribute("current_streak") : "0" %></div>
            </div>
        </section>
        
        <!-- Hero Section / Arena -->
        <section class="grid grid-cols-1 lg:grid-cols-2 border-2 border-gray-900 bg-[#f4f4f5] min-h-[400px]">
            <div class="p-10 md:p-16 flex flex-col justify-center border-b-2 lg:border-b-0 lg:border-r-2 border-gray-900 hover:bg-white transition-colors">
                <h2 class="text-5xl md:text-6xl font-display font-bold text-gray-900 mb-6 leading-tight">Enter the Arena</h2>
                <p class="text-gray-700 text-lg mb-12 font-medium leading-relaxed max-w-md">
                    Challenge your intellect against the adaptive algorithm. Select a mode to begin your next mental conquest. The stakes are higher than ever.
                </p>
                <a href="${pageContext.request.contextPath}/modes" class="text-gray-900 border-b-[3px] border-gray-900 pb-1 font-bold text-sm tracking-widest uppercase hover:text-blue-600 hover:border-blue-600 transition-colors w-max">
                    Select Game Mode
                </a>
            </div>
            <div class="relative overflow-hidden flex items-center justify-center p-8 bg-gray-50 border-gray-900 hover:bg-white transition-colors">
                <img src="${pageContext.request.contextPath}/assets/images/cracked_sphere.png" alt="Arena Image" class="w-full h-full object-contain mix-blend-multiply drop-shadow-xl" style="filter: contrast(1.2) brightness(0.9);">
            </div>
        </section>
        
    </div>
</main>

</body>
</html>
