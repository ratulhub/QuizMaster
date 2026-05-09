# QuizMaster - University Presentation Notes

This document provides a structured flow and important talking points for your university presentation or project defense.

## 1. Project Purpose & Introduction
**"Hello everyone. My name is [Your Name], and I am presenting QuizMaster."**
- **The Problem**: Traditional quiz applications are boring, static, and unengaging. They feel like homework.
- **The Solution**: QuizMaster transforms learning into an interactive, gamified experience with dynamic modes (like Roast Mode and Sudden Death), a cinematic UI, and a competitive XP system.

## 2. Software Engineering Architecture
**"To keep the project scalable and understandable, I opted for a clean Monolithic Architecture."**
- **No Over-engineering**: Instead of using heavy frameworks like Spring Boot which abstract away the learning process, I built this using raw **Jakarta EE Servlets and JSP**. This demonstrates a fundamental understanding of HTTP, request lifecycles, and session management.
- **Frontend/Backend Unification**: The frontend (JSP/CSS/JS) and backend (Java) are tightly coupled and compiled into a single `.war` file, deployed on an Apache Tomcat 10 server.
- **Cloud Database**: The data layer is handled by a Supabase PostgreSQL instance, queried using raw JDBC.

## 3. Key Concepts Explained

### Session Management
**"How do we know who is logged in?"**
- We use `HttpSession`. When a user logs in successfully, we store their `userId` and `role` in the session.
- We use a **Filter** (`AuthFilter.java`) to intercept requests to protected pages. If a session doesn't exist, they are redirected to the login page. This prevents unauthorized access globally without repeating `if-else` checks in every Servlet.

### Database Interaction (JDBC)
**"How do we talk to Supabase?"**
- We utilize the `java.sql` package and the PostgreSQL JDBC Driver.
- We use `PreparedStatement` exclusively. This is critical for security as it prevents **SQL Injection** attacks by safely escaping user input.
- We implement **Try-With-Resources** to ensure database connections and ResultSets are automatically closed, preventing memory leaks.

## 4. Code Snippets to Show Teachers

### 1. The Database Connection (`DBConnection.java`)
*Show them how you securely connect using Environment Variables.*
```java
public class DBConnection {
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASS = System.getenv("DB_PASSWORD");

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
```
*Talking Point*: "I used Environment Variables so sensitive credentials are never hardcoded in the source code, adhering to security best practices."

### 2. Password Hashing (`PasswordUtil.java`)
*Show them you care about security.*
```java
public static String hashPassword(String password) {
    MessageDigest digest = MessageDigest.getInstance("SHA-256");
    byte[] encodedhash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
    // ... converts to hex ...
}
```
*Talking Point*: "Passwords are never stored in plain text. I used Java's native MessageDigest to hash passwords with SHA-256 before saving them to the database."

### 3. Authentication Filter (`AuthFilter.java`)
*Show them your understanding of the Servlet Lifecycle.*
```java
@WebFilter(urlPatterns = {"/pages/dashboard.jsp", "/quiz", "/admin"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response); // Proceed
        } else {
            res.sendRedirect("/pages/login.jsp"); // Blocked
        }
    }
}
```
*Talking Point*: "Instead of checking the session in every single servlet, I implemented a Filter. It acts as a middleware gatekeeper, demonstrating DRY (Don't Repeat Yourself) principles."

### 4. Handling Quiz Submissions and Transactions (`ResultServlet.java`)
*Show them Transaction Management.*
```java
try (Connection conn = DBConnection.getConnection()) {
    conn.setAutoCommit(false); // Start Transaction

    // 1. Insert Attempt
    // 2. Update User Profile XP
    
    conn.commit(); // End Transaction
} catch (Exception e) {
    conn.rollback(); // Revert on failure
}
```
*Talking Point*: "For operations that involve multiple database updates, I disabled auto-commit to create a Transaction. If one query fails, it rolls back, ensuring data integrity."

## 5. Challenges Faced
- **Asset Management**: Ensuring the CSS and JS paths worked correctly when deployed under a context root vs the ROOT webapp. Fixed by dynamically prepending `request.getContextPath()`.
- **Parsing Documents**: Reading `.docx` and `.pdf` files natively in Java for the admin upload feature required careful integration of libraries like PDFBox and utilizing `ZipInputStream` for docx XML extraction.

## 6. Conclusion
**"QuizMaster successfully demonstrates fundamental web architecture. It proves that with pure Servlets, JSP, and solid software engineering principles, you can build a highly professional, interactive, and secure web application."**
