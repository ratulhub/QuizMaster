<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, quiz.db.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Command Center</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <div id="globalLoader" class="loader-overlay">
        <div class="cyber-loader"></div>
    </div>

    <nav class="navbar animate-fade-up">
        <div class="navbar-brand">
            <span style="color: var(--accent-tertiary);">⚙️</span> Admin Command
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline" style="padding: 0.5rem 1rem; font-size: 0.9rem;">Exit Command</a>
        </div>
    </nav>

    <div class="container" style="margin-top: 2rem;">
        <h1 class="mb-8 text-gradient animate-fade-up stagger-1">System Administration</h1>
        
        <% String msg = request.getParameter("msg");
           if (msg != null) { %>
           <div class="animate-fade-up" style="background: rgba(0,255,136,0.1); border: 1px solid var(--accent-success); color: #ccffcc; padding: 12px; border-radius: 8px; margin-bottom: 2rem; text-align: center;">
               <%= msg %>
           </div>
           <script>
               window.onload = () => { if(window.showToast) showToast('<%= msg %>', 'success'); };
           </script>
        <% } %>
        
        <div class="grid grid-cols-2">
            <!-- Upload Panel -->
            <div class="glass-card animate-fade-up stagger-2" style="border-color: rgba(0, 229, 255, 0.3);">
                <h2 class="mb-4" style="color: var(--accent-secondary);">Upload Content</h2>
                <form action="${pageContext.request.contextPath}/upload" method="post" enctype="multipart/form-data">
                    <div class="input-group">
                        <select name="category_id" class="input-field" style="padding: 1rem 1.2rem; background: rgba(0,0,0,0.5);">
                            <option value="1">General Knowledge</option>
                            <option value="2">Science</option>
                            <option value="3">History</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <input type="text" name="quiz_title" class="input-field" placeholder=" " required id="quiz-title">
                        <label class="input-label" for="quiz-title">Quiz Title</label>
                    </div>
                    <div class="input-group">
                        <input type="file" name="file" class="input-field" required style="padding: 0.8rem 1.2rem;" accept=".txt,.json">
                    </div>
                    <button type="submit" class="btn btn-glow" style="width: 100%;">Upload to Matrix</button>
                </form>
            </div>
            
            <!-- Stats Panel -->
            <div class="glass-card animate-fade-up stagger-3" style="border-color: rgba(138, 43, 226, 0.3);">
                <h2 class="mb-4" style="color: var(--accent-primary);">Global Statistics</h2>
                
                <table class="glass-table">
                    <thead>
                        <tr>
                            <th>Metric</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection conn = DBConnection.getConnection()) {
                                // Total Users
                                PreparedStatement stmt = conn.prepareStatement("SELECT count(*) FROM users");
                                ResultSet rs = stmt.executeQuery();
                                rs.next();
                                out.print("<tr><td>Total Operatives</td><td style='color: var(--text-primary); font-weight: bold;'>" + rs.getInt(1) + "</td></tr>");
                                
                                // Total Quizzes
                                stmt = conn.prepareStatement("SELECT count(*) FROM quizzes");
                                rs = stmt.executeQuery();
                                rs.next();
                                out.print("<tr><td>Total Quizzes</td><td style='color: var(--text-primary); font-weight: bold;'>" + rs.getInt(1) + "</td></tr>");
                                
                                // Total Attempts
                                stmt = conn.prepareStatement("SELECT count(*) FROM quiz_attempts");
                                rs = stmt.executeQuery();
                                rs.next();
                                out.print("<tr><td>Global Attempts</td><td style='color: var(--text-primary); font-weight: bold;'>" + rs.getInt(1) + "</td></tr>");
                                
                            } catch(Exception e) {
                                out.print("<tr><td colspan='2' style='color: red;'>Database error.</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
</body>
</html>
