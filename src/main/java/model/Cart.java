package model;

import java.util.*;

public class Cart {
    private static Map<Product, Integer> cart = new HashMap<>();
    private static List<Integer> productChecked = new ArrayList<>();

    public Cart() {
    }


    public int sizeCart() {
        return cart.size();
    }

    public Map<Product, Integer> getCart() {
        return cart;
    }

    public static List<Integer> getProductChecked() {
        return productChecked;
    }

    public static void setProductChecked(List<Integer> productChecked) {
        Cart.productChecked = productChecked;
    }

    public void setCart(Map<Product, Integer> cart) {
        this.cart = cart;
    }

    public static void addProduct(Product product) {
        if (cart.containsKey(product)) {
            cart.put(product, cart.get(product) + 1);
        } else {
            cart.put(product, 1);
        }
    }

    public static void removeProduct(Product product, boolean clearAll) {
        if (cart.containsKey(product)) {
            if (clearAll || cart.get(product) == 1) {
                cart.remove(product);
                removeProductChecked(product.getProductID());
            } else {
                cart.put(product, cart.get(product) - 1);
            }
        }
    }

    public void addProductChecked(int id) {
        productChecked.add(id);
    }

    public static void removeProductChecked(int id) {
        if (productChecked.contains(id)) {
            System.out.println("co");
            productChecked.remove(productChecked.indexOf(id));

        } else {
            System.out.println("ko");
        }

    }

    public void addAll() {
        for (Product p : cart.keySet()) {
            if (!productChecked.contains(p.getProductID())) {
                productChecked.add(p.getProductID());
            }
        }
    }

    public void removeAll() {
        productChecked.clear();
    }

    public boolean cartEqualChecked() {
        if (cart.size() != 0 && cart.size() == productChecked.size()) {
            return true;
        }
        return false;
    }

    public static int getTotalPrices() {
        int result = 0;
        for (Product product : cart.keySet()) {
            if (productChecked.contains(product.getProductID())) {
                result += product.getPrice() * cart.get(product);
            }

        }
        return result;
    }

    public static String getTotalPricesHaveDots() {
        String result = "";
        String priceString = String.valueOf(getTotalPrices());
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

    public static String getTotalPricesWithDeliveryHaveDots() {
        String result = "";
        String priceString = String.valueOf(getTotalPrices() + 25000);
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

    public static int getTotalSales() {
        int result = 0;
        for (Product product : cart.keySet()) {
            if (productChecked.contains(product.getProductID())) {
                result += product.getSale() * cart.get(product);
            }
        }
        return result;
    }

    public static String getTotalSalesHaveDots() {
        String result = "";
        String priceString = String.valueOf(getTotalSales());
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


    public static int getTotalRealPrices() {
        return getTotalPrices() + getTotalSales();
    }

    public static String getTotalRealPricesHaveDots() {
        String result = "";
        String priceString = String.valueOf(getTotalRealPrices());
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

    public List<Product> listProductBuy() {
        List<Product> result = new ArrayList<>();
        for (Product p : cart.keySet()) {
            if (productChecked.contains(p.getProductID())) {
                result.add(p);
            }
        }
        return result;
    }



    public void deletedProdcutBuyFromCart() {
        Iterator<Product> iterator = cart.keySet().iterator();
        while (iterator.hasNext()) {
            Product p = iterator.next();
            if (productChecked.contains(p.getProductID())) {
                iterator.remove();
            }
        }
        productChecked.clear();
    }

}
