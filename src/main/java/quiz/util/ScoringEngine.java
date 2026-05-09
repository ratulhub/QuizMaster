package quiz.util;

import java.util.Map;
import java.util.HashMap;

public class ScoringEngine {

    public static class ScoreResult {
        public int basePoints;
        public int timeBonus;
        public int comboBonus;
        public int totalPoints;
        public int newStreak;
        
        public ScoreResult(int b, int t, int c, int tot, int s) {
            this.basePoints = b;
            this.timeBonus = t;
            this.comboBonus = c;
            this.totalPoints = tot;
            this.newStreak = s;
        }
    }

    public static ScoreResult calculateScore(boolean isCorrect, int currentStreak, double timeTakenSeconds, String mode) {
        if (!isCorrect) {
            int penalty = mode.equals("roast") ? -5 : 0;
            return new ScoreResult(penalty, 0, 0, penalty, 0);
        }

        int base = 10;
        int timeBonus = (timeTakenSeconds < 5.0) ? 5 : 0;
        int newStreak = currentStreak + 1;
        int comboBonus = (newStreak % 5 == 0) ? 20 : 0; // Bonus every 5 streak
        
        if (mode.equals("sudden_death")) {
            base = 25;
            comboBonus = newStreak * 2; // Progressive multiplier
        } else if (mode.equals("teacher")) {
            base = 8;
        }

        int total = base + timeBonus + comboBonus;
        return new ScoreResult(base, timeBonus, comboBonus, total, newStreak);
    }
}
