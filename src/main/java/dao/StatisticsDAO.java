package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Services.Connect;

public class StatisticsDAO {

    public static class RevenueStat {
        private String timePeriod;
        private double revenue;

        public RevenueStat(String timePeriod, double revenue) {
            this.timePeriod = timePeriod;
            this.revenue = revenue;
        }

        public String getTimePeriod() {
            return timePeriod;
        }

        public double getRevenue() {
            return revenue;
        }
    }

    public static class NewCustomerStat {
        private String timePeriod;
        private int count;

        public NewCustomerStat(String timePeriod, int count) {
            this.timePeriod = timePeriod;
            this.count = count;
        }

        public String getTimePeriod() {
            return timePeriod;
        }

        public int getCount() {
            return count;
        }
    }

    public static class ProductStat {
        private int productID;
        private String name;
        private int totalSold;
        private double totalRevenue;

        public ProductStat(int productID, String name, int totalSold, double totalRevenue) {
            this.productID = productID;
            this.name = name;
            this.totalSold = totalSold;
            this.totalRevenue = totalRevenue;
        }

        public int getProductID() {
            return productID;
        }

        public String getName() {
            return name;
        }

        public int getTotalSold() {
            return totalSold;
        }

        public double getTotalRevenue() {
            return totalRevenue;
        }
    }
// Error: Khi mở bảng thống kê thì nó mới tạo created_at(thời gian tạo user mới)
    public void checkAndCreateCreatedAtColumn() {
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            DatabaseMetaData md = conn.getMetaData();
            try (ResultSet rs = md.getColumns(null, null, "users", "created_at")) {
                if (!rs.next()) {
                    try (Statement stmt = conn.createStatement()) {
                        stmt.executeUpdate("ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
    }

    public List<RevenueStat> getDailyRevenue() {
        List<RevenueStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT orderDate, SUM(price) AS dailyRevenue FROM purchases WHERE status = 2 GROUP BY orderDate ORDER BY orderDate DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new RevenueStat(rs.getString("orderDate"), rs.getDouble("dailyRevenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public List<RevenueStat> getMonthlyRevenue() {
        List<RevenueStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT DATE_FORMAT(orderDate, '%Y-%m') AS month, SUM(price) AS monthlyRevenue FROM purchases WHERE status = 2 GROUP BY DATE_FORMAT(orderDate, '%Y-%m') ORDER BY month DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new RevenueStat(rs.getString("month"), rs.getDouble("monthlyRevenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public List<RevenueStat> getYearlyRevenue() {
        List<RevenueStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT YEAR(orderDate) AS year, SUM(price) AS yearlyRevenue FROM purchases WHERE status = 2 GROUP BY YEAR(orderDate) ORDER BY year DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new RevenueStat(rs.getString("year"), rs.getDouble("yearlyRevenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public double getAverageOrderValue() {
        double avg = 0;
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT AVG(order_total) AS avgOrderValue FROM (SELECT purchaseID, SUM(price) AS order_total FROM purchases WHERE status = 2 GROUP BY purchaseID) AS order_totals";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    avg = rs.getDouble("avgOrderValue");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return avg;
    }

    public List<NewCustomerStat> getDailyNewCustomers() {
        List<NewCustomerStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT DATE(created_at) AS date, COUNT(*) AS newCustomers FROM users GROUP BY DATE(created_at) ORDER BY date DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new NewCustomerStat(rs.getString("date"), rs.getInt("newCustomers")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public List<NewCustomerStat> getMonthlyNewCustomers() {
        List<NewCustomerStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS month, COUNT(*) AS newCustomers FROM users GROUP BY DATE_FORMAT(created_at, '%Y-%m') ORDER BY month DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new NewCustomerStat(rs.getString("month"), rs.getInt("newCustomers")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public List<NewCustomerStat> getYearlyNewCustomers() {
        List<NewCustomerStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT YEAR(created_at) AS year, COUNT(*) AS newCustomers FROM users GROUP BY YEAR(created_at) ORDER BY year DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new NewCustomerStat(rs.getString("year"), rs.getInt("newCustomers")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }

    public List<ProductStat> getTopSellingProducts() {
        List<ProductStat> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = Connect.getConnection();
            String sql = "SELECT p.productID, p.name, SUM(pu.quantity) AS totalSold, SUM(pu.price) AS totalRevenue FROM purchases pu JOIN products p ON pu.productID = p.productID WHERE pu.status = 2 GROUP BY p.productID, p.name ORDER BY totalSold DESC LIMIT 10";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ProductStat(rs.getInt("productID"), rs.getString("name"), rs.getInt("totalSold"), rs.getDouble("totalRevenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Connect.closeConnection(conn);
        }
        return list;
    }
}
