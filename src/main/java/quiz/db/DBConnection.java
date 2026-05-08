package quiz.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASS = System.getenv("DB_PASSWORD");

    static {

        try {

            Class.forName("org.postgresql.Driver");

            System.out.println("PostgreSQL Driver Loaded Successfully");

        } catch (ClassNotFoundException e) {

            System.out.println("PostgreSQL Driver Not Found");

            e.printStackTrace();
        }
    }

    public static Connection getConnection() {

        try {
            if (URL == null || URL.trim().isEmpty()) {
                throw new RuntimeException("DB_URL environment variable is not set!");
            }
            
            // Debug logs
            System.out.println("DB_URL = " + URL);
            System.out.println("DB_USER = " + USER);
            
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Database Connected Successfully");
            return conn;

        } catch (SQLException e) {
            System.err.println("Database Connection Failed!");
            System.err.println("DB_URL: " + URL);
            System.err.println("DB_USER: " + USER);
            e.printStackTrace();
            throw new RuntimeException("Database connection failed. Check DB_URL, DB_USER, DB_PASSWORD env vars.", e);
        }
    }
}
