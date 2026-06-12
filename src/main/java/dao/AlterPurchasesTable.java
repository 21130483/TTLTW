package dao;

import Services.Connect;
import java.sql.Connection;
import java.sql.Statement;

public class AlterPurchasesTable {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            Statement stmt = conn.createStatement();
            
            try {
                stmt.executeUpdate("ALTER TABLE purchases DROP COLUMN paymentMethod");
                System.out.println("Dropped column paymentMethod successfully.");
            } catch (Exception e) {
                System.out.println("Could not drop column paymentMethod: " + e.getMessage());
            }

            try {
                stmt.executeUpdate("ALTER TABLE purchases DROP COLUMN paymentStatus");
                System.out.println("Dropped column paymentStatus successfully.");
            } catch (Exception e) {
                System.out.println("Could not drop column paymentStatus: " + e.getMessage());
            }

            try {
                stmt.executeUpdate("ALTER TABLE purchases ADD COLUMN payment_method VARCHAR(50) DEFAULT 'cash'");
                System.out.println("Added column payment_method successfully.");
            } catch (Exception e) {
                System.out.println("Column payment_method already exists or error: " + e.getMessage());
            }

            try {
                stmt.executeUpdate("ALTER TABLE purchases ADD COLUMN payment_status INT DEFAULT 0");
                System.out.println("Added column payment_status successfully.");
            } catch (Exception e) {
                System.out.println("Column payment_status already exists or error: " + e.getMessage());
            }

            try {
                stmt.executeUpdate("ALTER TABLE purchases ADD COLUMN cancelReason VARCHAR(255) DEFAULT NULL");
                System.out.println("Added column cancelReason successfully.");
            } catch (Exception e) {
                System.out.println("Column cancelReason already exists or error: " + e.getMessage());
            }

        } catch (Exception e) {
            System.out.println("Database error: " + e.getMessage());
        } finally {
            Connect.closeConnection(conn);
        }
    }
}
