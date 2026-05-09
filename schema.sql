-- ==========================================
-- QuizMaster - Supabase PostgreSQL Schema (V2.0)
-- ==========================================

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Profiles Table (For gamification)
CREATE TABLE IF NOT EXISTS profiles (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    xp INTEGER DEFAULT 0,
    rank_title VARCHAR(50) DEFAULT 'Novice',
    total_quizzes_taken INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    wrong_answers INTEGER DEFAULT 0,
    coins INTEGER DEFAULT 0
);
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS coins INTEGER DEFAULT 0;

-- 3. Streaks Table (For daily streaks)
CREATE TABLE IF NOT EXISTS streaks (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    current_streak INTEGER DEFAULT 0,
    highest_streak INTEGER DEFAULT 0,
    last_login DATE
);

-- 4. Quiz Modes Table
CREATE TABLE IF NOT EXISTS quiz_modes (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    xp_multiplier DECIMAL(3,2) DEFAULT 1.0,
    config JSONB -- e.g., {"timer": 30, "roast_intensity": "HIGH"}
);
ALTER TABLE quiz_modes ADD COLUMN IF NOT EXISTS config JSONB;

-- 5. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- 6. Quizzes Table (Collections of Questions)
CREATE TABLE IF NOT EXISTS quizzes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 7. Questions Table (Dynamic V2)
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER REFERENCES quizzes(id) ON DELETE CASCADE,
    type VARCHAR(20) DEFAULT 'MCQ', -- MCQ, TRUE_FALSE, SCENARIO
    difficulty VARCHAR(20) DEFAULT 'NORMAL',
    question_text TEXT NOT NULL,
    media_url TEXT,
    options JSONB, -- Stores dynamic options: {"A": "Yes", "B": "No"}
    correct_answer TEXT,
    base_points INTEGER DEFAULT 10,
    metadata JSONB -- e.g., {"bride_meter_effects": {"respect": +10}}
);
ALTER TABLE questions ADD COLUMN IF NOT EXISTS type VARCHAR(20) DEFAULT 'MCQ';
ALTER TABLE questions ADD COLUMN IF NOT EXISTS difficulty VARCHAR(20) DEFAULT 'NORMAL';
ALTER TABLE questions ADD COLUMN IF NOT EXISTS media_url TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS options JSONB;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS correct_answer TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS base_points INTEGER DEFAULT 10;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS metadata JSONB;

-- 8. Quiz Attempts Table (History)
CREATE TABLE IF NOT EXISTS quiz_attempts (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    mode_id INTEGER REFERENCES quiz_modes(id),
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    xp_earned INTEGER DEFAULT 0,
    metadata JSONB, -- Stores stats like speed_bonus, combo_streak
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE quiz_attempts ADD COLUMN IF NOT EXISTS metadata JSONB;

-- 9. Roast Messages Table
CREATE TABLE IF NOT EXISTS roast_messages (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL,
    language VARCHAR(5) DEFAULT 'EN',
    intensity INTEGER DEFAULT 1,
    category VARCHAR(50) DEFAULT 'GENERAL'
);
ALTER TABLE roast_messages ADD COLUMN IF NOT EXISTS language VARCHAR(5) DEFAULT 'EN';
ALTER TABLE roast_messages ADD COLUMN IF NOT EXISTS intensity INTEGER DEFAULT 1;
ALTER TABLE roast_messages ADD COLUMN IF NOT EXISTS category VARCHAR(50) DEFAULT 'GENERAL';

-- 10. Multiplayer Rooms (Friend Battle)
CREATE TABLE IF NOT EXISTS battle_rooms (
    id VARCHAR(10) PRIMARY KEY,
    host_id UUID REFERENCES users(id),
    status VARCHAR(20) DEFAULT 'WAITING',
    category_id INTEGER REFERENCES categories(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS battle_scores (
    room_id VARCHAR(10) REFERENCES battle_rooms(id),
    user_id UUID REFERENCES users(id),
    score INTEGER DEFAULT 0,
    is_ready BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(room_id, user_id)
);

-- 11. Bride Interview Mode Characters
CREATE TABLE IF NOT EXISTS bride_characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50),
    avatar_url TEXT
);

CREATE TABLE IF NOT EXISTS bride_reactions (
    id SERIAL PRIMARY KEY,
    character_id INTEGER REFERENCES bride_characters(id),
    trigger_meter VARCHAR(20),
    threshold INTEGER,
    dialogue_bn TEXT,
    dialogue_en TEXT
);

-- 12. Achievements
CREATE TABLE IF NOT EXISTS achievements (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    xp_reward INTEGER DEFAULT 50,
    icon_url TEXT
);

CREATE TABLE IF NOT EXISTS user_achievements (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    achievement_id INTEGER REFERENCES achievements(id) ON DELETE CASCADE,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(user_id, achievement_id)
);


-- ==========================================
-- Insert Default Data
-- ==========================================

-- Insert Default Game Modes
INSERT INTO quiz_modes (code, name, description, xp_multiplier, config) VALUES
('normal', 'Normal Mode', 'Standard 10-question assessment.', 1.0, '{"timer": 15, "negative_marking": false}'),
('roast', 'Roast Mode', 'AI relentlessly mocks incorrect answers.', 1.0, '{"timer": 15, "roast_intensity": "HIGH"}'),
('sudden_death', 'Sudden Death', 'One mistake and it''s over.', 2.0, '{"timer": 10, "time_decay": 0.5}'),
('teacher', 'Teacher Mode', 'Provides detailed explanations.', 0.5, '{"timer": 60, "hints_enabled": true}'),
('bride', 'Bride Interview', 'Answer life scenario questions.', 1.0, '{"meters": ["cooking", "religion", "respect", "humor", "drama"]}'),
('battle', 'Friend Battle', 'Multiplayer real-time competition.', 1.5, '{"max_players": 4}')
ON CONFLICT (code) DO NOTHING;

-- Insert Default Categories
INSERT INTO categories (name) VALUES
('General Knowledge'),
('Science'),
('History'),
('Technology'),
('Mathematics'),
('Household Management'),
('Social Behavior')
ON CONFLICT (name) DO NOTHING;

-- Create an Admin user (Password is 'admin123')
INSERT INTO users (id, username, password_hash, role) VALUES 
('00000000-0000-0000-0000-000000000000', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'ADMIN')
ON CONFLICT (username) DO NOTHING;

INSERT INTO profiles (user_id, xp, rank_title) VALUES 
('00000000-0000-0000-0000-000000000000', 9999, 'Grandmaster')
ON CONFLICT (user_id) DO NOTHING;

-- ==========================================
-- Indexes for Performance Optimization
-- ==========================================
CREATE INDEX IF NOT EXISTS idx_attempts_user ON quiz_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_questions_quiz ON questions(quiz_id);
CREATE INDEX IF NOT EXISTS idx_quizzes_category ON quizzes(category_id);
CREATE INDEX IF NOT EXISTS idx_questions_type ON questions(type);
