<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, quiz.model.Models" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>QuizMaster - Active Protocol</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "secondary-container": "#fe5c4c",
                        "surface-container-low": "#f6f2f7",
                        "on-secondary-fixed": "#410001",
                        "on-secondary-fixed-variant": "#910809",
                        "on-tertiary-container": "#ffd293",
                        "error-container": "#ffdad6",
                        "on-error": "#ffffff",
                        "on-secondary-container": "#610002",
                        "inverse-on-surface": "#f3eff4",
                        "outline-variant": "#cbc4d2",
                        "on-tertiary-fixed": "#291800",
                        "on-primary-fixed-variant": "#4f378a",
                        "surface-variant": "#e5e1e6",
                        "on-background": "#1c1b1f",
                        "on-primary-container": "#e0d2ff",
                        "surface-container": "#f0edf2",
                        "on-primary": "#ffffff",
                        "secondary-fixed": "#ffdad5",
                        "primary": "#4f378a",
                        "error": "#ba1a1a",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-highest": "#e5e1e6",
                        "background": "#fcf8fd",
                        "tertiary-container": "#815600",
                        "tertiary-fixed-dim": "#fcba55",
                        "surface-dim": "#dcd9de",
                        "surface-container-high": "#ebe7ec",
                        "surface-bright": "#fcf8fd",
                        "secondary-fixed-dim": "#ffb4aa",
                        "inverse-primary": "#cfbcff",
                        "inverse-surface": "#313034",
                        "on-error-container": "#93000a",
                        "tertiary": "#624000",
                        "tertiary-fixed": "#ffddb1",
                        "on-secondary": "#ffffff",
                        "surface-tint": "#6750a4",
                        "on-surface-variant": "#494551",
                        "on-tertiary-fixed-variant": "#624000",
                        "primary-fixed-dim": "#cfbcff",
                        "surface": "#fcf8fd",
                        "primary-fixed": "#e9ddff",
                        "secondary": "#b4271f",
                        "outline": "#7a7582",
                        "on-surface": "#1c1b1f",
                        "primary-container": "#6750a4",
                        "on-tertiary": "#ffffff",
                        "on-primary-fixed": "#22005d"
                    },
                    "borderRadius": {
                        "DEFAULT": "1rem",
                        "lg": "2rem",
                        "xl": "3rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "1.5rem",
                        "gutter": "1.5rem",
                        "md": "1rem",
                        "sm": "0.5rem",
                        "margin-desktop": "2.5rem",
                        "xl": "2rem",
                        "margin-mobile": "1rem",
                        "xxl": "4rem",
                        "xs": "0.25rem"
                    },
                    "fontFamily": {
                        "title-lg": ["Outfit"],
                        "headline-md": ["Outfit"],
                        "display-lg": ["Outfit"],
                        "headline-lg": ["Outfit"],
                        "body-lg": ["Outfit"],
                        "label-sm": ["Outfit"],
                        "title-md": ["Outfit"],
                        "label-lg": ["Outfit"],
                        "body-md": ["Outfit"]
                    },
                    "fontSize": {
                        "title-lg": ["22px", { "lineHeight": "28px", "fontWeight": "500" }],
                        "headline-md": ["28px", { "lineHeight": "36px", "fontWeight": "400" }],
                        "display-lg": ["57px", { "lineHeight": "64px", "letterSpacing": "-0.25px", "fontWeight": "400" }],
                        "headline-lg": ["32px", { "lineHeight": "40px", "fontWeight": "400" }],
                        "body-lg": ["16px", { "lineHeight": "24px", "letterSpacing": "0.5px", "fontWeight": "400" }],
                        "label-sm": ["11px", { "lineHeight": "16px", "letterSpacing": "0.5px", "fontWeight": "500" }],
                        "title-md": ["16px", { "lineHeight": "24px", "letterSpacing": "0.15px", "fontWeight": "500" }],
                        "label-lg": ["14px", { "lineHeight": "20px", "letterSpacing": "0.1px", "fontWeight": "500" }],
                        "body-md": ["14px", { "lineHeight": "20px", "letterSpacing": "0.25px", "fontWeight": "400" }]
                    }
                }
            }
        }
    </script>
