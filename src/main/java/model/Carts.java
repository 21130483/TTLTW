package model;

import java.util.*;

public class Carts {
    private static List<Cart> carts = new ArrayList<>();

    public Carts() {
    }

    public static List<Cart> getCarts() {
        return carts;
    }

    public static void setCarts(List<Cart> carts) {
        Carts.carts = carts;
    }

    public int sizeCart() {
        return carts.size();
    }


    public static int getTotalPrices() {
        int result = 0;
        for (Cart cart : carts) {
           if (cart.isChecked()) return result+=cart.totalPrice();
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



}
