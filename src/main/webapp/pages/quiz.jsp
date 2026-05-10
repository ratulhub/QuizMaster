<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, quiz.model.Models" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>The Arena - QuizMaster</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap" rel="stylesheet"/>
<style>
        body {
            background-color: #f4f4f4;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.06'/%3E%3C/svg%3E");
            color: #000;
            font-family: 'Inter', sans-serif;
        }
        .font-display-lg { font-family: 'Playfair Display', serif; }
        .font-label-caps { font-family: 'Inter', sans-serif; text-transform: uppercase; letter-spacing: 0.1em; }
        
        /* Custom styles for peer checked state propagation */
        input[type="radio"]:checked + div {
            background-color: #000;
            color: #fff;
        }
        input[type="radio"]:checked + div .text-gray-600 {
            color: #ccc;
        }
    </style>
</head>
<body class="antialiased min-h-screen flex selection:bg-black selection:text-white">

<!-- TopNavBar (Mobile Only) -->
<nav class="md:hidden fixed top-0 w-full z-50 bg-[#f4f4f4]/90 backdrop-blur-md border-b border-black flex justify-between items-center px-6 py-4">
    <div class="flex items-center gap-4">
        <div class="text-3xl font-display-lg font-bold tracking-tighter">QM</div>
    </div>
</nav>

<!-- SideNavBar (Desktop) -->
<nav class="hidden md:flex fixed left-0 top-0 h-full flex-col pt-12 p-8 z-40 border-r border-black w-64 bg-transparent">
    <div class="mb-24 flex justify-center w-full">
        <div class="text-6xl font-display-lg font-bold tracking-tighter">QM</div>
    </div>
    <div class="flex-1 flex flex-col gap-8">
        <a class="block text-sm font-label-caps tracking-widest hover:underline decoration-2 underline-offset-4" href="${pageContext.request.contextPath}/dashboard">
            HOME
        </a>
        <a class="block text-sm font-label-caps tracking-widest hover:underline decoration-2 underline-offset-4" href="${pageContext.request.contextPath}/modes">
            DISCOVER
        </a>
        <a class="block text-sm font-label-caps tracking-widest hover:underline decoration-2 underline-offset-4" href="${pageContext.request.contextPath}/dashboard">
            MY QUIZZES
        </a>
    </div>
</nav>

