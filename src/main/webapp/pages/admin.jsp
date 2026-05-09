<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Admin Base</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <style>
        .md-input[type="file"] {
            padding: 16px;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo" style="color: #B3261E;">QuizMaster <span style="font-size: 0.8rem; vertical-align: top; font-family: var(--font-main);">ADMIN</span></div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="md-btn md-btn-outlined" style="padding: 8px 16px;">Back to Base</a>
        </div>
    </nav>

    <div class="blur-shape blur-primary" style="top: 0%; left: 0%; width: 50vw; background: rgba(179, 38, 30, 0.1);"></div>

    <div class="container animate-fade-in" style="position: relative; z-index: 1;">
        <h1 class="mb-4 text-center" style="color: #B3261E; font-size: 3rem;">System Administration</h1>
        
        <div class="grid grid-cols-2 stagger-animate">
            <div class="md-card">
                <h3 class="mb-2 text-primary" style="font-size: 1.8rem; color: #B3261E;">Bulk Upload Questions</h3>
                <p class="text-secondary mb-4" style="font-size: 1rem;">Upload a file containing questions to quickly populate the database.</p>
                <form action="${pageContext.request.contextPath}/admin/upload" method="post" enctype="multipart/form-data">
                    <div class="md-input-container">
                        <input type="text" name="title" id="quiz-title" class="md-input" placeholder=" " required>
                        <label class="md-input-label" for="quiz-title">Quiz Title</label>
                    </div>
                    
                    <div class="md-input-container">
                        <select name="category_id" id="category" class="md-input" required style="padding-top: 16px;">
                            <option value="" disabled selected>Select Category</option>
                            <option value="1">General Knowledge</option>
                            <option value="2">Science</option>
                            <option value="3">History</option>
                            <option value="4">Technology</option>
                            <option value="5">Mathematics</option>
                        </select>
                    </div>
                    
                    <div class="md-input-container">
                        <input type="file" name="file" class="md-input" accept=".txt,.pdf,.docx" required>
                    </div>
                    
                    <button type="submit" class="md-btn md-btn-filled" style="background: #B3261E; width: 100%;">Upload File</button>
                </form>
                <% String message = request.getParameter("message");
                   if (message != null) { %>
                   <div style="color: #386a20; background: #e6f4ea; padding: 12px; border-radius: 8px; margin-top: 1rem; text-align: center;"><%= message %></div>
                <% } %>
            </div>
            
            <div class="md-card">
                <h3 class="mb-2 text-primary" style="font-size: 1.8rem;">System Metrics</h3>
                <div class="text-secondary mb-2" style="font-size: 1.1rem;">Total Users: <span class="text-primary"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "14" %></span></div>
                <div class="text-secondary mb-2" style="font-size: 1.1rem;">Active Rooms: <span class="text-primary">3</span></div>
                <div class="text-secondary" style="font-size: 1.1rem;">Database Status: <span style="color: #386a20; font-weight: 500;">Online</span></div>
                
                <div class="mt-4" style="margin-top: 2rem;">
                    <button class="md-btn md-btn-outlined" style="width: 100%;">Generate Analytics Report</button>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
