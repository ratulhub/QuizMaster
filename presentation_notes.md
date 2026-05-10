# QuizMaster — University Presentation Notes

This document provides a structured flow and important talking points for your university presentation or project defense.

---

## 1. Project Purpose & Introduction

**"Hello everyone. My name is Abdur Rahim Ratul, and I am presenting QuizMaster — Editorial Edition."**

- **The Problem**: Traditional quiz applications are boring, static, and unengaging. They feel like homework. Tools like Google Forms or Canvas offer zero gamification.
- **The Solution**: QuizMaster transforms learning into an interactive, gamified experience with 5 unique game modes (including Roast Mode, Sudden Death, Bride Interview, and multiplayer Friend Battle), a high-end editorial UI, and a competitive XP ranking system.
- **Design Philosophy**: The interface follows a **Brutalist Editorial** design language — inspired by modern print magazines. Typography-first, black-and-white palette, bold 2px borders, newspaper-grain textures, and asymmetric layouts.

---

## 2. Software Engineering Architecture

**"To keep the project scalable and understandable, I opted for a clean Monolithic MVC Architecture."**

- **No Over-engineering**: Instead of using heavy frameworks like Spring Boot which abstract away the learning process, I built this using raw **Jakarta EE Servlets and JSP**. This demonstrates a fundamental understanding of HTTP request lifecycles, session management, and the Servlet API.
- **Frontend/Backend Unification**: The frontend (JSP + Tailwind CSS) and backend (Java Servlets) are compiled into a single `.war` file, deployed on an Apache Tomcat 10 server.
- **Cloud Database**: The data layer uses a Supabase PostgreSQL instance, queried using raw JDBC with PreparedStatement for SQL injection prevention.
- **Design System**: Authentication pages use the **Stitch Material 3** design tokens. All in-app pages use a custom **Brutalist Editorial** theme with Playfair Display + Inter fonts.

---

## 3. Game Modes Deep Dive

**"QuizMaster isn't a one-trick pony. It has 5 distinct game modes, each with different scoring algorithms."**

| Mode | Category ID | Description | XP Multiplier |
|---|---|---|---|
| Teacher Mode | 4 | Detailed explanations for every answer | 0.5x |
| Roast Mode | 2 | AI insults you for wrong answers | 1x |
| Sudden Death | 3 | One wrong answer = game over | 2x |
| Bride Interview | 5 | Life scenario questions (cooking, respect, humor) | 1x |
| Friend Battle | 6 | Multiplayer — create/join rooms with codes | 1.5x |

*Talking Point*: "Each mode maps to a `category_id` in the database. The `QuizServlet` uses this to fetch mode-specific questions. The `ResultServlet` applies mode-specific XP multipliers for scoring."

---

## 4. System Architecture & URL Routing

**"Let me walk you through how a request travels through the system."**

```
Browser → HTTP Request → Tomcat → AuthFilter (session check) → Servlet (business logic) → JSP (view)
```

### Complete URL Route Map

| URL | Servlet | Purpose |
|---|---|---|
| `GET /` | `index.jsp` | Redirects to login |
| `POST /login` | `LoginServlet` | Authentication |
| `GET /login?action=logout` | `LoginServlet` | Session destroy |
| `POST /register` | `RegisterServlet` | Account creation |
| `GET /dashboard` | `QuizServlet` | Load user stats → dashboard |
| `GET /quiz?mode=X` | `QuizServlet` | Fetch questions → quiz arena |
| `POST /submit` | `ResultServlet` | Score + XP + rank update |
| `GET /battle` | `BattleServlet` | Friend Battle lobby |
| `POST /battle` | `BattleServlet` | Create/Join room |
| `GET /admin` | `AdminServlet` | Admin panel |
| `POST /admin/upload` | `UploadServlet` | File upload + question parsing |

*Talking Point*: "Every protected route goes through the AuthFilter first. If the session doesn't exist, the user is redirected to login. Admin routes additionally check for the ADMIN role."

---

## 5. Key Code Snippets to Demonstrate

### 1. Database Connection (`DBConnection.java`)
*Show them how you securely connect using Environment Variables.*
```java
public class DBConnection {
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASS = System.getenv("DB_PASSWORD");

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
```
*Talking Point*: "Credentials are never hardcoded. They're injected via environment variables at runtime — both locally and in Render's deployment."

