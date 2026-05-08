package quiz.model;

import java.util.UUID;

/**
 * Consolidated Models to keep the project structure minimal and clean.
 * Contains all the data objects used throughout the application.
 */
public class Models {

    public static class User {
        private UUID id;
        private String username;
        private String role;
        private int xp;
        private String rankTitle;

        public User() {}
        public User(UUID id, String username, String role, int xp, String rankTitle) {
            this.id = id; this.username = username; this.role = role;
            this.xp = xp; this.rankTitle = rankTitle;
        }
        public UUID getId() { return id; }
        public void setId(UUID id) { this.id = id; }
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getRole() { return role; }
        public void setRole(String role) { this.role = role; }
        public int getXp() { return xp; }
        public void setXp(int xp) { this.xp = xp; }
        public String getRankTitle() { return rankTitle; }
        public void setRankTitle(String rankTitle) { this.rankTitle = rankTitle; }
    }

    public static class Question {
        private int id;
        private int quizId;
        private String text;
        private String optionA;
        private String optionB;
        private String optionC;
        private String optionD;
        private String correctOption;

        public Question() {}
        public Question(int id, int quizId, String text, String optionA, String optionB, String optionC, String optionD, String correctOption) {
            this.id = id; this.quizId = quizId; this.text = text;
            this.optionA = optionA; this.optionB = optionB;
            this.optionC = optionC; this.optionD = optionD;
            this.correctOption = correctOption;
        }
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public int getQuizId() { return quizId; }
        public void setQuizId(int quizId) { this.quizId = quizId; }
        public String getText() { return text; }
        public void setText(String text) { this.text = text; }
        public String getOptionA() { return optionA; }
        public void setOptionA(String optionA) { this.optionA = optionA; }
        public String getOptionB() { return optionB; }
        public void setOptionB(String optionB) { this.optionB = optionB; }
        public String getOptionC() { return optionC; }
        public void setOptionC(String optionC) { this.optionC = optionC; }
        public String getOptionD() { return optionD; }
        public void setOptionD(String optionD) { this.optionD = optionD; }
        public String getCorrectOption() { return correctOption; }
        public void setCorrectOption(String correctOption) { this.correctOption = correctOption; }
    }

    public static class Quiz {
        private int id;
        private String title;
        private String category;
        private int totalQuestions;

        public Quiz() {}
        public Quiz(int id, String title, String category, int totalQuestions) {
            this.id = id; this.title = title;
            this.category = category; this.totalQuestions = totalQuestions;
        }
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getCategory() { return category; }
        public void setCategory(String category) { this.category = category; }
        public int getTotalQuestions() { return totalQuestions; }
        public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
    }

    public static class Achievement {
        private int id;
        private String code;
        private String title;
        private String description;
        private int xpReward;

        public Achievement() {}
        public Achievement(int id, String code, String title, String description, int xpReward) {
            this.id = id; this.code = code; this.title = title;
            this.description = description; this.xpReward = xpReward;
        }
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getCode() { return code; }
        public void setCode(String code) { this.code = code; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        public int getXpReward() { return xpReward; }
        public void setXpReward(int xpReward) { this.xpReward = xpReward; }
    }

    public static class BattleRoom {
        private int id;
        private String roomCode;
        private UUID hostId;
        private String status;

        public BattleRoom() {}
        public BattleRoom(int id, String roomCode, UUID hostId, String status) {
            this.id = id; this.roomCode = roomCode;
            this.hostId = hostId; this.status = status;
        }
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getRoomCode() { return roomCode; }
        public void setRoomCode(String roomCode) { this.roomCode = roomCode; }
        public UUID getHostId() { return hostId; }
        public void setHostId(UUID hostId) { this.hostId = hostId; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
}
