package model;

import static database.TableCarts.USER_ID;
import static database.TableCarts.PRODUCT_ID;
import static database.TableCarts.QUANTITY;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Cart {
    @ColumnName(USER_ID)
    private int userId;

    @ColumnName(PRODUCT_ID)
    private int productId;

    @ColumnName(QUANTITY)
    private int quantity;

    private Product product;

    private boolean checked = false;

    public Cart() {
        super();
    }

    public Cart(int userId, int productId, int quantity) {
        super();
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }


    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public int totalPrice(){
        return product.getPrice() * quantity;
    }

    @Override
    public String toString() {
        return "Cart [userId=" + userId + ", productId=" + productId + ", quantity=" + quantity
                + ", product=" + (product != null ? product.getName() : "null") + "]";
    }
}