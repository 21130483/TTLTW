package dao;

import Services.Connect;
import java.sql.Connection;
import java.sql.Statement;

public class AlterDatabase {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            Statement stmt = conn.createStatement();
            String sql = "ALTER TABLE users ADD COLUMN isVerifyEmail VARCHAR(10) DEFAULT 'false'";
            stmt.executeUpdate(sql);
            System.out.println("Thêm cột isVerifyEmail thành công!");
        } catch (Exception e) {
            System.out.println("Lỗi (có thể cột đã tồn tại): " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
    }
}
