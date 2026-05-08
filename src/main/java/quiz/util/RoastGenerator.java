package quiz.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import quiz.db.DBConnection;

/**
 * Utility to fetch and generate random roast messages.
 */
public class RoastGenerator {

    private static final List<String> FALLBACK_ROASTS = List.of(
        "Is your brain on airplane mode?",
        "Even a potato could guess better than that.",
        "Error 404: Logic Not Found.",
        "Are you guessing or just closing your eyes?"
    );

    /**
     * Gets a random roast from the database, or falls back to defaults.
     */
    public static String getRandomRoast() {
        List<String> dbRoasts = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT message FROM roast_messages");
             ResultSet rs = ps.executeQuery()) {
             
             while (rs.next()) {
                 dbRoasts.add(rs.getString("message"));
             }
        } catch (Exception e) {
            System.err.println("Failed to load roasts from DB, using fallback.");
        }

        if (dbRoasts.isEmpty()) {
            return FALLBACK_ROASTS.get(new Random().nextInt(FALLBACK_ROASTS.size()));
        }

        return dbRoasts.get(new Random().nextInt(dbRoasts.size()));
    }
}
