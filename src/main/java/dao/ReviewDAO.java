package dao;

import Services.Connect;
import database.JDBIConnector;
import model.Review;
import org.jdbi.v3.core.Handle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.stream.Collectors;

public class ReviewDAO {
    private static Handle handle = JDBIConnector.getConnect().open();

    public static boolean addReview(Review review) {
        boolean check = handle.execute("INSERT INTO product_reviews (productID, userID, rating, content) VALUES (?, ?, ?, ?)",
                review.getProductID(), review.getUserID(), review.getRating(), review.getContent()) > 0;
        return check;
    }

    public static List<Review> getReviewsByProductId(int productID) {
        return handle.select("SELECT r.*, u.fullName FROM product_reviews r JOIN users u ON r.userID = u.userID WHERE r.productID = ? ORDER BY r.dateAdded DESC")
                .bind(0, productID)
                .mapToBean(Review.class)
                .collect(Collectors.toList());
    }

    public static boolean hasPurchased(int userID, int productID) {
        int count = handle.createQuery("SELECT COUNT(*) FROM purchases WHERE userID = ? AND productID = ?")
                .bind(0, userID)
                .bind(1, productID)
                .mapTo(Integer.class)
                .one();
        return count > 0;
    }

    public static double getAverageRating(int productID) {
        Double val = handle.createQuery("SELECT AVG(rating) FROM product_reviews WHERE productID = ?")
                .bind(0, productID)
                .mapTo(Double.class)
                .findOne()
                .orElse(0.0);
        return val == null ? 0.0 : val;
    }

    public static int getReviewCount(int productID) {
        return handle.createQuery("SELECT COUNT(*) FROM product_reviews WHERE productID = ?")
                .bind(0, productID)
                .mapTo(Integer.class)
                .one();
    }
}
