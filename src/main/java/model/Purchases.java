package model;

import dao.ProductDAO;
import dao.PurchasesDAO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

public class Purchases {
    private int purchaseID;
    private int userID;
    private int productID;
    private String name;
    private int quantity;

    private int price;

    //-1 là hủy đơn hàng
    //0 là chờ xác nhận
    //1 là đang giao
    //2 là giao thành công
    int status;
    private Date orderDate;
    private Date receivedDate;
    private int starNumber;
    private String comment;
    private String address;
    private Date dateRated;

    public Purchases() {
    }


    public int getPurchaseID() {
        return purchaseID;
    }

    public void setPurchaseID(int purchaseID) {
        this.purchaseID = purchaseID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

//    public String getStatusString() {
//        if (status == 0) {
//            return "chờ xác nhận";
//        } else if (status == 1) {
//            return "đang giao";
//        } else if (status == 2) {
//            return "thành công";
//
//        }else{
//            return "Hủy đơn hàng";
//        }
//    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Date receivedDate) {
        this.receivedDate = receivedDate;
    }

    public int getStarNumber() {
        return starNumber;
    }

    public void setStarNumber(int starNumber) {
        this.starNumber = starNumber;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateRated() {
        return dateRated;
    }

    public void setDateRated(Date dateRated) {
        this.dateRated = dateRated;
    }

    public Purchases(int userID, int productID, int quantity) {
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;

    }
    public String getDateOrderString (){

        return "Ngày "+orderDate.getDay()+" tháng "+orderDate.getMonth()+" năm "+(orderDate.getYear()+1900);
    }

    public String getDateOrderStringShort(){

        return ""+orderDate.getDay()+"/"+orderDate.getMonth()+"/"+(orderDate.getYear()+1900);
    }

    public String getTotalPriceHaveDots() {
        PurchasesDAO purchasesDAO =  new PurchasesDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Purchases> purchasesList = purchasesDAO.getPurchaseByPurchaseID(purchaseID);
        int total =0;
        for (Purchases purchases : purchasesList){
            Product product = productDAO.getProductById(purchases.getProductID());
            total += product.getPrice()*purchases.getQuantity();
        }
        String result = "";
        String priceString = String.valueOf(total);
        int dots = priceString.length() - 1 / 3;
        int remainder = priceString.length() % 3;
        for (int i = 0; i < priceString.length(); i++) {
            if (i % 3 == remainder && i != 0) {

                result += ".";
            }
            result += priceString.charAt(i);

        }
        result += " Đồng";
        return result;
    }

    public String getTotalPriceHaveDotsHaveDelivery() {
        PurchasesDAO purchasesDAO =  new PurchasesDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Purchases> purchasesList = purchasesDAO.getPurchaseByPurchaseID(purchaseID);
        int total =25000;
        for (Purchases purchases : purchasesList){
            Product product = productDAO.getProductById(purchases.getProductID());
            total += product.getPrice()*purchases.getQuantity();
        }
        String result = "";
        String priceString = String.valueOf(total);
        int dots = priceString.length() - 1 / 3;
        int remainder = priceString.length() % 3;
        for (int i = 0; i < priceString.length(); i++) {
            if (i % 3 == remainder && i != 0) {

                result += ".";
            }
            result += priceString.charAt(i);

        }
        result += " Đồng";
        return result;
    }
    public String getStatusString(){
        switch (status) {
            case 0:
                return "Chờ xác nhận";
            case 1:
                return "Đang giao";
            case 2:
                return "Giao thành công";
            default:
                return "Hủy đơn hàng";
        }

        //-1 là hủy đơn hàng
        //0 là chờ xác nhận
        //1 là đang giao
        //2 là giao thành côn
    }

    @Override
    public String toString() {
        return "Purchases{" +
                "purchaseID=" + purchaseID +
                ", userID=" + userID +
                ", productID=" + productID +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                ", status=" + status +
                ", orderDate=" + orderDate +
                ", receivedDate=" + receivedDate +
                ", starNumber=" + starNumber +
                ", comment='" + comment + '\'' +
                ", address='" + address + '\'' +
                ", dateRated=" + dateRated +
                '}';
    }

    public static void main(String[] args) {
    }
}
