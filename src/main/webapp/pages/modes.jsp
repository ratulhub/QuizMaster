<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Editorial Selection - QuizMaster</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,700&display=swap" rel="stylesheet"/>
    <style>
        body {
            background-color: #f4f4f4;
            color: #000;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.04'/%3E%3C/svg%3E");
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }
        .font-serif { font-family: 'Playfair Display', serif; }
        
        .card-border {
            border: 2px solid #000;
        }
        
        .btn-play-now {
            display: inline-block;
            font-weight: 700;
            font-size: 0.85rem;
            letter-spacing: 0.05em;
            padding-bottom: 2px;
            border-bottom: 3px solid #000;
            text-transform: uppercase;
            transition: all 0.2s;
            color: #000;
            text-decoration: none;
        }
        .btn-play-now:hover {
            color: #2563eb;
            border-bottom-color: #2563eb;
        }

        /* Image blend modes for that realistic printed look */
        .img-blend {
            mix-blend-mode: multiply;
            filter: contrast(1.15) brightness(0.95);
        }
        
        .sidebar-link {
            text-decoration: none;
            color: #000;
            font-size: 0.875rem;
            font-weight: 500;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            display: inline-block;
            border-bottom: 1px solid transparent;
            padding-bottom: 2px;
            transition: all 0.2s;
        }
        .sidebar-link.active, .sidebar-link:hover {
            border-bottom-color: #000;
        }
    </style>
</head>
<body class="min-h-screen flex">
    
    <!-- Sidebar -->
    <aside class="w-64 border-r-2 border-black flex flex-col py-12 px-8 shrink-0 bg-transparent relative z-10">
        <div class="mb-20">
            <h1 class="font-serif text-5xl font-bold tracking-tighter" style="letter-spacing: -0.05em;">QM</h1>
        </div>
        
        <nav class="flex flex-col gap-6">
            <div><a href="${pageContext.request.contextPath}/" class="sidebar-link">HOME</a></div>
            <div><a href="${pageContext.request.contextPath}/modes" class="sidebar-link active">DISCOVER</a></div>
            <div><a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link">MY QUIZZES</a></div>
            <div><a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link">PROFILE</a></div>
            <div><a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link">SETTINGS</a></div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 p-12 flex flex-col max-w-[1200px] mx-auto w-full relative z-10">
        <h2 class="font-serif text-6xl md:text-7xl font-bold tracking-tight mb-10" style="letter-spacing: -0.02em;">EDITORIAL SELECTION</h2>
        
        <!-- Grid Container -->
        <div class="grid grid-cols-4 gap-4 flex-1">
            
            <!-- Normal Mode (Spans 2 cols) -->
            <div class="col-span-2 card-border bg-[#f8f8f8] flex relative overflow-hidden min-h-[300px] group hover:border-blue-600 transition-colors duration-300">
                <div class="p-8 flex flex-col justify-between w-1/2 z-10 relative">
                    <div>
                        <h3 class="font-serif text-3xl md:text-4xl font-bold leading-[1.1] mb-4">NORMAL<br>MODE</h3>
                        <p class="text-sm text-black leading-snug">The classic, adaptive quiz experience. Challenge your knowledge across various subjects.</p>
                    </div>
                    <div class="mt-8">
                        <a href="${pageContext.request.contextPath}/quiz?mode=normal" class="btn-play-now">PLAY NOW</a>
                    </div>
                </div>
                <div class="w-1/2 absolute right-0 top-0 bottom-0 flex items-center justify-center p-2">
                    <img src="${pageContext.request.contextPath}/assets/images/normal_mode.png" alt="Normal Mode" class="w-full h-full object-contain img-blend scale-110 translate-x-4">
                </div>
            </div>

            <!-- Roast Mode (Spans 2 cols) -->
            <div class="col-span-2 card-border bg-[#f8f8f8] flex relative overflow-hidden min-h-[300px] group hover:border-blue-600 transition-colors duration-300">
                <div class="w-[45%] absolute left-0 top-0 bottom-0 flex items-center justify-center p-2 border-r-2 border-black group-hover:border-blue-600 transition-colors duration-300">
                    <img src="${pageContext.request.contextPath}/assets/images/roast_mode.png" alt="Roast Mode" class="w-full h-full object-contain img-blend scale-[1.3] -translate-y-2">
                </div>
                <div class="w-[55%] ml-auto p-8 flex flex-col justify-between z-10">
                    <div>
                        <h3 class="font-serif text-3xl md:text-4xl font-bold leading-[1.1] mb-4">ROAST<br>MODE</h3>
                        <p class="text-sm text-black leading-snug">Sarcastic AI responses.<br>Prepare to be roasted.</p>
                    </div>
                    <div class="mt-8">
                        <a href="${pageContext.request.contextPath}/quiz?mode=roast" class="btn-play-now">PLAY NOW</a>
                    </div>
                </div>
            </div>

            <!-- Teacher Mode (Span 1) -->
            <div class="col-span-1 card-border bg-[#f8f8f8] p-8 flex flex-col justify-between min-h-[300px] group hover:border-blue-600 transition-colors duration-300">
                <div>
                    <h3 class="font-serif text-3xl md:text-4xl font-bold leading-[1.1] mb-4">TEACHER<br>MODE</h3>
                    <p class="text-sm text-black leading-snug">Receive detailed explanations for every answer.</p>
                </div>
                <div class="mt-8">
                    <a href="${pageContext.request.contextPath}/quiz?mode=teacher" class="btn-play-now">PLAY NOW</a>
                </div>
            </div>

            <!-- Sudden Death (Span 1) -->
            <div class="col-span-1 card-border bg-[#f8f8f8] p-8 flex flex-col justify-between min-h-[300px] group hover:border-blue-600 transition-colors duration-300">
                <div>
                    <h3 class="font-serif text-3xl md:text-4xl font-bold leading-[1.1] mb-4">SUDDEN<br>DEATH</h3>
                    <p class="text-sm text-black leading-snug">One wrong move and you're out. High stakes, fast pace.</p>
                </div>
                <div class="mt-8">
                    <a href="${pageContext.request.contextPath}/quiz?mode=sudden_death" class="btn-play-now">PLAY NOW</a>
                </div>
            </div>

            <!-- The Daily Challenge (Spans 2 cols) -->
            <div class="col-span-2 card-border bg-[#f8f8f8] flex relative overflow-hidden min-h-[300px] group hover:border-blue-600 transition-colors duration-300">
                <div class="w-[55%] p-8 flex flex-col justify-between z-10 border-r-2 border-black group-hover:border-blue-600 transition-colors duration-300">
                    <div>
                        <h3 class="font-serif text-3xl md:text-4xl font-bold leading-[1.1] mb-4">THE DAILY<br>CHALLENGE</h3>
                        <p class="text-sm text-black leading-snug">A new, curated quiz every day.<br>Compete globally.</p>
                    </div>
                    <div class="mt-8">
                        <!-- Using bride mode as the 'daily challenge' or just redirecting to dashboard if no specific mode is asked -->
                        <a href="${pageContext.request.contextPath}/quiz?mode=bride" class="btn-play-now">PLAY NOW</a>
                    </div>
                </div>
                <div class="w-[45%] absolute right-0 top-0 bottom-0 flex items-center justify-center p-4">
                    <img src="${pageContext.request.contextPath}/assets/images/daily_challenge.png" alt="Daily Challenge" class="w-full h-full object-contain img-blend scale-110 translate-y-4">
                </div>
            </div>

        </div>
    </main>

</body>
</html>