<!-- Main Content Area -->
<main class="flex-1 md:ml-64 p-6 md:p-16 pt-24 md:pt-16 min-h-screen relative flex flex-col">
    
    <!-- Header Section -->
    <header class="flex flex-col md:flex-row justify-between items-start md:items-center mb-16 pb-8 border-b border-black gap-6">
        <div class="flex flex-wrap items-center gap-6">
            <span class="text-3xl font-display-lg italic font-bold">The Arena.</span>
            <span class="px-4 py-1.5 text-xs font-label-caps tracking-widest uppercase border border-black bg-white/50">
                MODE: <%= request.getParameter("mode") != null ? request.getParameter("mode").toUpperCase() : "NORMAL" %>
            </span>
        </div>
        <div class="flex items-center gap-6">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-xl">timer</span>
                <span class="font-label-caps text-base font-bold tracking-widest">Active</span>
            </div>
            <div class="hidden md:block h-6 w-px bg-black/30"></div>
            <a href="${pageContext.request.contextPath}/dashboard" class="font-label-caps text-sm font-bold tracking-widest hover:opacity-70 transition-opacity">ABORT</a>
        </div>
    </header>

    <div class="max-w-5xl mx-auto w-full flex-1 flex flex-col">
        <form id="quizForm" action="${pageContext.request.contextPath}/submit" method="post" class="w-full">
            <input type="hidden" name="mode" value="<%= request.getParameter("mode") != null ? request.getParameter("mode") : "normal" %>">
            <input type="hidden" name="total" value="<%= request.getAttribute("total") != null ? request.getAttribute("total") : "0" %>">
            <input type="hidden" name="questionIds" value="<%= request.getAttribute("questionIds") %>">

            <% 
                List<Models.Question> questions = (List<Models.Question>) request.getAttribute("questions");
                if (questions != null && !questions.isEmpty()) {
                    int i = 1;
                    for (Models.Question q : questions) {
            %>
            <div class="mb-24">
                <!-- Question Section -->
                <section class="mb-12">
                    <div class="text-sm font-label-caps mb-4 tracking-widest text-gray-500">QUESTION <%= i %></div>
                    <h1 class="text-4xl md:text-5xl font-display-lg font-bold leading-tight md:leading-snug max-w-4xl">
                        <%= q.getText() %>
                    </h1>
                </section>

                <!-- Options Grid -->
                <section class="grid grid-cols-1 md:grid-cols-2 bg-white/40 border border-black">
                    <!-- Option A -->
                    <label class="cursor-pointer relative group">
                        <input type="radio" name="q_<%= q.getId() %>" value="A" required class="absolute opacity-0 w-0 h-0">
                        <div class="h-full p-8 md:p-12 border-b md:border-r border-black flex flex-col items-start text-left transition-all duration-300 group-hover:bg-black group-hover:text-white">
                            <div class="font-display-lg text-4xl md:text-5xl font-bold mb-6">A.</div>
                            <h3 class="font-display-lg text-2xl md:text-3xl font-bold mb-3 leading-tight"><%= q.getOptionA() %></h3>
                        </div>
                    </label>

                    <!-- Option B -->
                    <label class="cursor-pointer relative group">
                        <input type="radio" name="q_<%= q.getId() %>" value="B" required class="absolute opacity-0 w-0 h-0">
                        <div class="h-full p-8 md:p-12 border-b border-black flex flex-col items-start text-left transition-all duration-300 group-hover:bg-black group-hover:text-white">
                            <div class="font-display-lg text-4xl md:text-5xl font-bold mb-6">B.</div>
                            <h3 class="font-display-lg text-2xl md:text-3xl font-bold mb-3 leading-tight"><%= q.getOptionB() %></h3>
                        </div>
                    </label>

                    <!-- Option C -->
                    <label class="cursor-pointer relative group">
                        <input type="radio" name="q_<%= q.getId() %>" value="C" required class="absolute opacity-0 w-0 h-0">
                        <div class="h-full p-8 md:p-12 border-b md:border-b-0 md:border-r border-black flex flex-col items-start text-left transition-all duration-300 group-hover:bg-black group-hover:text-white">
                            <div class="font-display-lg text-4xl md:text-5xl font-bold mb-6">C.</div>
                            <h3 class="font-display-lg text-2xl md:text-3xl font-bold mb-3 leading-tight"><%= q.getOptionC() %></h3>
                        </div>
                    </label>

                    <!-- Option D -->
                    <label class="cursor-pointer relative group">
                        <input type="radio" name="q_<%= q.getId() %>" value="D" required class="absolute opacity-0 w-0 h-0">
                        <div class="h-full p-8 md:p-12 flex flex-col items-start text-left transition-all duration-300 group-hover:bg-black group-hover:text-white">
                            <div class="font-display-lg text-4xl md:text-5xl font-bold mb-6">D.</div>
                            <h3 class="font-display-lg text-2xl md:text-3xl font-bold mb-3 leading-tight"><%= q.getOptionD() %></h3>
                        </div>
                    </label>
                </section>
            </div>
            <% 
                    i++;
                    }
                } else {
            %>
                <div class="text-center p-20 border border-black bg-white/40 mb-16">
                    <p class="font-display-lg text-3xl font-bold">No questions retrieved.</p>
                    <p class="font-label-caps tracking-widest mt-4">Please contact central command to populate the database.</p>
                </div>
            <% } %>

            <!-- Footer Actions -->
            <footer class="mt-8 flex justify-end items-center pt-8 border-t border-black mb-16">
                <button type="submit" class="flex items-center gap-2 border border-black px-8 py-4 hover:bg-black hover:text-white transition-colors font-label-caps text-sm tracking-widest uppercase font-bold">
                    <span>Submit Answers</span>
                    <span class="material-symbols-outlined text-xl">arrow_forward</span>
                </button>
            </footer>
        </form>
    </div>
</main>

</body>
</html>
