package dao;

import database.JDBIConnector;
import model.Cart;
import model.Product;
import org.jdbi.v3.core.Handle;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CartsDAO {

    public CartsDAO() {
    }

    /**
     * Lấy toàn bộ danh sách sản phẩm trong giỏ hàng của một người dùng
     * (Chỉ chọn đúng 3 cột tương ứng với các thuộc tính trong lớp Carts)
     */
    public static List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        try (Handle handle = JDBIConnector.getConnect().open()) {
            cartList =  handle.select("SELECT userID, productID, quantity FROM carts WHERE userID = ?")
                    .bind(0, userId)
                    .mapToBean(Cart.class)
                    .collect(Collectors.toList());
            for (Cart item : cartList) {
                // Giả định bạn đã có class ProductDAO và hàm getProductById
                Product p = ProductDAO.getProductById(item.getProductId());

                // Gán đối tượng Product vừa tìm được vào thuộc tính product của Cart
                item.setProduct(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartList;
    }

    /**
     * Kiểm tra xem một sản phẩm cụ thể đã tồn tại trong giỏ của user đó chưa
     */
    public static boolean checkProductInCart(int userId, int productId) {
        try (Handle handle = JDBIConnector.getConnect().open()) {
            int count = handle.createQuery("SELECT COUNT(*) FROM carts WHERE userID = ? AND productID = ?")
                    .bind(0, userId)
                    .bind(1, productId)
                    .mapTo(Integer.class)
                    .one();
            return count > 0;
        }
    }

    /**
     * Lấy số lượng hiện tại của một sản phẩm nằm trong giỏ hàng
     */
    public static int getQuantityInCart(int userId, int productId) {
        if (!checkProductInCart(userId, productId)) return 0;
        try (Handle handle = JDBIConnector.getConnect().open()) {
            return handle.createQuery("SELECT quantity FROM carts WHERE userID = ? AND productID = ?")
                    .bind(0, userId)
                    .bind(1, productId)
                    .mapTo(Integer.class)
                    .one();
        }
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     * ĐÃ LOẠI BỎ dateAdded. Nếu trùng sản phẩm, tự động cộng dồn số lượng.
     */
    public static boolean addToCart(int userId, int productId, int quantity) {
        String sql = "INSERT INTO carts (userID, productID, quantity) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
        try (Handle handle = JDBIConnector.getConnect().open()) {
            return handle.execute(sql, userId, productId, quantity, quantity) > 0;
        }
    }

    /**
     * Thay đổi trực tiếp số lượng sản phẩm trong giỏ
     */
    public static boolean updateQuantity(int userId, int productId, int newQuantity) {
        try (Handle handle = JDBIConnector.getConnect().open()) {
            boolean check = handle.execute("UPDATE carts SET quantity = ? WHERE userID = ? AND productID = ?",
                    newQuantity, userId, productId) > 0;
            return check;
        }
    }

    /**
     * Xóa một sản phẩm cụ thể ra khỏi giỏ hàng
     */
    public static boolean removeFromCart(int userId, int productId) {

        try (Handle handle = JDBIConnector.getConnect().open()) {
            boolean check = handle.execute("DELETE FROM carts WHERE userID = ? AND productID = ?", userId, productId) > 0;
            return check;
        }
    }

    /**
     * Xóa sạch toàn bộ giỏ hàng của người dùng
     */
    public static boolean clearCart(int userId) {

        try (Handle handle = JDBIConnector.getConnect().open()) {
            boolean check = handle.execute("DELETE FROM carts WHERE userID = ?", userId) > 0;
            return check;
        }
    }

    public static void main(String[] args) {
        // Chạy thử nghiệm hàm main để kiểm tra kết quả
        System.out.println("Thêm vào giỏ: " + addToCart(1, 2, 5));
        System.out.println("Danh sách giỏ hàng: " + getCartByUserId(1));
    }
}