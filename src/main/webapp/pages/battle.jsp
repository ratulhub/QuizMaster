<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Friend Battle - QuizMaster</title>
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
        
        .room-code-input {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            letter-spacing: 0.3em;
            text-transform: uppercase;
        }
    </style>
</head>
<body class="antialiased min-h-screen flex flex-col md:flex-row selection:bg-black selection:text-white">

<!-- SideNavBar (Desktop) -->
<nav class="hidden md:flex flex-col p-8 z-40 bg-transparent h-screen w-64 border-r-2 border-gray-900 fixed left-0 top-0">
    <div class="mb-16">
        <h1 class="text-3xl font-display font-bold text-gray-900 mb-2">QuizMaster</h1>
    </div>
    <div class="flex flex-col gap-6 flex-grow uppercase text-sm font-semibold tracking-widest text-gray-900">
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/dashboard">
            <span>Dashboard</span>
        </a>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity w-max" href="${pageContext.request.contextPath}/pages/modes.jsp">
            <span>The Arena</span>
        </a>
        <a class="flex items-center gap-3 hover:opacity-70 transition-opacity border-b-2 border-gray-900 w-max pb-1" href="${pageContext.request.contextPath}/battle">
            <span>Friend Battle</span>
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
    <div class="text-xl font-display font-bold tracking-tighter text-gray-900">QuizMaster</div>
    <a href="${pageContext.request.contextPath}/pages/modes.jsp" class="text-sm font-label-caps tracking-widest font-bold hover:opacity-70 transition-opacity">BACK</a>
</nav>

<!-- Main Content -->
<main class="flex-1 md:ml-64 p-6 md:p-12 lg:p-20 overflow-y-auto">
    <div class="max-w-4xl mx-auto space-y-12">
        
        <!-- Header -->
        <header class="border-b-2 border-gray-900 pb-8 text-center">
            <h1 class="text-6xl md:text-8xl font-display font-bold text-gray-900 tracking-tighter uppercase mb-4">
                Friend Battle
            </h1>
            <p class="text-lg text-gray-700 font-medium max-w-xl mx-auto">
                Challenge your friends head-to-head. Create a new room or join an existing one with a code.
            </p>
        </header>

        <% String error = request.getParameter("error");
           if (error != null) { %>
           <div class="p-4 border-2 border-red-600 bg-red-50 text-red-800 text-sm font-medium text-center"><%= error.replace("+", " ") %></div>
        <% } %>
        
        <!-- Battle Options Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-0 border-2 border-gray-900">
            
            <!-- Create Room -->
            <div class="p-10 md:p-16 flex flex-col justify-between border-b-2 md:border-b-0 md:border-r-2 border-gray-900 hover:bg-white transition-colors min-h-[350px]">
                <div>
                    <div class="text-sm font-label-caps tracking-widest font-bold mb-6 text-gray-500">Option A</div>
                    <h2 class="text-4xl md:text-5xl font-display font-bold mb-6 leading-tight">Create a Room</h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8">
                        Generate a unique room code and share it with your friend. You'll be the host of the battle session.
                    </p>
                </div>
                <form action="${pageContext.request.contextPath}/battle" method="post">
                    <input type="hidden" name="action" value="create">
                    <button type="submit" class="flex items-center gap-3 bg-black text-white px-8 py-4 hover:bg-gray-800 transition-colors font-label-caps text-sm tracking-widest uppercase font-bold w-full justify-center">
                        <span class="material-symbols-outlined text-xl">add_circle</span>
                        <span>Create Room</span>
                    </button>
                </form>
            </div>
            
            <!-- Join Room -->
            <div class="p-10 md:p-16 flex flex-col justify-between hover:bg-white transition-colors min-h-[350px]">
                <div>
                    <div class="text-sm font-label-caps tracking-widest font-bold mb-6 text-gray-500">Option B</div>
                    <h2 class="text-4xl md:text-5xl font-display font-bold mb-6 leading-tight">Join a Room</h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8">
                        Enter the room code shared by your friend to join their battle session.
                    </p>
                </div>
                <form action="${pageContext.request.contextPath}/battle" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="join">
                    <input type="text" name="roomCode" required maxlength="6" placeholder="XXXXXX"
                           class="room-code-input w-full bg-transparent border-0 border-b-2 border-gray-900 py-3 px-0 text-gray-900 placeholder:text-gray-300 focus:ring-0 focus:border-black outline-none transition-all">
                    <button type="submit" class="flex items-center gap-3 border-2 border-black px-8 py-4 hover:bg-black hover:text-white transition-colors font-label-caps text-sm tracking-widest uppercase font-bold w-full justify-center">
                        <span class="material-symbols-outlined text-xl">login</span>
                        <span>Join Room</span>
                    </button>
                </form>
            </div>
            
        </div>

        <% String roomCode = (String) request.getAttribute("roomCode");
           if (roomCode != null) { %>
        <!-- Room Created Confirmation -->
        <div class="border-2 border-gray-900 bg-white p-10 md:p-16 text-center">
            <div class="text-sm font-label-caps tracking-widest font-bold mb-4 text-gray-500">Room Created Successfully</div>
            <h2 class="text-3xl font-display font-bold mb-4">Share this code with your friend:</h2>
            <div class="text-6xl md:text-8xl font-display font-bold tracking-[0.3em] text-gray-900 my-8 select-all cursor-pointer" id="roomCodeDisplay"><%= roomCode %></div>
            <p class="text-gray-600 text-base mb-8">When your friend joins, the battle will begin automatically.</p>
            <div class="flex flex-col md:flex-row gap-4 justify-center">
                <a href="${pageContext.request.contextPath}/quiz?mode=battle&room=<%= roomCode %>" class="flex items-center gap-2 bg-black text-white px-8 py-4 hover:bg-gray-800 transition-colors font-label-caps text-sm tracking-widest uppercase font-bold justify-center">
                    <span>Start Battle</span>
                    <span class="material-symbols-outlined text-xl">arrow_forward</span>
                </a>
            </div>
        </div>
        <% } %>
        
    </div>
</main>

</body>
</html>
