package dao;

import database.JDBIConnector;
import model.Category;
import model.Product;
import model.User;
import org.jdbi.v3.core.Handle;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

public class CategoryDAO {

    private static Handle handle = JDBIConnector.getConnect().open();

    public CategoryDAO() {
    }

    public static boolean updateCategory(int id, String name) {
        boolean check = handle.execute("UPDATE category SET name =? WHERE categoryID = ?", name, id) > 0;
        return check;
    }

    public static boolean addCategory(int id, String name) {
        boolean check = handle.execute("INSERT INTO category (`categoryID`, `name`) VALUE(?,?)", id, name) > 0;
        return check;
    }
    public static boolean deleteCategory(int id) {
        boolean check = handle.execute("DELETE FROM category WHERE categoryID = ?",id) > 0;
        return check;
    }

    public static Category getCategoryById(int id) {
        Category result = handle.select("SELECT * FROM category WHERE categoryID = ?").bind(0, id).mapToBean(Category.class).findOne().orElse(null);
        return result;
    }

    public static List<Category> getAllCategory() {
        List<Category> categories = handle.select("SELECT * FROM category").mapToBean(Category.class).collect(Collectors.toList());
        ;
        return categories;
    }

    public static int getIdNewCategory() {
        int countID = 0;
        Category category;

        do {
            countID++;
            category = getCategoryById(countID);
        } while (category != null);
        return countID;
    }

    public static void main(String[] args) {
//        List<Category> categories = getAllCategory();
//        for(Category c :  categories){
//            System.out.println(c);
//        }
        System.out.println(getIdNewCategory());
    }
}
