package quiz.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Supabase PostgreSQL Credentials
    private static final String URL = getEnv("DB_URL", "jdbc:postgresql://db.zvubcokrvfltmcjfiqof.supabase.co:5432/postgres?user=postgres&password=[PASS]");
    private static final String USER = getEnv("DB_USER", "ratul2005");
    private static final String PASS = getEnv("DB_PASSWORD", "hiratul123#R");

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