package quiz.util;

import java.util.Random;

public class RoastEngine {

    private static final String[] MILD_ROASTS = {
        "Did you click that by accident?",
        "Are you guessing or just closing your eyes?",
        "Take a deep breath and try reading the question."
    };

    private static final String[] BRUTAL_ROASTS = {
        "Is your brain on airplane mode?",
        "Even a potato could guess better than that.",
        "Error 404: Logic Not Found.",
        "That answer was so wrong, it looped back around and was still wrong."
    };

    private static final String[] BENGALI_ROASTS = {
        "Matha ki kaje lagao naki shudhui shajie rakho?",
        "Ei answer er theke amar pashbalish er buddhi beshi.",
        "Tumi ki asholei exam dichho naki lottery khelchho?"
    };

    public static String getRoast(int consecutiveMistakes, boolean isBengaliMode) {
        Random rand = new Random();
        if (isBengaliMode) {
            return BENGALI_ROASTS[rand.nextInt(BENGALI_ROASTS.length)];
        }
        
        if (consecutiveMistakes >= 3) {
            return BRUTAL_ROASTS[rand.nextInt(BRUTAL_ROASTS.length)];
        } else {
            return MILD_ROASTS[rand.nextInt(MILD_ROASTS.length)];
        }
    }
}
