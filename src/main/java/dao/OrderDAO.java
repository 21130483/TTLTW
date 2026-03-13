package dao;

import database.JDBIConnector;
import model.OrderItem;
import model.Order;
import model.Purchases;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class OrderDAO {
    public static final Jdbi connect = JDBIConnector.getConnect();
    public List<Order> getAllOrderById(int userId) {
        List<Order> invoices = connect.withHandle(handle -> {
            return handle.createQuery("select * from orders where userID = ?")
                    .bind(0, userId)
                    .mapToBean(Order.class)
                    .list();
        });
        return invoices;
    }
    public List<Purchases> getAllOrderItemById(int userId) {
        String sql = "SELECT * FROM purchases WHERE userID = ?";
        return connect.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, userId)
                    .mapToBean(Purchases.class)
                    .list();
        });
    }

    public boolean cancel(int orderId) {
        String sql = "UPDATE purchases SET STATUS = -1 WHERE purchaseID = ?";
        int result = connect.inTransaction(handle ->
                handle.createUpdate(sql)
                        .bind(0, orderId).execute());
        return result > 0;
    }
}