### 2. Password Hashing (`PasswordUtil.java`)
*Show them you care about security.*
```java
public static String hashPassword(String password) {
    MessageDigest digest = MessageDigest.getInstance("SHA-256");
    byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
    // ... converts to hex string ...
}
```
*Talking Point*: "Plain text passwords are never stored. I used Java's native MessageDigest with SHA-256 hashing."

### 3. Authentication Filter (`AuthFilter.java`)
*Show them your understanding of the Servlet Lifecycle.*
```java
@WebFilter(urlPatterns = {"/pages/user/*", "/pages/modes/*", "/pages/admin/*"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) {
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
*Talking Point*: "Instead of repeating session checks in every servlet, I implemented a Filter — a middleware gatekeeper that demonstrates the DRY principle."

### 4. Transaction Management (`ResultServlet.java`)
*Show them ACID compliance.*
```java
conn.setAutoCommit(false);   // Start transaction

// 1. INSERT quiz attempt (score, XP, mode)
// 2. UPDATE profile (xp, correct/wrong answers)
// 3. UPDATE rank (based on XP thresholds)

conn.commit();               // All succeed together
// On error: conn.rollback() // All fail together
```
*Talking Point*: "These three operations must all succeed or all fail. If the rank update fails, I don't want the XP to be saved either. This is Atomicity — the A in ACID."

### 5. Friend Battle Room Creation (`BattleServlet.java`)
*Show them multiplayer architecture.*
```java
if ("create".equals(action)) {
    String roomCode = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    req.setAttribute("roomCode", roomCode);
    req.getRequestDispatcher("/pages/battle.jsp").forward(req, res);
} else if ("join".equals(action)) {
    res.sendRedirect("/quiz?mode=battle&room=" + roomCode);
}
```
*Talking Point*: "The host creates a room with a unique 6-character code. The friend enters this code to join. Both get the same quiz questions from category 6."

---

## 6. Database Schema Highlights

**"The database has 14 tables designed for scalability."**

Key tables to mention:
- **`users`** — UUID primary key, SHA-256 hashed passwords, role-based access (USER/ADMIN)
- **`profiles`** — XP, rank, total quizzes, correct/wrong answers, coins
- **`quiz_modes`** — 6 modes with JSONB config (timer, roast_intensity, max_players)
- **`questions`** — JSONB options (A/B/C/D), difficulty levels, media support
- **`battle_rooms`** / **`battle_scores`** — Multiplayer room state management
- **Performance indexes** on user lookups, quiz fetching, and attempt history

---

## 7. File Upload System (Admin Feature)

**"Admins can bulk upload questions from .txt, .pdf, or .docx files."**

- `UploadServlet` handles multipart file uploads
- `FileParser` utility extracts text from three formats:
  - `.txt` — Direct text reading
  - `.pdf` — Uses Apache PDFBox library
  - `.docx` — Uses ZipInputStream for XML extraction
- Questions are parsed line-by-line: question line (ends with `?`), 4 options, correct answer
- All inserted in a single database transaction

---

## 8. Deployment Pipeline

```
Local Code → git push → GitHub Repository → Render Webhook
→ Docker Multi-Stage Build → Maven Package → Tomcat WAR → Live
```

- Stage 1 (Maven): `mvn clean package` → produces `QuizMaster.war`
- Stage 2 (Tomcat): Copy WAR to webapps → Tomcat auto-deploys
- Environment variables injected by Render at runtime

---

## 9. Challenges Faced

1. **Context Path Routing** — Ensuring CSS/JS/image paths worked correctly when deployed under a context root vs ROOT. Fixed by dynamically using `request.getContextPath()` everywhere.
2. **Document Parsing** — Reading `.docx` and `.pdf` natively in Java required careful library integration (PDFBox, ZipInputStream for OOXML).
3. **Design Consistency** — Transitioning from the old Material You glassmorphism theme to the new Brutalist Editorial design while keeping backend logic intact.
4. **Session Lifecycle** — Understanding when `HttpSession` is created, validated, and destroyed across different Servlet containers.

---

## 10. Conclusion

**"QuizMaster successfully demonstrates fundamental web application architecture. It proves that with pure Servlets, JSP, and solid software engineering principles — MVC pattern, ACID transactions, session management, and security filters — you can build a highly professional, interactive, and secure web application without relying on heavyweight frameworks."**

**Key differentiators:**
- 5 unique game modes with mode-specific scoring algorithms
- Multiplayer Friend Battle with room code system
- 14-table PostgreSQL schema with JSONB support
- Role-based admin panel with file upload parsing
- Production-ready Docker + Render deployment pipeline
- High-end editorial UI with modern typography
