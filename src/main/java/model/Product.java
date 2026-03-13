package model;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class Product {
    private int productID;

    private int categoryID;
    private int originID;
    private int price;
    private int sale;
    private int quantity;
    private int orderedNumbers;
    private Date dateAdded;
    private String name;
    private String trademark;
    private String content;

    public Product() {
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getTrademark() {
        return trademark;
    }

    public void setTrademark(String trademark) {
        this.trademark = trademark;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getOriginID() {
        return originID;
    }

    public void setOriginID(int originID) {
        this.originID = originID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPrice() {
        return price;
    }

    public String getPriceHaveDots() {
        String result = "";
        String priceString = String.valueOf(price);
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

    public String getSaleHaveDots() {
        String result = "";
        String priceString = String.valueOf(sale);
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

    public String getRealPriceHaveDots() {
        String result = "";
        int realPrice = price + sale;
        String priceString = String.valueOf(realPrice);
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

    public void setPrice(int price) {
        this.price = price;
    }

    public int getSale() {
        return sale;
    }

    public void setSale(int sale) {
        this.sale = sale;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrderedNumbers() {
        return orderedNumbers;
    }

    public void setOrderedNumbers(int orderedNumbers) {
        this.orderedNumbers = orderedNumbers;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

    public int numberImg(String path) {
        File fileImg = new File(path);
        if (fileImg.exists()) {

            return fileImg.list().length;
        } else {
            return 0;
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return productID == product.productID;
    }

    @Override
    public int hashCode() {
        return Objects.hash(productID);
    }

    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", categoryID=" + categoryID +
                ", originID=" + originID +
                ", price=" + price +
                ", sale=" + sale +
                ", quantity=" + quantity +
                ", orderedNumbers=" + orderedNumbers +
                ", dateAdded=" + dateAdded +
                ", name='" + name + '\'' +
                ", trademark='" + trademark + '\'' +
                ", content='" + content + '\'' +
                '}';
    }




    public int getNumberImg(String path) {
        File fileImg = new File(path + "/image/product/" + productID);
        if (fileImg.exists()) {
            for (String string : fileImg.list()) {
                System.out.println(string);
            }
            return fileImg.list().length;
        } else {
            return 0;
        }
    }

    public List<String> getPathImage(String path) {
        List<String> result = new ArrayList<>();
        File folderImg = new File(path + "/image/product/" + productID);
        if (folderImg.exists()) {
            for (File file : folderImg.listFiles()){
                result.add("../image/product/"+productID+"/"+file.getName());
            }
        }
        for (String string : result){
            System.out.println("list :"+string);

        }
        return result;
    }

    public String getPathFirstImage(String path) {
        File folderImg = new File(path + "/image/product/" + productID);
        String result = "../image/product/"+productID+"/";

        if (folderImg.exists()) {
            File[] files = folderImg.listFiles();
            result += files[0].getName();
        }
        return result;
    }
    public String getPathFirstImage1() {
        File folderImg = new File( "D:/project_web/target/Lab/image/product/" + productID);
        String result = "../image/product/"+productID+"/";

        if (folderImg.exists()) {
            File[] files = folderImg.listFiles();
            result += files[0].getName();
        }
        return result;
    }

//    public static void main(String[] args) {
//
//    }

}
