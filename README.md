<div align="center">

# ⚡ QuizMaster — Editorial Edition

**A university-grade Java web application where quizzes feel like games.**

[![Live Demo](https://img.shields.io/badge/🌐_Live_Demo-quizmaster--yrb1.onrender.com-black?style=for-the-badge)](https://quizmaster-yrb1.onrender.com/)
[![Java](https://img.shields.io/badge/Java_17-Servlets_+_JSP-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://jakarta.ee/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supabase-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://supabase.com/)
[![Docker](https://img.shields.io/badge/Docker-Render-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://render.com/)

> ⚠️ Hosted on Render free tier — first load may take 30–60 seconds to spin up.

</div>

---

## 📺 Preview

<div align="center">

[![QuizMaster Preview](https://img.youtube.com/vi/62UK-NiEePI/maxresdefault.jpg)](https://youtu.be/62UK-NiEePI)

*▶ Click to watch the full app walkthrough*

</div>

---

## 🧠 What It Does

QuizMaster turns static MCQ quizzes into a **competitive, gamified experience** — with XP, ranks, streaks, AI-powered roast messages, real-time friend battles, and a full admin panel for bulk question uploads.

Built from scratch with **raw Java Servlets + JSP** (no Spring), **PostgreSQL on Supabase**, and deployed via **Docker on Render**.

---

## ⚙️ How It Works — End to End

```
Browser (JSP + Tailwind CSS)
        │
        │ HTTP Request
        ▼
AuthFilter.java          ← Intercepts every request, validates HttpSession
        │
        ▼
Servlet (Controller)     ← Routes request, queries DB, sets attributes
        │
        │ JDBC / PreparedStatement
        ▼
PostgreSQL @ Supabase    ← 14 tables: users, questions, quiz_attempts, battle_rooms, etc.
        │
        ▼
JSP View                 ← Renders response with session + request attributes
```

### Request Lifecycle

| Step | What happens |
|------|-------------|
| 1 | User hits any protected URL |
| 2 | `AuthFilter` checks `HttpSession` — redirects to `/login` if invalid |
| 3 | Servlet reads request params, runs `PreparedStatement` queries |
| 4 | Model data (POJOs) set as request attributes |
| 5 | JSP renders HTML with dynamic data |
| 6 | Response sent — session cookie maintained |

---

## 🎮 Game Modes

| Mode | How It Works | XP Multiplier |
|------|-------------|:---:|
| **Teacher Mode** | Shows detailed explanation after every answer | 0.5× |
| **Roast Mode** | Wrong answer → AI-generated insult popup from DB | 1× |
| **Sudden Death** | First wrong answer ends the game immediately | 2× |
| **Bride Interview** | Life scenario Qs scored against NPC character reactions | 1× |
| **Friend Battle** | 6-char room code → both players answer same question set | 1.5× |

---

## 🔄 Quiz Gameplay Loop

```
1. User picks a mode                 → modes.jsp
2. QuizServlet maps mode → category_id
   (teacher=4, roast=2, sudden_death=3, bride=5, battle=6)
3. SELECT questions WHERE category_id=? ORDER BY RANDOM() LIMIT 5
4. quiz.jsp renders A/B/C/D MCQ grid
5. User submits answers              → POST /submit
6. ResultServlet compares with correct_answer from DB
7. conn.setAutoCommit(false)
   ├─ INSERT INTO quiz_attempts (score, xp, mode, metadata)
   ├─ UPDATE profiles SET xp = xp + ?, correct_answers += ?
   └─ UPDATE profiles SET rank_title = ? (threshold check)
   conn.commit() / conn.rollback()
8. result.jsp shows score, XP earned, current rank
```

---

## ⚔️ Friend Battle Flow

```
Player A: POST /battle (action=create)
  └─ Server generates 6-char room code
  └─ Inserts battle_rooms row (status=waiting)
  └─ Room code shown on screen

Player B: POST /battle (action=join, roomCode=XXXXXX)
  └─ Validates room exists + is open
  └─ Redirects both to /quiz?mode=battle&room=CODE

Both players answer independently
  └─ Scores stored in battle_scores (FK → rooms, users)
  └─ ResultServlet handles XP for each individually
```

---

## 🔐 Authentication & Security

| Concern | Implementation |
|---------|---------------|
| Password storage | SHA-256 hash via `PasswordUtil.java` — plain text never stored |
| SQL injection | 100% `PreparedStatement` with `?` placeholders — no string concatenation |
| Session management | Server-side `HttpSession` with cookie-based session ID |
| Route protection | `AuthFilter.java` wraps every protected URL before Servlets run |
| Role-based access | `session.getAttribute("role") == "ADMIN"` check on admin routes |
| DB connection | `sslmode=require` enforced in JDBC URL |

---

## 🗃️ Database — 14 Tables

```sql
users           → credentials (UUID PK, username, password_hash, role)
profiles        → XP, rank_title, total_quizzes, coins  (FK → users)
streaks         → current_streak, highest, last_login    (FK → users)
quiz_modes      → mode code, name, xp_multiplier, config (JSONB)
categories      → quiz category labels
quizzes         → quiz collections                       (FK → categories)
questions       → MCQ with JSONB options, correct_answer (FK → quizzes)
quiz_attempts   → full attempt history + score + XP      (FK → users, modes)
roast_messages  → insult strings by language + intensity
battle_rooms    → room state, host, status, category     (FK → users)
battle_scores   → per-room player scores + readiness     (FK → rooms, users)
bride_characters → NPC names, roles, avatars
bride_reactions  → dialogue triggers on meter thresholds
achievements / user_achievements → badges with XP rewards
```

---

## 🏗️ Project Structure

```
QuizMaster/
├── src/main/java/quiz/
│   ├── servlet/         ← HTTP controllers (Login, Register, Quiz, Result, Battle, Admin, Upload)
│   ├── filter/          ← AuthFilter.java — session guard on all routes
│   ├── db/              ← DBConnection.java — singleton JDBC (env-var driven)
│   ├── model/           ← POJOs: User, Question, QuizAttempt
│   └── util/            ← PasswordUtil, FileParser, RoastEngine, ScoringEngine, BrideEngine
│
├── src/main/webapp/
│   ├── pages/           ← login.jsp, register.jsp, dashboard.jsp, modes.jsp,
│   │                       battle.jsp, quiz.jsp, result.jsp, admin.jsp
│   ├── assets/          ← style.css, app.js, images/
│   ├── index.jsp        ← Root → redirects to /login
│   └── WEB-INF/web.xml  ← Servlet mappings + filter config
│
├── schema.sql           ← Full 14-table PostgreSQL schema
├── pom.xml              ← Maven: servlet-api, postgresql, iText, Apache POI
└── Dockerfile           ← Multi-stage: Maven build → Tomcat runtime
```

---

## 🌐 Route Map

| Method | URL | Servlet | Action |
|--------|-----|---------|--------|
| GET/POST | `/login` | `LoginServlet` | Auth + `?action=logout` |
| POST | `/register` | `RegisterServlet` | Create account |
| GET | `/dashboard` | `QuizServlet` | Load user stats |
| GET | `/quiz?mode=X` | `QuizServlet` | Fetch questions for mode |
| POST | `/submit` | `ResultServlet` | Score + XP transaction |
| GET | `/battle` | `BattleServlet` | Room lobby |
| POST | `/battle` | `BattleServlet` | Create / join room |
| GET | `/admin` | `AdminServlet` | Admin panel (ADMIN role only) |
| POST | `/admin/upload` | `UploadServlet` | Parse .txt/.pdf/.docx → DB insert |

---

## 🎨 UI Design System

Two distinct visual layers:

- **Auth pages** (`login.jsp`, `register.jsp`) — Glassmorphism with radial gradients, Material 3 tokens
- **App pages** (dashboard → result) — Brutalist Editorial: Playfair Display headings, Inter body, 2px black borders, no shadows, no rounded corners, newspaper-grain SVG texture background

---

## 🐳 Deploy

```dockerfile
# Stage 1 — Build
FROM maven:3.9.6 AS build
COPY . .
RUN mvn clean package

# Stage 2 — Run
FROM tomcat:10.1
COPY --from=build /target/QuizMaster.war /usr/local/tomcat/webapps/ROOT.war
```

```bash
# Local run with Docker
docker build -t quizmaster .
docker run -p 8080:8080 \
  -e DB_URL=your_supabase_jdbc_url \
  -e DB_USER=your_user \
  -e DB_PASSWORD=your_password \
  quizmaster
```

**CI/CD:** `git push` → GitHub → Render webhook → Docker build → live on Tomcat

---

## 📈 Rank System

| Rank | XP Required |
|------|:-----------:|
| Novice | 0 |
| Intermediate | 200 |
| Expert | 500 |
| Master | 1000 |

---

## 🔮 Roadmap

- [ ] WebSockets — true real-time battles (replace room-code polling)
- [ ] Redis — leaderboard query caching
- [ ] AI Question Generator — OpenAI API integration
- [ ] Timed Mode — per-question countdown with score decay
- [ ] Global Leaderboard — top players by XP

---

<div align="center">

**Built with ☕ Java + 🎨 Brutalist Design**

[Live App](https://quizmaster-yrb1.onrender.com/) · [GitHub](https://github.com/ratulhub/QuizMaster) · [Portfolio](https://ratul.site)

*Created by MD. Abdur Rahim Ratul*

</div>