<style>
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #fcf8fd;
            color: #1c1b1f;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>
<body class="bg-background text-on-background min-h-screen flex flex-col">
<!-- TopAppBar -->
<header class="bg-background dark:bg-background docked full-width top-0 flat no shadows z-40 hidden md:block">
<div class="flex justify-between items-center w-full px-margin-desktop py-md max-w-full mx-auto">
<div class="flex items-center gap-4">
<span class="font-title-lg text-title-lg font-bold text-primary dark:text-primary-fixed-dim">QuizMaster</span>
</div>
<nav class="hidden md:flex gap-8 items-center">
<a class="text-on-surface-variant dark:text-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim transition-colors duration-200 font-label-lg text-label-lg" href="${pageContext.request.contextPath}/modes">Protocols</a>
<a class="text-on-surface-variant dark:text-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim transition-colors duration-200 font-label-lg text-label-lg" href="${pageContext.request.contextPath}/dashboard">History</a>
<a class="text-on-surface-variant dark:text-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim transition-colors duration-200 font-label-lg text-label-lg" href="${pageContext.request.contextPath}/dashboard">Profile</a>
</nav>
<div class="flex items-center gap-4 text-on-surface-variant">
<button class="hover:text-primary transition-colors p-2 rounded-full hover:bg-surface-variant"><span class="material-symbols-outlined" data-icon="settings">settings</span></button>
<button class="hover:text-primary transition-colors p-2 rounded-full hover:bg-surface-variant"><span class="material-symbols-outlined" data-icon="notifications">notifications</span></button>
</div>
</div>
</header>
<!-- Main Content Area -->
<main class="flex-grow pb-24 md:pb-8 pt-6 md:pt-12 px-margin-mobile md:px-margin-desktop flex justify-center">
<!-- Main Card Container -->
<div class="w-full max-w-3xl bg-surface-container-low rounded-xl p-lg md:p-xl shadow-[0_4px_8px_-4px_rgba(0,0,0,0.04)] border border-surface-variant/50">
<!-- Header Section -->
<div class="flex justify-between items-center mb-xl border-b border-surface-variant pb-lg">
<h1 class="font-headline-lg text-headline-lg text-primary">Protocol Active</h1>
<div class="bg-primary text-on-primary font-label-sm text-label-sm px-4 py-2 rounded-full uppercase tracking-wider">
                    MODE: <%= request.getParameter("mode") != null ? request.getParameter("mode").toUpperCase() : "NORMAL" %>
                </div>
</div>
<!-- Quiz Content -->
<form id="quizForm" action="${pageContext.request.contextPath}/submit" method="post" class="space-y-xxl">
<input type="hidden" name="mode" value="<%= request.getParameter("mode") != null ? request.getParameter("mode") : "normal" %>">
<input type="hidden" name="total" value="<%= request.getAttribute("total") != null ? request.getAttribute("total") : "0" %>">
<input type="hidden" name="questionIds" value="<%= request.getAttribute("questionIds") %>">

