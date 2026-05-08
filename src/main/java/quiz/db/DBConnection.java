package quiz.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Supabase PostgreSQL Credentials
    private static final String URL = System.getenv("DB_URL");
private static final String USER = System.getenv("DB_USER");
private static final String PASS = System.getenv("DB_PASSWORD");
    static {
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC Driver is not found. Include it in your library path.");
            e.printStackTrace();
        }
    }

    private static String getEnv(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.trim().isEmpty()) ? value : defaultValue;
    }

    /**
     * Gets a connection to the Supabase PostgreSQL database.
     * Ensure to close this connection using try-with-resources.
     *
     * @return Connection object
     */
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            System.err.println("Connection Failed! Check output console");
            e.printStackTrace();
            return null;
        }
    }
}