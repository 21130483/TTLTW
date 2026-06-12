package dao;

import database.JDBIConnector;
import model.Product;
import model.Purchases;
import org.jdbi.v3.core.Jdbi;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PurchasesDAO {
    private static final Jdbi connect = JDBIConnector.getConnect();

    public PurchasesDAO() {
    }

    public static Purchases getPurchaseById(int id) {
        return connect.withHandle(handle -> 
            handle.select("SELECT * FROM purchases WHERE purchaseID = ? LIMIT 1")
                  .bind(0, id)
                  .mapToBean(Purchases.class)
                  .findOne()
                  .orElse(null)
        );
    }

    public static int countByPurchaseID(int id) {
        return connect.withHandle(handle ->
            handle.createQuery("SELECT COUNT(*) FROM purchases WHERE purchaseID = ?")
                  .bind(0, id)
                  .mapTo(Integer.class)
                  .one()
        );
    }

    public static List<Integer> getProductIdsByPurchaseId(int purchaseId) {
        return connect.withHandle(handle ->
            handle.createQuery("SELECT productID FROM purchases WHERE purchaseID = :purchaseID")
                  .bind("purchaseID", purchaseId)
                  .mapTo(Integer.class)
                  .list()
        );
    }

    public static int getQuantityByPurchaseIdAndProductID(int purchaseId, int productId) {
        return connect.withHandle(handle ->
            handle.createQuery("SELECT quantity FROM purchases WHERE purchaseID = ? AND productID = ?")
                  .bind(0, purchaseId)
                  .bind(1, productId)
                  .mapTo(Integer.class)
                  .one()
        );
    }

    public static List<Purchases> getPurchaseByUserId(int userid) {
        return connect.withHandle(handle ->
            handle.select("SELECT p1.* FROM purchases p1 JOIN (SELECT purchaseID, MIN(productID) AS min_prod FROM purchases WHERE userID = ? GROUP BY purchaseID) p2 ON p1.purchaseID = p2.purchaseID AND p1.productID = p2.min_prod;")
                  .bind(0, userid)
                  .mapToBean(Purchases.class)
                  .list()
        );
    }

    public static List<Purchases> getPurchaseByUserIdAndStatus(int userid, int status) {
        return connect.withHandle(handle ->
            handle.select("SELECT p1.* FROM purchases p1 JOIN (SELECT purchaseID, MIN(productID) AS min_prod FROM purchases WHERE userID = ? AND status = ? GROUP BY purchaseID) p2 ON p1.purchaseID = p2.purchaseID AND p1.productID = p2.min_prod;")
                  .bind(0, userid)
                  .bind(1, status)
                  .mapToBean(Purchases.class)
                  .list()
        );
    }

    public static List<Purchases> getPurchaseByPurchaseID(int purchaseID) {
        return connect.withHandle(handle ->
            handle.select("SELECT * FROM purchases WHERE purchaseID = ?")
                  .bind(0, purchaseID)
                  .mapToBean(Purchases.class)
                  .list()
        );
    }

    public static int newPurchaseID(){
        int countID = 0;
        Purchases purchases;
        do {
            countID++;
            purchases = getPurchaseById(countID);
        } while (purchases != null);
        return countID;
    }

    public static boolean addPurchase(int purchaseId, int prodcutID, int userID, int quantity, int price, String address, String comment, String paymentMethod, int paymentStatus) {
        String orderDate = String.valueOf(LocalDate.now());
        return connect.withHandle(handle -> {
            return handle.execute("INSERT INTO purchases (purchaseID,userID, productID, quantity, price, orderDate, status, comment, address, payment_method, payment_status) value(?,?,?,?,?,?,?,?,?,?,?)",
                purchaseId, userID, prodcutID, quantity, price, orderDate, 0, comment, address, paymentMethod, paymentStatus) > 0;
        });
    }

    public static boolean updatePurchase(int purchaseID, int userID, int productID, String nameColumn, String value){
        return connect.withHandle(handle -> {
            if ("status".equals(nameColumn)) {
                return handle.execute("UPDATE purchases SET status = ? WHERE purchaseID = ?", Integer.parseInt(value), purchaseID) > 0;
            } else {
                return handle.execute("UPDATE purchases SET " + nameColumn + "=? WHERE purchaseID = ? AND userID = ? AND productID = ?", value, purchaseID, userID, productID) > 0;
            }
        });
    }

    public static boolean updateCancelReason(int purchaseID, String reason) {
        return connect.withHandle(handle -> {
            return handle.execute("UPDATE purchases SET cancelReason = ? WHERE purchaseID = ?", reason, purchaseID) > 0;
        });
    }

    public static boolean updatePaymentStatus(int purchaseID, int paymentStatus) {
        return connect.withHandle(handle -> {
            return handle.execute("UPDATE purchases SET payment_status = ? WHERE purchaseID = ?", paymentStatus, purchaseID) > 0;
        });
    }

    public List<Purchases> getAllPurchases() {
        return connect.withHandle(handle -> {
            return handle.select("SELECT * FROM purchases").mapToBean(Purchases.class).list();
        });
    }

    public List<Purchases> getAllPurchases(int userId) {
        String sql = "SELECT pu.*, p.name FROM purchases pu JOIN products p ON pu.productID = p.productID WHERE userID = ?";
        return connect.withHandle(handle -> {
            return handle.select(sql)
                  .bind(0, userId)
                  .mapToBean(Purchases.class)
                  .list();
        });
    }

    public static void main(String[] args) {
        System.out.println(getQuantityByPurchaseIdAndProductID(3, 17));
    }
}
