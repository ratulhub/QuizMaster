<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - QuizMaster</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
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
<body class="antialiased min-h-screen flex flex-col md:flex-row selection:bg-black selection:text-white">

<!-- SideNavBar -->
<nav class="hidden md:flex flex-col p-8 z-40 bg-transparent h-screen w-64 border-r-2 border-gray-900 fixed left-0 top-0">
    <div class="mb-16">
        <h1 class="text-3xl font-display font-bold text-gray-900 mb-2">QuizMaster</h1>
        <span class="text-xs font-label-caps tracking-widest text-red-700 font-bold border border-red-700 px-2 py-0.5">ADMIN</span>
    </div>
    
    <div class="flex flex-col gap-6 flex-grow uppercase text-sm font-semibold tracking-widest text-gray-900">
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/dashboard">
            <span>Dashboard</span>
        </a>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/pages/modes.jsp">
            <span>The Arena</span>
        </a>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity border-b-2 border-gray-900 w-max pb-1" href="${pageContext.request.contextPath}/admin">
            <span>Admin Panel</span>
        </a>
    </div>
    
    <div class="mt-auto flex flex-col gap-6 uppercase text-sm font-semibold tracking-widest text-gray-900 pt-8 border-t-2 border-gray-900">
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max text-red-700" href="${pageContext.request.contextPath}/login?action=logout">
            <span>Logout</span>
        </a>
    </div>
</nav>

<!-- Mobile Nav -->
<nav class="md:hidden flex justify-between items-center w-full px-6 py-4 z-50 bg-[#f4f4f5] border-b-2 border-gray-900 sticky top-0">
    <div class="text-xl font-display font-bold tracking-tighter text-gray-900">QuizMaster <span class="text-xs font-label-caps tracking-widest text-red-700 ml-2">ADMIN</span></div>
    <a href="${pageContext.request.contextPath}/dashboard" class="text-sm font-label-caps tracking-widest font-bold hover:opacity-70 transition-opacity">BACK</a>
</nav>

<!-- Main Content -->
<main class="flex-1 md:ml-64 p-6 md:p-12 lg:p-20 overflow-y-auto">
    <div class="max-w-5xl mx-auto space-y-12">
        
        <!-- Header -->
        <header class="border-b-2 border-gray-900 pb-8">
            <h1 class="text-5xl md:text-7xl font-display font-bold text-gray-900 tracking-tighter uppercase mb-4">
                System Administration
            </h1>
            <p class="text-lg text-gray-700 font-medium">
                Manage quiz content and monitor platform metrics.
            </p>
        </header>
        
        <!-- Stats -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-0 border-2 border-gray-900">
            <div class="p-8 flex flex-col justify-between md:h-40 border-b-2 md:border-b-0 md:border-r-2 border-gray-900 hover:bg-white transition-colors">
                <div class="text-sm font-label-caps tracking-widest font-bold">Total Users</div>
                <div class="text-6xl font-display font-bold text-gray-900 mt-4"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></div>
            </div>
            <div class="p-8 flex flex-col justify-between md:h-40 hover:bg-white transition-colors">
                <div class="text-sm font-label-caps tracking-widest font-bold">Total Quizzes</div>
                <div class="text-6xl font-display font-bold text-gray-900 mt-4"><%= request.getAttribute("totalQuizzes") != null ? request.getAttribute("totalQuizzes") : "0" %></div>
            </div>
        </section>
        
        <!-- Upload Form -->
        <section class="border-2 border-gray-900">
            <div class="p-8 border-b-2 border-gray-900">
                <h2 class="text-3xl font-display font-bold">Bulk Upload Questions</h2>
                <p class="text-gray-600 mt-2">Upload a .txt, .pdf, or .docx file containing questions to populate the database.</p>
            </div>
            <div class="p-8">
                <% String success = request.getParameter("success");
                   if (success != null) { %>
                   <div class="mb-6 p-4 bg-green-50 border border-green-400 text-green-800 text-sm font-medium"><%= success.replace("+", " ") %></div>
                <% } %>
                <% String error = request.getParameter("error");
                   if (error != null) { %>
                   <div class="mb-6 p-4 bg-red-50 border border-red-400 text-red-800 text-sm font-medium"><%= error.replace("+", " ") %></div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/admin/upload" method="post" enctype="multipart/form-data" class="space-y-6">
                    <!-- Quiz Title -->
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-label-caps tracking-widest font-bold" for="quiz-title">Quiz Title</label>
                        <input type="text" name="title" id="quiz-title" required
                               class="w-full bg-transparent border-0 border-b-2 border-gray-900 py-3 px-0 text-base text-gray-900 placeholder:text-gray-400 focus:ring-0 focus:border-black outline-none transition-all"
                               placeholder="Enter quiz title">
                    </div>
                    
                    <!-- Category Select -->
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-label-caps tracking-widest font-bold" for="category">Select Mode</label>
                        <select name="category_id" id="category" required
                                class="w-full bg-transparent border-0 border-b-2 border-gray-900 py-3 px-0 text-base text-gray-900 focus:ring-0 focus:border-black outline-none transition-all">
                            <option value="" disabled selected>Choose a mode...</option>
                            <option value="1">Normal Mode</option>
                            <option value="2">Roast Mode</option>
                            <option value="3">Sudden Death</option>
                            <option value="4">Teacher Mode</option>
                            <option value="5">Bride Interview</option>
                            <option value="6">Friend Battle</option>
                        </select>
                    </div>
                    
                    <!-- File Upload -->
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-label-caps tracking-widest font-bold" for="file-upload">Question File</label>
                        <input type="file" name="file" id="file-upload" accept=".txt,.pdf,.docx" required
                               class="w-full text-sm text-gray-600 file:mr-4 file:py-3 file:px-6 file:border-2 file:border-gray-900 file:bg-transparent file:text-sm file:font-bold file:text-gray-900 hover:file:bg-black hover:file:text-white file:transition-colors file:cursor-pointer">
                    </div>
                    
                    <!-- Submit -->
                    <button type="submit" class="flex items-center gap-2 bg-black text-white px-8 py-4 hover:bg-gray-800 transition-colors font-label-caps text-sm tracking-widest uppercase font-bold w-full justify-center">
                        <span class="material-symbols-outlined text-xl">upload_file</span>
                        <span>Upload File</span>
                    </button>
                </form>
            </div>
        </section>
        
    </div>
</main>

</body>
</html>
