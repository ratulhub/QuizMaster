package quiz.util;

import java.util.Map;
import java.util.HashMap;

public class BrideEngine {

    public static class BrideMeters {
        public int respect = 50;
        public int cooking = 50;
        public int religion = 50;
        public int humor = 50;
        public int drama = 0;
        
        public void applyEffects(Map<String, Integer> effects) {
            if (effects.containsKey("respect")) respect += effects.get("respect");
            if (effects.containsKey("cooking")) cooking += effects.get("cooking");
            if (effects.containsKey("religion")) religion += effects.get("religion");
            if (effects.containsKey("humor")) humor += effects.get("humor");
            if (effects.containsKey("drama")) drama += effects.get("drama");
            
            // Clamp values
            respect = Math.max(0, Math.min(100, respect));
            cooking = Math.max(0, Math.min(100, cooking));
            religion = Math.max(0, Math.min(100, religion));
            humor = Math.max(0, Math.min(100, humor));
            drama = Math.max(0, Math.min(100, drama));
        }
    }

    public static String evaluateEnding(BrideMeters meters) {
        if (meters.drama > 80) return "Emergency Family Meeting Needed";
        if (meters.respect > 80 && meters.cooking > 70) return "Mother-in-law Approved";
        if (meters.humor > 80 && meters.respect < 40) return "Chaotic but Funny";
        if (meters.religion > 80 && meters.cooking > 80) return "Village Favorite";
        if (meters.respect > 60 && meters.humor > 60) return "Perfect Bride Candidate";
        return "Too Modern";
    }
}
