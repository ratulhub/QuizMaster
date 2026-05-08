<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Admin Base</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <nav>
        <div class="logo" style="color: var(--accent-red);">QuizMaster <span style="font-size: 0.8rem; vertical-align: top;">ADMIN</span></div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary" style="padding: 8px 16px;">Back to Base</a>
        </div>
    </nav>

    <div class="container animate-fade-in">
        <h1 class="mb-4 text-center text-accent-red">System Administration</h1>
        
        <div class="grid grid-cols-2 stagger-animate">
            <div class="glass-panel" style="border-color: rgba(239, 68, 68, 0.3);">
                <h3 class="mb-2">Bulk Upload Questions</h3>
                <p class="text-secondary mb-4">Upload a file containing questions to quickly populate the database.</p>
                <form action="${pageContext.request.contextPath}/admin/upload" method="post" enctype="multipart/form-data">
                    <input type="text" name="title" class="input-field" placeholder="Quiz Title" required>
                    <select name="category_id" class="input-field" required>
                        <option value="" disabled selected>Select Category</option>
                        <option value="1">General Knowledge</option>
                        <option value="2">Science</option>
                        <option value="3">History</option>
                        <option value="4">Technology</option>
                        <option value="5">Mathematics</option>
                    </select>
                    <input type="file" name="file" class="input-field" accept=".txt,.pdf,.docx" required>
                    <button type="submit" class="btn" style="background: var(--accent-red);">Upload File</button>
                </form>
                <% String message = request.getParameter("message");
                   if (message != null) { %>
                   <div style="color: var(--accent-green); margin-top: 1rem;"><%= message %></div>
                <% } %>
            </div>
            
            <div class="glass-panel">
                <h3 class="mb-2">System Metrics</h3>
                <div class="text-secondary mb-2">Total Users: <span class="text-primary"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "14" %></span></div>
                <div class="text-secondary mb-2">Active Rooms: <span class="text-primary">3</span></div>
                <div class="text-secondary">Database Status: <span class="text-accent-green">Online</span></div>
                
                <div class="mt-4">
                    <button class="btn btn-secondary" style="width: 100%;">Generate Analytics Report</button>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
