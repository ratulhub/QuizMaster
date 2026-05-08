-- ==========================================
-- QuizMaster - Supabase PostgreSQL Schema
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
    wrong_answers INTEGER DEFAULT 0
);

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
    xp_multiplier DECIMAL(3,2) DEFAULT 1.0
);

-- 5. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- 6. Quizzes Table (Used by AdminServlet & UploadServlet)
CREATE TABLE IF NOT EXISTS quizzes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 7. Questions Table (Used by UploadServlet)
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER REFERENCES quizzes(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    correct_option VARCHAR(1) NOT NULL
);

-- 8. Quiz Attempts Table (History)
CREATE TABLE IF NOT EXISTS quiz_attempts (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    mode_id INTEGER REFERENCES quiz_modes(id),
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    xp_earned INTEGER DEFAULT 0,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 9. Roast Messages Table (Used by RoastGenerator)
CREATE TABLE IF NOT EXISTS roast_messages (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL
);

-- ==========================================
-- Insert Default Data
-- ==========================================

-- Insert Default Game Modes
INSERT INTO quiz_modes (code, name, description, xp_multiplier) VALUES
('normal', 'Normal Mode', 'Standard 10-question assessment.', 1.0),
('roast', 'Roast Mode', 'AI relentlessly mocks incorrect answers.', 1.0),
('sudden_death', 'Sudden Death', 'One mistake and it''s over.', 2.0),
('teacher', 'Teacher Mode', 'Provides detailed explanations.', 0.5),
('bride', 'Bride Interview', 'Answer life scenario questions.', 1.0),
('battle', 'Friend Battle', 'Multiplayer real-time competition.', 1.5)
ON CONFLICT (code) DO NOTHING;

-- Insert Default Categories
INSERT INTO categories (name) VALUES
('General Knowledge'),
('Science'),
('History'),
('Technology'),
('Mathematics')
ON CONFLICT (name) DO NOTHING;

-- Insert Default Roast Messages
INSERT INTO roast_messages (message) VALUES
('Is your brain on airplane mode?'),
('Even a potato could guess better than that.'),
('Error 404: Logic Not Found.'),
('Are you guessing or just closing your eyes?'),
('My grandma could answer that, and she doesn''t even use a computer.'),
('You picked THAT answer? Bold strategy, let''s see if it pays off. Spoiler: it won''t.'),
('I''ve seen smarter choices from a random number generator.'),
('That answer was so wrong, it looped back around and was still wrong.')
ON CONFLICT DO NOTHING;

-- Create an Admin user (Password is 'admin123')
-- Note: Replace this hash in production with a proper bcrypt hash
INSERT INTO users (id, username, password_hash, role) VALUES 
('00000000-0000-0000-0000-000000000000', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'ADMIN')
ON CONFLICT (username) DO NOTHING;

INSERT INTO profiles (user_id, xp, rank_title) VALUES 
('00000000-0000-0000-0000-000000000000', 9999, 'Grandmaster')
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO streaks (user_id, current_streak, highest_streak, last_login) VALUES 
('00000000-0000-0000-0000-000000000000', 100, 100, CURRENT_DATE)
ON CONFLICT (user_id) DO NOTHING;

-- ==========================================
-- Indexes for Performance Optimization
-- ==========================================
CREATE INDEX IF NOT EXISTS idx_attempts_user ON quiz_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_questions_quiz ON questions(quiz_id);
CREATE INDEX IF NOT EXISTS idx_quizzes_category ON quizzes(category_id);