<% 
    List<Models.Question> questions = (List<Models.Question>) request.getAttribute("questions");
    if (questions != null && !questions.isEmpty()) {
        int i = 1;
        for (Models.Question q : questions) {
%>
<!-- Question <%= i %> -->
<div class="space-y-md mt-xl">
<h2 class="font-title-lg text-title-lg text-on-background mb-lg"><%= i %>. <%= q.getText() %></h2>
<div class="space-y-sm">
<!-- Option A -->
<label class="flex items-center p-md bg-surface-container hover:bg-surface-container-high transition-colors rounded-lg cursor-pointer group">
<input class="w-5 h-5 text-primary bg-surface-container-highest border-outline focus:ring-primary focus:ring-offset-surface-container-low cursor-pointer" name="q_<%= q.getId() %>" value="A" type="radio" required/>
<span class="ml-4 font-body-lg text-body-lg text-on-surface-variant group-hover:text-on-background transition-colors"><%= q.getOptionA() %></span>
</label>
<!-- Option B -->
<label class="flex items-center p-md bg-surface-container hover:bg-surface-container-high transition-colors rounded-lg cursor-pointer group">
<input class="w-5 h-5 text-primary bg-surface-container-highest border-outline focus:ring-primary focus:ring-offset-surface-container-low cursor-pointer" name="q_<%= q.getId() %>" value="B" type="radio" required/>
<span class="ml-4 font-body-lg text-body-lg text-on-surface-variant group-hover:text-on-background transition-colors"><%= q.getOptionB() %></span>
</label>
<!-- Option C -->
<label class="flex items-center p-md bg-surface-container hover:bg-surface-container-high transition-colors rounded-lg cursor-pointer group">
<input class="w-5 h-5 text-primary bg-surface-container-highest border-outline focus:ring-primary focus:ring-offset-surface-container-low cursor-pointer" name="q_<%= q.getId() %>" value="C" type="radio" required/>
<span class="ml-4 font-body-lg text-body-lg text-on-surface-variant group-hover:text-on-background transition-colors"><%= q.getOptionC() %></span>
</label>
<!-- Option D -->
<label class="flex items-center p-md bg-surface-container hover:bg-surface-container-high transition-colors rounded-lg cursor-pointer group">
<input class="w-5 h-5 text-primary bg-surface-container-highest border-outline focus:ring-primary focus:ring-offset-surface-container-low cursor-pointer" name="q_<%= q.getId() %>" value="D" type="radio" required/>
<span class="ml-4 font-body-lg text-body-lg text-on-surface-variant group-hover:text-on-background transition-colors"><%= q.getOptionD() %></span>
</label>
</div>
</div>
<% 
        i++;
        }
    } else {
%>
    <div class="text-center p-xl">
        <p class="font-body-lg text-body-lg text-on-surface-variant">No questions found in the database. Please ask an admin to upload a quiz.</p>
    </div>
<% } %>
<!-- Submit Button Area (Optional/Contextual) -->
<div class="mt-xl pt-lg flex justify-end">
<button type="submit" class="bg-primary text-on-primary font-label-lg text-label-lg px-8 py-3 rounded-full hover:bg-primary/90 transition-colors shadow-sm">
                    Submit Answers
                </button>
</div>
</form>
</div>
</main>
<!-- BottomNavBar (Mobile) -->
<nav class="md:hidden shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)] bg-surface-container-lowest dark:bg-inverse-surface shadow-md fixed bottom-0 left-0 w-full z-50 flex justify-around items-center px-4 py-2">
<a href="${pageContext.request.contextPath}/dashboard" class="flex flex-col items-center justify-center text-on-surface-variant dark:text-surface-variant px-6 py-1 hover:bg-surface-container-high dark:hover:bg-surface-variant transition-all rounded-full group">
<span class="material-symbols-outlined mb-1 group-hover:scale-110 transition-transform" data-icon="auto_stories">auto_stories</span>
<span class="font-label-sm text-label-sm">Library</span>
</a>
<a href="${pageContext.request.contextPath}/modes" class="flex flex-col items-center justify-center bg-primary-container dark:bg-primary text-on-primary-container dark:text-on-primary rounded-full px-6 py-1 scale-95 duration-100 group">
<span class="material-symbols-outlined mb-1" data-icon="play_circle" data-weight="fill" style="font-variation-settings: 'FILL' 1;">play_circle</span>
<span class="font-label-sm text-label-sm">Active</span>
</a>
<a href="${pageContext.request.contextPath}/dashboard" class="flex flex-col items-center justify-center text-on-surface-variant dark:text-surface-variant px-6 py-1 hover:bg-surface-container-high dark:hover:bg-surface-variant transition-all rounded-full group">
<span class="material-symbols-outlined mb-1 group-hover:scale-110 transition-transform" data-icon="leaderboard">leaderboard</span>
<span class="font-label-sm text-label-sm">Stats</span>
</a>
</nav>
<script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body></html>
