package dao;

import database.JDBIConnector;
import model.Address;
import model.User;
import org.jdbi.v3.core.Handle;

import java.util.List;
import java.util.stream.Collectors;

public class AddressDAO {
    private static Handle handle = JDBIConnector.getConnect().open();

    public AddressDAO() {
    }

    public static Address getAddressById(int id) {
        Address result = handle.select("SELECT * FROM address WHERE addressID = ?").bind(0, id).mapToBean(Address.class).findOne().orElse(null);
        return result;
    }



    public static boolean addAddress(int userId, String city, String district, String ward, String detail) {
        boolean check = handle.execute("INSERT INTO address (userID, city, district, ward, detail) value(?,?,?,?,?)", userId, city, district, ward, detail) > 0;
        return check;
    }

    public static boolean editAddress(int addressId, String nameColumn, String changed) {
        boolean check = handle.execute("UPDATE address SET " + nameColumn + "=? WHERE userID =?", changed, addressId) > 0;
        return check;
    }
    public static boolean removeAddress(int addressId){
        boolean check = handle.execute("DELETE FROM address WHERE addressID = ?",addressId) > 0;
        return check;
    }

    public static void main(String[] args) {
//        System.out.println(addAddress(1,"cc","dd","oo","sdasdasdas"));
//        System.out.println(editAddress(1,"city","33"));
//        System.out.println(removeAddress(2));
    }

}
