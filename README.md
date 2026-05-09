# 🎮 QuizMaster

> A dynamic, gamified quiz web application built with core Java — no Spring Boot, no shortcuts.

[![Java](https://img.shields.io/badge/Java-Servlets%20%2B%20JSP-orange?style=flat-square)](https://jakarta.ee/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL%20%40%20Supabase-blue?style=flat-square)](https://supabase.com/)
[![Build](https://img.shields.io/badge/Build-Maven-red?style=flat-square)](https://maven.apache.org/)
[![Deploy](https://img.shields.io/badge/Deploy-Docker%20%40%20Render-purple?style=flat-square)](https://render.com/)

---

## 📌 What is QuizMaster?

QuizMaster is a **monolithic, MVC-based Java web application** that turns learning into a competitive game. Users take quizzes across multiple game modes, earn XP, rank up, and battle friends — all wrapped in a cinematic glassmorphism UI.

Traditional quiz tools like Google Forms or Canvas are static and boring. QuizMaster introduces **gamification** — making every quiz feel like a game, not homework.

---

## 🧩 Game Modes

| Mode | Description | XP |
|---|---|---|
| **Normal** | 15 seconds per question, standard scoring | 1x |
| **Sudden Death** | One wrong answer = instant game over | 2x |
| **Roast Mode** | Wrong answers trigger AI insult popups | 1x |
| **Panic Mode** | Timer speeds up every question | 1.5x |
| **Friend Battle** | Two users compete in the same room | 2x |

---

## 🛠️ Technology Stack

| Layer | Technology | Why |
|---|---|---|
| **Language** | Java | Strongly typed, industry-standard, forces OOP design |
| **Web Layer** | Servlets (Jakarta EE) + JSP | Raw HTTP lifecycle — no Spring magic |
| **Database** | PostgreSQL (hosted on Supabase) | Most advanced open-source relational DB |
| **DB API** | JDBC | Native Java SQL API — understand connections manually |
| **Build Tool** | Maven | Dependency management + WAR packaging |
| **Containerization** | Docker (Multi-stage build) | Environment consistency across all machines |
| **Cloud Hosting** | Render | Auto-deploys from GitHub via webhook |
| **Frontend** | Vanilla HTML / CSS / JS | No React bloat — custom Glassmorphism UI |

---

## 🏗️ Architecture — MVC Pattern

```
┌─────────────────────────────────────────────────┐
│                  BROWSER (View)                 │
│           JSP Pages + CSS + JavaScript           │
└────────────────────┬────────────────────────────┘
                     │ HTTP Request
┌────────────────────▼────────────────────────────┐
│             TOMCAT SERVER (Controller)           │
│    AuthFilter → Servlet → Session Management     │
└────────────────────┬────────────────────────────┘
                     │ JDBC / SQL
┌────────────────────▼────────────────────────────┐
│           POSTGRESQL @ SUPABASE (Model)          │
│    users, profiles, quizzes, questions, scores   │
└─────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
QuizMaster/
├── src/main/java/
│   └── quiz/
│       ├── servlet/          ← All HTTP Controllers (LoginServlet, QuizServlet, etc.)
│       ├── db/               ← DBConnection.java (Singleton DB connector)
│       ├── util/             ← PasswordUtil.java (SHA-256 hashing)
│       ├── filter/           ← AuthFilter.java (Security middleware)
│       └── model/            ← Java model classes (Question, User, etc.)
│
├── src/main/webapp/
│   ├── assets/
│   │   ├── style.css         ← Glassmorphism UI + animations
│   │   └── app.js            ← Particles, timers, toast notifications
│   ├── pages/                ← All JSP files (login, dashboard, quiz, result)
│   └── WEB-INF/              ← Secure folder — not directly URL-accessible
│
├── pom.xml                   ← Maven dependencies + build config
├── Dockerfile                ← Multi-stage Docker build
└── schema.sql                ← Database table definitions
```

---

## 🔐 Authentication Flow

```
Register  →  SHA-256 Hash Password  →  INSERT into users table
Login     →  Hash Input  →  Compare with DB hash  →  Create HttpSession
Request   →  Browser sends Session Cookie  →  AuthFilter validates  →  Allow/Deny
Logout    →  session.invalidate()  →  Session destroyed on server
```

---

## 🗃️ Database Schema (7 Tables)

| Table | Purpose |
|---|---|
| `users` | Stores login credentials (UUID PK, username, password_hash, role) |
| `profiles` | Gamification stats — XP, rank, total quizzes (FK → users) |
| `categories` | Quiz categories (e.g., Science, History) |
| `quizzes` | Quiz collections (FK → categories, FK → users) |
| `questions` | Trivia questions with JSONB options A/B/C/D (FK → quizzes) |
| `quiz_attempts` | Full history of every quiz taken (user_id, score, xp_earned) |
| `roast_messages` | Insult strings for Roast Mode with intensity levels |

---

## ♻️ Quiz Gameplay Loop

```
1. User picks category + mode  →  modes.jsp
2. QuizServlet: SELECT * FROM questions WHERE quiz_id = ?
3. Questions stored in HttpSession as List<Question>
4. quiz.jsp renders question + starts JS countdown timer
5. User submits answer  →  QuizServlet.doPost() checks correct_answer
6. Score incremented / Roast message fetched if wrong
7. index++ → repeat until all questions answered
8. ResultServlet: INSERT quiz_attempts + UPDATE profiles SET xp = xp + ?
9. result.jsp renders final score + confetti animation
```

---

## 🔒 Security Features

- **Password Hashing** — SHA-256 via `PasswordUtil.java`. Plain text never stored.
- **SQL Injection Prevention** — Exclusively `PreparedStatement` with `?` placeholders.
- **Session Management** — Server-side `HttpSession` with secure cookie-based ID.
- **Route Protection** — `AuthFilter.java` intercepts all protected URLs before they reach Servlets.
- **SSL Enforcement** — `DBConnection.java` appends `sslmode=require` for cloud DB.

---

## 🐳 Docker Deployment

Multi-stage Dockerfile:

```dockerfile
# Stage 1: Build
FROM maven:3.9.6 AS build
COPY . .
RUN mvn clean package

# Stage 2: Run
FROM tomcat:10.1
COPY --from=build /target/QuizMaster.war /usr/local/tomcat/webapps/ROOT.war
```

**Deployment Pipeline:**
```
git push → GitHub → Render Webhook → Docker Build → Tomcat Live
```

Environment variables (`DB_URL`, `DB_USER`, `DB_PASSWORD`) are injected by Render at runtime — never hardcoded.

---

## ⚙️ Transaction Management (ACID)

In `ResultServlet`, two DB operations run together safely:

```java
conn.setAutoCommit(false);        // Start transaction
// Query 1: INSERT INTO quiz_attempts
// Query 2: UPDATE profiles SET xp = xp + ?
conn.commit();                    // Save both permanently
// If any error: conn.rollback(); // Undo everything
```

This guarantees **Atomicity** — either both succeed, or neither does.

---

## 🚀 Running Locally

```bash
# 1. Clone the repo
git clone https://github.com/yourusername/QuizMaster.git

# 2. Set environment variables
export DB_URL=your_supabase_jdbc_url
export DB_USER=your_db_user
export DB_PASSWORD=your_db_password

# 3. Build with Maven
mvn clean package

# 4. Deploy WAR to Tomcat
cp target/QuizMaster.war $TOMCAT_HOME/webapps/

# OR run with Docker
docker build -t quizmaster .
docker run -p 8080:8080 \
  -e DB_URL=$DB_URL \
  -e DB_USER=$DB_USER \
  -e DB_PASSWORD=$DB_PASSWORD \
  quizmaster
```

---

## 🔮 Future Roadmap

- [ ] **WebSockets** — True real-time multiplayer battles (replace polling)
- [ ] **Redis Caching** — Cache leaderboard queries for high-traffic load
- [ ] **AI Question Generator** — OpenAI API integration for dynamic question creation
- [ ] **Microservices Migration** — Split into quiz-service, auth-service, leaderboard-service

---

## 👨‍💻 Author

**MD. Abdur Rahim Ratul**  
CSE Student — Khwaja Yunus Ali University  
GitHub: [@ratulhub](https://github.com/ratulhub)  
Portfolio: [ratul.cloud](https://ratul.cloud)

---

*Generated By MD. Abdur Rahim Ratul*