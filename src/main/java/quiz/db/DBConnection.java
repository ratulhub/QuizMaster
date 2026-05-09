package quiz.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection handles the connection to the PostgreSQL database (Supabase).
 * 
 * WHY IT EXISTS:
 * It centralizes connection logic. By using Environment Variables, we ensure that
 * sensitive credentials (database passwords) are never hardcoded into the source code,
 * making the application secure and ready for cloud deployment (Render).
 */
public class DBConnection {

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found. Ensure the dependency is added.", e);
        }
    }

    public static Connection getConnection() {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.trim().isEmpty()) {
            throw new IllegalStateException("Database connection failed: DB_URL environment variable is missing.");
        }
        if (user == null || user.trim().isEmpty()) {
            throw new IllegalStateException("Database connection failed: DB_USER environment variable is missing.");
        }
        if (password == null) {
            throw new IllegalStateException("Database connection failed: DB_PASSWORD environment variable is missing.");
        }

        // Automatically append sslmode=require for secure connections like Supabase or Render
        if (!url.contains("sslmode=")) {
            url += (url.contains("?") ? "&" : "?") + "sslmode=require";
        }

        try {
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            throw new RuntimeException("Database connection failed. Please verify your credentials and network connection.", e);
        }
    }
}
