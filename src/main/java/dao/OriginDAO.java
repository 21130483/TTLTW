package dao;

import database.JDBIConnector;
import model.Category;
import model.Origin;
import org.jdbi.v3.core.Handle;

import java.util.List;
import java.util.stream.Collectors;

public class OriginDAO {
    private static Handle handle = JDBIConnector.getConnect().open();

    public OriginDAO() {
    }

    public static Origin getOriginById(int id){
        Origin result = handle.select("SELECT * FROM origin WHERE originID = ?").bind(0, id).mapToBean(Origin.class).findOne().orElse(null);
        return result;
    }

    public static List<Origin> getAllOrigin(){
        List<Origin> categories = handle.select("SELECT * FROM origin").mapToBean(Origin.class).collect(Collectors.toList());;
        return categories;
    }

    public static void main(String[] args) {
//        List<Origin> categories = getAllCategory();
//        for(Origin c :  categories){
//            System.out.println(c);
//        }
//        System.out.println(getOriginById(1));
    }
}
