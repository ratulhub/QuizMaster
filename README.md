# QuizMaster — Editorial Edition

> A dynamic, gamified quiz web application built with core Java — no Spring Boot, no shortcuts.
> Featuring a brutalist editorial UI, 5 unique game modes, multiplayer Friend Battle, and full admin controls.

[![Java](https://img.shields.io/badge/Java-Servlets%20%2B%20JSP-orange?style=flat-square)](https://jakarta.ee/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL%20%40%20Supabase-blue?style=flat-square)](https://supabase.com/)
[![Build](https://img.shields.io/badge/Build-Maven-red?style=flat-square)](https://maven.apache.org/)
[![Deploy](https://img.shields.io/badge/Deploy-Docker%20%40%20Render-purple?style=flat-square)](https://render.com/)
[![UI](https://img.shields.io/badge/UI-Editorial%20Brutalist-black?style=flat-square)](#-design-philosophy)

---

## 📌 What is QuizMaster?

QuizMaster is a **monolithic, MVC-based Java web application** that turns learning into a competitive game. Users take quizzes across multiple game modes, earn XP, rank up, and battle friends — all wrapped in a high-end, editorial brutalist UI inspired by modern print design.

Traditional quiz tools like Google Forms or Canvas are static and boring. QuizMaster introduces **gamification** — making every quiz feel like a game, not homework.

---

## 🧩 Game Modes

| Mode | Description | XP | Category ID |
|---|---|---|---|
| **Teacher Mode** | Detailed explanations for every answer. Learn as you play. | 0.5x | 4 |
| **Roast Mode** | Wrong answers trigger AI-generated insult popups | 1x | 2 |
| **Sudden Death** | One wrong answer = instant game over. High stakes. | 2x | 3 |
| **Bride Interview** | Life scenario questions — cooking, religion, respect, humor | 1x | 5 |
| **Friend Battle** | Real-time multiplayer — Create or Join a room with a code | 1.5x | 6 |

---

## 🎨 Design Philosophy

The UI follows a **Brutalist Editorial** design language:

- **Typography-first**: Playfair Display (serif headings) + Inter (body text)
- **Black & white palette** with strategic blue hover accents
- **2px black borders** — no shadows, no rounded corners, no gradients
- **Newspaper-grain texture** background (SVG noise filter)
- **Asymmetric grid layouts** inspired by editorial print magazines
- **Authentication pages** use the Stitch design system (Material 3 tokens) with glassmorphism

### Pages

| Page | Description | Design Style |
|---|---|---|
| `login.jsp` | Sign in with editorial card layout + QuizMaster badge | Stitch M3 tokens |
| `register.jsp` | Create account with glass-panel card + radial gradient | Stitch M3 tokens |
| `dashboard.jsp` | XP, quizzes completed, streak stats + Arena CTA | Editorial brutalist |
| `modes.jsp` | 5 game mode cards in asymmetric 4-column grid | Editorial brutalist |
| `battle.jsp` | Friend Battle lobby — Create Room / Join Room with code | Editorial brutalist |
| `quiz.jsp` | Full-screen MCQ arena with A/B/C/D selection grid | Editorial brutalist |
| `result.jsp` | Score, XP earned, rank display with dashboard/replay links | Editorial brutalist |
| `admin.jsp` | Bulk upload questions (.txt/.pdf/.docx) + system metrics | Editorial brutalist |

---

## 🛠️ Technology Stack

| Layer | Technology | Why |
|---|---|---|
| **Language** | Java 17 | Strongly typed, industry-standard, forces OOP design |
| **Web Layer** | Jakarta EE Servlets + JSP | Raw HTTP lifecycle — no Spring magic |
| **Database** | PostgreSQL (hosted on Supabase) | Most advanced open-source relational DB |
| **DB API** | JDBC | Native Java SQL API — manual connection management |
| **Build Tool** | Maven | Dependency management + WAR packaging |
| **Containerization** | Docker (Multi-stage build) | Environment consistency across all machines |
| **Cloud Hosting** | Render | Auto-deploys from GitHub via webhook |
| **Frontend CSS** | Tailwind CSS (CDN) | Utility-first styling for rapid editorial UI development |
| **Fonts** | Google Fonts (Inter + Playfair Display) | Premium typography without licensing |

---

## 🏗️ Architecture — MVC Pattern

```
┌─────────────────────────────────────────────────┐
│                  BROWSER (View)                 │
│       JSP Pages + Tailwind CSS + JavaScript      │
└────────────────────┬────────────────────────────┘
                     │ HTTP Request
┌────────────────────▼────────────────────────────┐
│             TOMCAT SERVER (Controller)           │
│    AuthFilter → Servlet → Session Management     │
└────────────────────┬────────────────────────────┘
                     │ JDBC / SQL
┌────────────────────▼────────────────────────────┐
│           POSTGRESQL @ SUPABASE (Model)          │
│  users · profiles · quizzes · questions · rooms  │
└─────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
QuizMaster/
├── src/main/java/quiz/
│   ├── servlet/                ← HTTP Controllers
│   │   ├── LoginServlet.java       POST /login      (auth + logout)
│   │   ├── RegisterServlet.java    POST /register   (account creation)
│   │   ├── QuizServlet.java        GET  /dashboard   (stats + quiz loading)
│   │   │                           GET  /quiz?mode=  (question fetching)
│   │   ├── ResultServlet.java      POST /submit      (scoring + XP + rank)
│   │   ├── BattleServlet.java      GET  /battle      (lobby page)
│   │   │                           POST /battle      (create/join room)
│   │   ├── AdminServlet.java       GET  /admin       (admin panel)
│   │   └── UploadServlet.java      POST /admin/upload (file parsing)
│   │
│   ├── filter/
│   │   └── AuthFilter.java     ← Security middleware (route protection)
│   │
│   ├── db/
│   │   └── DBConnection.java   ← Singleton JDBC connector (env vars)
│   │
│   ├── model/
│   │   └── Models.java         ← POJOs: User, Question, QuizAttempt
│   │
│   └── util/
│       ├── PasswordUtil.java   ← SHA-256 password hashing
│       ├── FileParser.java     ← .txt / .pdf / .docx parser for uploads
│       ├── RoastEngine.java    ← Roast Mode insult generator
│       ├── RoastGenerator.java ← Roast message fetcher from DB
│       ├── BrideEngine.java    ← Bride Interview scoring logic
│       └── ScoringEngine.java  ← Mode-specific XP calculation
│
├── src/main/webapp/
│   ├── index.jsp               ← Root redirect → login.jsp
│   ├── assets/
│   │   ├── style.css           ← Legacy Material You styles (admin/result fallback)
│   │   ├── app.js              ← Client-side utilities
│   │   └── images/             ← Mode card artwork (editorial illustrations)
│   ├── pages/
│   │   ├── login.jsp           ← Editorial sign-in (Stitch design)
│   │   ├── register.jsp        ← Editorial sign-up (Stitch design)
│   │   ├── dashboard.jsp       ← Stats + Arena entry (editorial brutalist)
│   │   ├── modes.jsp           ← 5 game mode selection grid
│   │   ├── battle.jsp          ← Friend Battle lobby (create/join room)
│   │   ├── quiz.jsp            ← MCQ arena (dynamic question rendering)
│   │   ├── result.jsp          ← Score debrief + rank update
│   │   └── admin.jsp           ← Bulk upload + system metrics
│   └── WEB-INF/
│       └── web.xml             ← Deployment descriptor
│
├── schema.sql                  ← Full PostgreSQL schema (14 tables)
├── pom.xml                     ← Maven build config
├── Dockerfile                  ← Multi-stage Docker build
└── presentation_notes.md       ← University defense talking points
```

---

## 🔐 Authentication Flow

```
Register  →  SHA-256 Hash Password  →  INSERT into users + profiles + streaks
Login     →  Hash Input  →  Compare with DB hash  →  Create HttpSession
Request   →  Browser sends Session Cookie  →  AuthFilter validates  →  Allow/Deny
Logout    →  session.invalidate()  →  Redirect to login.jsp
```

---

## 🗃️ Database Schema (14 Tables)

| Table | Purpose |
|---|---|
| `users` | Login credentials (UUID PK, username, password_hash, role) |
| `profiles` | Gamification stats — XP, rank, total quizzes, coins (FK → users) |
| `streaks` | Daily login streaks — current, highest, last_login (FK → users) |
| `quiz_modes` | Mode definitions — code, name, xp_multiplier, config JSONB |
| `categories` | Quiz categories (General Knowledge, Science, History, etc.) |
| `quizzes` | Quiz collections (FK → categories, FK → users) |
| `questions` | MCQ questions with JSONB options, difficulty, type (FK → quizzes) |
| `quiz_attempts` | Full attempt history — score, XP earned, metadata (FK → users, modes) |
| `roast_messages` | Insult strings with language and intensity levels |
| `battle_rooms` | Multiplayer room state — host, status, category (FK → users) |
| `battle_scores` | Per-room player scores and readiness (FK → rooms, users) |
| `bride_characters` | Bride Interview NPC characters — name, role, avatar |
| `bride_reactions` | Character dialogue triggers based on meter thresholds |
| `achievements` / `user_achievements` | Unlockable badges with XP rewards |

---

## ♻️ Quiz Gameplay Loop

```
1. User selects a mode          →  modes.jsp
2. QuizServlet maps mode to category_id (teacher=4, roast=2, etc.)
3. SELECT questions WHERE category_id = ? ORDER BY RANDOM() LIMIT 5
4. Questions stored as request attributes (List<Question>)
5. quiz.jsp renders questions with A/B/C/D radio grid
6. User submits answers          →  POST /submit
7. ResultServlet compares answers with correct_answer from DB
8. Score + XP calculated (mode-specific multiplier)
9. Transaction: INSERT quiz_attempts + UPDATE profiles (XP + rank)
10. result.jsp renders score, XP earned, current rank
```

---

## ⚔️ Friend Battle Flow

```
1. User clicks "Friend Battle"  →  GET /battle  →  battle.jsp lobby
2. Option A: Create Room        →  POST /battle (action=create)
   └── Server generates 6-char UUID room code
   └── Room code displayed for sharing
3. Option B: Join Room           →  POST /battle (action=join, roomCode=XXXXXX)
   └── Redirects to /quiz?mode=battle&room=CODE
4. Both players answer same questions (category_id = 6)
5. Scores submitted individually  →  ResultServlet handles scoring
```

---

## 🔒 Security Features

- **Password Hashing** — SHA-256 via `PasswordUtil.java`. Plain text never stored.
- **SQL Injection Prevention** — Exclusively `PreparedStatement` with `?` placeholders.
- **Session Management** — Server-side `HttpSession` with secure cookie-based ID.
- **Route Protection** — `AuthFilter.java` intercepts all protected URLs before they reach Servlets.
- **Role-Based Access** — Admin pages require `session.getAttribute("role") == "ADMIN"`.
- **SSL Enforcement** — `DBConnection.java` appends `sslmode=require` for cloud DB.

---

## ⚙️ Transaction Management (ACID)

In `ResultServlet`, multiple DB operations run atomically:

```java
conn.setAutoCommit(false);           // Start transaction
// 1. INSERT INTO quiz_attempts (score, XP, mode)
// 2. UPDATE profiles SET xp = xp + ?, correct_answers += ?, wrong_answers += ?
// 3. UPDATE profiles SET rank_title = ? (based on new XP threshold)
conn.commit();                       // Save all permanently
// If any error: conn.rollback();    // Undo everything
```

Rank thresholds: **Novice** (0) → **Intermediate** (200) → **Expert** (500) → **Master** (1000)

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

## 🚀 Running Locally

```bash
# 1. Clone the repo
git clone https://github.com/ratulhub/QuizMaster.git

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

## 🗺️ URL Route Map

| Method | URL | Handler | Description |
|---|---|---|---|
| GET | `/` | `index.jsp` | Redirects to login |
| GET/POST | `/login` | `LoginServlet` | Auth + logout (`?action=logout`) |
| POST | `/register` | `RegisterServlet` | Account creation |
| GET | `/dashboard` | `QuizServlet` | Load stats → dashboard.jsp |
| GET | `/quiz?mode=X` | `QuizServlet` | Load questions → quiz.jsp |
| POST | `/submit` | `ResultServlet` | Score + XP → result.jsp |
| GET | `/battle` | `BattleServlet` | Lobby → battle.jsp |
| POST | `/battle` | `BattleServlet` | Create/Join room |
| GET | `/admin` | `AdminServlet` | Admin panel → admin.jsp |
| POST | `/admin/upload` | `UploadServlet` | File parse + DB insert |

---

## 🔮 Future Roadmap

- [ ] **WebSockets** — True real-time multiplayer battles (replace room-code polling)
- [ ] **Redis Caching** — Cache leaderboard queries for high-traffic load
- [ ] **AI Question Generator** — OpenAI API integration for dynamic question creation
- [ ] **Leaderboard** — Global ranking page with top players by XP
- [ ] **Timed Mode** — Per-question countdown with score decay

---

## 👨‍💻 Author

**MD. Abdur Rahim Ratul**  
CSE Student — Khwaja Yunus Ali University  
GitHub: [@ratulhub](https://github.com/ratulhub)  
Portfolio: [ratul.cloud](https://ratul.cloud)

---

*QuizMaster — Editorial Edition • Built with ☕ Java + 🎨 Brutalist Design*