<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Results - QuizMaster</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <style>
        body {
            background-color: #f4f4f4;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.04'/%3E%3C/svg%3E");
            color: #000;
            font-family: 'Inter', sans-serif;
        }
        .font-display { font-family: 'Playfair Display', serif; }
        .font-label-caps { font-family: 'Inter', sans-serif; text-transform: uppercase; letter-spacing: 0.1em; }
    </style>
</head>
<body class="antialiased min-h-screen flex items-center justify-center p-6 md:p-16 selection:bg-black selection:text-white">

<main class="w-full max-w-3xl mx-auto">
    <!-- Result Card -->
    <div class="border-2 border-black bg-[#f4f4f5]">
        
        <!-- Header -->
        <div class="p-8 md:p-12 border-b-2 border-black text-center">
            <div class="text-sm font-label-caps tracking-widest text-gray-500 mb-4">Session Complete</div>
            <h1 class="text-5xl md:text-7xl font-display font-bold leading-none tracking-tighter">
                Mission Debrief
            </h1>
            <div class="mt-4 inline-block px-4 py-1.5 text-xs font-label-caps tracking-widest uppercase border border-black bg-white/50">
                MODE: <%= request.getAttribute("mode") != null ? request.getAttribute("mode").toString().toUpperCase() : "UNKNOWN" %>
            </div>
        </div>
        
        <!-- Score Display -->
        <div class="grid grid-cols-1 md:grid-cols-3 border-b-2 border-black">
            <!-- Score -->
            <div class="p-8 md:p-12 flex flex-col justify-between border-b-2 md:border-b-0 md:border-r-2 border-black text-center hover:bg-white transition-colors">
                <div class="text-sm font-label-caps tracking-widest font-bold mb-4">Score</div>
                <div class="text-7xl md:text-8xl font-display font-bold leading-none">
                    <%= request.getAttribute("score") != null ? request.getAttribute("score") : "0" %><span class="text-4xl text-gray-400">/<%= request.getAttribute("total") != null ? request.getAttribute("total") : "0" %></span>
                </div>
            </div>
            
            <!-- XP Earned -->
            <div class="p-8 md:p-12 flex flex-col justify-between border-b-2 md:border-b-0 md:border-r-2 border-black text-center hover:bg-white transition-colors">
                <div class="text-sm font-label-caps tracking-widest font-bold mb-4">XP Earned</div>
                <div class="text-7xl md:text-8xl font-display font-bold leading-none">
                    +<%= request.getAttribute("xpEarned") != null ? request.getAttribute("xpEarned") : "0" %>
                </div>
            </div>
            
            <!-- Rank -->
            <div class="p-8 md:p-12 flex flex-col justify-between text-center hover:bg-white transition-colors">
                <div class="text-sm font-label-caps tracking-widest font-bold mb-4">Current Rank</div>
                <div class="text-5xl md:text-6xl font-display font-bold leading-none italic">
                    <%= request.getAttribute("rank") != null ? request.getAttribute("rank") : "Novice" %>
                </div>
            </div>
<!-- Roast Message -->
            <c:if test="${not empty roastMessage}">
                <div class="p-4 text-center font-label-caps text-red-600 break-words overflow-hidden">
                    ${roastMessage}
                </div>
            </c:if>
            <!-- End Roast Message -->
            
            <!-- Actions -->
            <div class="p-8 md:p-12 flex flex-col md:flex-row justify-between items-center gap-6">
                <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center gap-2 border-2 border-black px-8 py-4 hover:bg-black hover:text-white transition-colors font-label-caps text-sm tracking-widest uppercase font-bold w-full md:w-auto justify-center">
                    <span class="material-symbols-outlined text-xl">home</span>
                    <span>Return to Base</span>
                </a>
                <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="flex items-center gap-2 bg-black text-white px-8 py-4 hover:bg-gray-800 transition-colors font-label-caps text-sm tracking-widest uppercase font-bold w-full md:w-auto justify-center">
                    <span>Play Again</span>
                    <span class="material-symbols-outlined text-xl">arrow_forward</span>
                </a>
            </div>
        
    </div>
</main>

</body>
</html>
