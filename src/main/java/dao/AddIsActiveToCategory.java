package dao;

import Services.Connect;
import java.sql.Connection;
import java.sql.Statement;

public class AddIsActiveToCategory {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            Statement stmt = conn.createStatement();

            String sql = "ALTER TABLE category ADD COLUMN isActive INT DEFAULT 1 NOT NULL";
            stmt.executeUpdate(sql);
            System.out.println("Thêm cột isActive vào bảng category thành công!");

            String updateSql = "UPDATE category SET isActive = 1 WHERE isActive IS NULL";
            stmt.executeUpdate(updateSql);
            System.out.println("Cập nhật dữ liệu hiện có thành công!");

        } catch (Exception e) {
            System.out.println("Lỗi (có thể cột đã tồn tại): " + e.getMessage());
        } finally {
            Connect.closeConnection(conn);
        }
    }
}
