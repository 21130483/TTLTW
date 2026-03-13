package database;

import com.mysql.cj.jdbc.MysqlDataSource;
import model.User;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

public class JDBIConnector {

    private  static Jdbi jdbi;

    private  static  void connect(){
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL("jdbc:mysql://"+DBProperties.host+":"+DBProperties.port+"/"+DBProperties.db);
        dataSource.setUser(DBProperties.username);
        dataSource.setPassword(DBProperties.password);



        try {
            dataSource.setAutoReconnect(true);
            dataSource.setUseCompression(true);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        jdbi=Jdbi.create(dataSource);

    }

    private JDBIConnector(){

    }

    public static Jdbi getConnect(){
        if(jdbi==null) connect();
        return jdbi;
    }



    public static void main(String[] args) {
        System.out.println("chay ra");
        List<User> users = null;
        getConnect();
        System.out.println(jdbi);


        try {
            users = jdbi.withHandle(handle ->
                    handle.createQuery("select * from users").mapToBean(User.class).collect(Collectors.toList())
            );
        } catch (Exception e){
            e.printStackTrace();
        }

        System.out.println(users);
    }
}
