<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, quiz.db.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Select Mode</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
    <div id="globalLoader" class="loader-overlay">
        <div class="cyber-loader"></div>
    </div>

    <nav class="navbar animate-fade-up">
        <div class="navbar-brand">
            <span style="color: var(--accent-primary);">⚡</span> QuizMaster
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline" style="padding: 0.5rem 1rem; font-size: 0.9rem;">Back to Dashboard</a>
        </div>
    </nav>

    <div class="container animate-fade-up stagger-1" style="margin-top: 2rem;">
        <div class="text-center mb-8">
            <h1 class="text-gradient" style="font-size: 3rem;">Select Your Trial</h1>
            <p class="text-muted" style="font-size: 1.2rem;">Different modes offer different XP multipliers.</p>
        </div>
        
        <!-- Category Selection -->
        <div class="glass-card mb-8 animate-fade-up stagger-2" style="padding: 1.5rem;">
            <div class="flex-between">
                <h3 style="margin: 0; color: var(--accent-secondary);">Category:</h3>
                <select id="categorySelect" class="input-field" style="width: auto; margin: 0; padding: 0.5rem 1rem; background: rgba(0,0,0,0.5);">
                    <option value="0">All Categories (Random)</option>
                    <%
                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement stmt = conn.prepareStatement("SELECT id, name FROM categories ORDER BY name");
                             ResultSet rs = stmt.executeQuery()) {
                             while(rs.next()) {
                    %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
                    <%       }
                        } catch(Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
        </div>

        <div class="grid grid-cols-3">
            <%
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM quiz_modes ORDER BY id");
                     ResultSet rs = stmt.executeQuery()) {
                     int delayCounter = 3;
                     while(rs.next()) {
                         String code = rs.getString("code");
                         String name = rs.getString("name");
                         String desc = rs.getString("description");
                         double multiplier = rs.getDouble("xp_multiplier");
                         
                         String borderGlow = "rgba(138, 43, 226, 0.3)";
                         if (code.equals("sudden_death") || code.equals("roast")) borderGlow = "rgba(255, 0, 85, 0.3)";
                         if (code.equals("normal")) borderGlow = "rgba(0, 255, 136, 0.3)";
            %>
            <div class="glass-card interactive animate-fade-up stagger-<%= delayCounter++ %>" style="border-color: <%= borderGlow %>; display: flex; flex-direction: column; justify-content: space-between;">
                <div>
                    <h2 class="mb-2" style="font-size: 1.8rem; color: var(--text-primary);"><%= name %></h2>
                    <p class="text-muted mb-4"><%= desc %></p>
                </div>
                <div>
                    <div class="mb-4" style="display: inline-block; padding: 4px 12px; background: rgba(255,255,255,0.05); border-radius: 20px; font-size: 0.9rem; font-weight: 600; color: var(--accent-secondary);">
                        XP Multiplier: <%= multiplier %>x
                    </div>
                    <button onclick="startQuiz('<%= code %>')" class="btn <%= code.equals("sudden_death") || code.equals("roast") ? "btn-danger" : "btn-glow" %>" style="width: 100%;">Enter Mode</button>
                </div>
            </div>
            <%       }
                } catch(Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/app.js"></script>
    <script>
        function startQuiz(modeCode) {
            const catId = document.getElementById('categorySelect').value;
            window.location.href = '${pageContext.request.contextPath}/quiz?action=start&mode=' + modeCode + '&category=' + catId;
        }
    </script>
</body>
</html>
