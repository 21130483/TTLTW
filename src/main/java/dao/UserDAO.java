package dao;
//
//import database.JDBIConnector;
//import model.User;
//import org.jdbi.v3.core.Handle;
//
//import java.util.ArrayList;
//import java.util.List;
//
//public class UserDAO {
//    private static Handle handle = JDBIConnector.getConnect().open();
//
//    public UserDAO() {
//    }
//
//    public static User getUserById(int id) {
//        User result = handle.select("SELECT * FROM users WHERE userID = ?").bind(0, id).mapToBean(User.class).findOne().orElse(null);
//        return result;
//    }
//
//    public boolean updateUser(int userID, String nameColumn, String value) {
//        boolean check = handle.execute("UPDATE users SET " + nameColumn + "=? WHERE userID =?", value, userID) > 0;
//        return check;
//    }
//
//    public static List<User> getAllUsers() {
//        List<User> users = handle.select("SELECT * FROM users").mapToBean(User.class).collect(Collectors.toList());
//        ;
//        return users;
//    }
//
//    public static User checkLogin(String email, String pass) {
//
////        List<User> users = null;
//        List<User> users = handle.select("SELECT * FROM users").mapToBean(User.class).collect(Collectors.toList());
//        for (User user : users) {
//            if (user.getEmail().equals(email)) {
//                if (user.getPassword().equals(pass)) {
//                    return user;
//                } else {
//                    break;
//                }
//            }
//        }
//        return user;
//    }
//
//    public static void main(String[] args) {
//        UserDAO userDAO = new UserDAO();
//        System.out.println(userDAO.findUserByEmail("admin@gmail.com"));
//    }
//
//    @Override
//    public User findUserById(int id) {
//        String sql = "SELECT * FROM users join status on status.statusId = users.statusId where users.userId = ?";
//        User user = querry(sql, new UserMapper(), id).get(0);
//        List<Address> address = addressDAO.findAddressesById(id);
//        user.setAddresses(address);
//        return user;
//    }
//
//    @Override
//    public int save(User user) {
//        String sql = "INSERT INTO users(passwordHash,fullName,email,phone,statusId) VALUES (?,?,?,?,?)";
//        return save(sql, user.getPasswordHash(), user.getFullName(), user.getEmail(), user.getPhone(),
//                user.getStatus().getId());
//    }
//
//    @Override
//    public List<User> findAll() {
//        String sql = "SELECT * FROM users join status on status.statusId = users.statusId";
//        return querry(sql, new UserMapper());
//    }
//
//    @Override
//    public boolean update(User user) {
//        String sql = "UPDATE users SET email = ?, passwordHash = ?,fullName=?,statusId=? WHERE userId = ?";
//        return update(sql, user.getEmail(), user.getPasswordHash(), user.getFullName(), user.getStatus().getId(),
//                user.getId());
//    }
//
//    @Override
//    public boolean delete(User user) {
//        String sql = "DELETE FROM users WHERE userId = ?";
//        return update(sql, user.getId());
//    }
//
//    @Override
//    public <T> List<T> querry(String sql, RowMapper<T> rowMapper, Object... objects) {
//        return null;
//    }
//
//    @Override
//    public int save(String sql, Object... objects) {
//        return 0;
//    }
//
//    @Override
//    public boolean update(String sql, Object... objects) {
//        return false;
//    }
//
//    public static void main(String[] args) {
////        User user = checkLogin("phuoc@gmail.com","123");
//        User user = getUserById(1);
//        System.out.println(user);
////        List<User> users = getAllUsers();
////        for (User user : users) {
////            System.out.println(user);
//    }
//
//
//}

import database.JDBIConnector;
import model.User;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.Handle;
import Services.Connect;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;


public class UserDAO {

    public static final Jdbi connect = JDBIConnector.getConnect();


    private static Handle handle = JDBIConnector.getConnect().open();


    public UserDAO() {
    }

    public static User getUserById(int id) {
        User result = handle.select("SELECT * FROM users WHERE userID = ?").bind(0, id).mapToBean(User.class).findOne().orElse(null);
        return result;
    }

    public static List<User> getAllUsers() {
        List<User> users = handle.select("SELECT * FROM users").mapToBean(User.class).collect(Collectors.toList());;
        return users;
    }

    public static User checkLogin(String email, String pass) {

//        List<User> users = null;
        List<User> users = handle.select("SELECT * FROM users").mapToBean(User.class).collect(Collectors.toList());
        for (User user : users) {
            if (user.getEmail().equals(email)) {
                if (user.getPassword().equals(pass)) {
                    return user;
                }
            }
        }
        return null;
    }


    public boolean checkEmailExist(String email) {
        Connection connection = null;
        boolean checkEmail = false;
        try {
            connection = Connect.getConnection();
            String checkEmailQuery = "select email from user where email = ?";
            PreparedStatement preparedStatementCheckEmail = connection.prepareStatement(checkEmailQuery);
            preparedStatementCheckEmail.setString(1, email);
            ResultSet resEmail = preparedStatementCheckEmail.executeQuery();
            if (resEmail.next()) {
                checkEmail = true;
                return checkEmail;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return checkEmail;
    }

    public boolean resgisterWithEmail(String email, String name, String pass) {
        Connection connection = null;
        if (checkEmailExist(email)) {
            return false;
        } else {
            try {
                connection = Connect.getConnection();
                String sql = "SELECT MAX(userID) AS max_user_id FROM user";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery();
                java.util.Date utilDate = new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                if (resultSet.next()) {
                    int maxUserId = resultSet.getInt("max_user_id");
                    String insert = "Insert into User values (?,?,?,?,?,?,?)";
                    PreparedStatement preparedStatement1 = connection.prepareStatement(insert);
                    preparedStatement1.setInt(1, maxUserId + 1);
                    preparedStatement1.setString(2, email);
                    preparedStatement1.setString(3, name);
                    preparedStatement1.setString(4, pass);

                    preparedStatement1.setString(5, "true");
                    preparedStatement1.setString(6, "false");
                    preparedStatement1.setDate(7, sqlDate);
                    int resultSet1 = preparedStatement1.executeUpdate();

                    if (resultSet1 >= 0) {
                        return true;
                    } else {
                        return false;
                    }

                } else {
                    return false;
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } finally {
                Connect.closeConnection(connection);
            }
        }

    }

    public User getUserByEmailAndPass(String email, String pass) {
        Connection connection = null;
        try {
            connection = Connect.getConnection();
            String sql = "select userID, email, name, password, access, role, dob from user where email = ? AND password = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, pass);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setUserID(resultSet.getInt(1));
                user.setEmail(resultSet.getString(2));
                user.setFullName(resultSet.getString(3));
//                user.setPasword(resultSet.getString(4));
                user.setAccess(Boolean.parseBoolean(resultSet.getString(5)));
                user.setRole(Boolean.parseBoolean(resultSet.getString(6)));
                user.setDob(resultSet.getDate(7));

//                System.out.println(user);
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return null;
    }

//    public ArrayList<User> getAllUsers() {
//        Connection connection = null;
//        ArrayList<User> listUser = new ArrayList<>();
//        ArrayList<User> res = new ArrayList<User>();
//        try {
//            connection = Connect.getConnection();
//            String getAllUser = "select userID, email,name, password, access, role, dob from user";
//            PreparedStatement preparedStatementGetUser = connection.prepareStatement(getAllUser);
//            ResultSet resultSetGetUser = preparedStatementGetUser.executeQuery();
//            while (resultSetGetUser.next()) {
//                User user = new User();
//                user.setUserID(resultSetGetUser.getInt("userID"));
//                user.setEmail(resultSetGetUser.getString("email"));
//                user.setFullName(resultSetGetUser.getString("name"));
//                user.setPassword(resultSetGetUser.getString("password"));
//
//                user.setAccess(resultSetGetUser.getString("access"));
//                user.setRole(resultSetGetUser.getString("role"));
//                user.setDob(resultSetGetUser.getDate("dob"));
//                listUser.add(user);
//            }
//            for (User user : listUser) {
//                if (!"admin".equals(user.getRole())) {
//                    res.add(user);
//                }
//            }
//
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        } finally {
//            Connect.closeConnection(connection);
//        }
//        return res;
//    }

    public String getUsernameById(int userID) {
        Connection connection = null;
        String username = "";
        try {
            connection = Connect.getConnection();
            String sql = "select name from user where userID= ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                username = resultSet.getString("name");
                return username;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return username;
    }

    public boolean verifyEmail(String email) {
        Connection connection = null;
        try {
            connection = Connect.getConnection();
            String sql = "update user SET isVerifyEmail = ? where email = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, "true");
            preparedStatement.setString(2, email);
            int check = preparedStatement.executeUpdate();
            if (check > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
    }

    public boolean updatePasswordByEmail(String email, String pass) {
        Connection connection = null;
        try {
            connection = Connect.getConnection();
            String sql = "UPDATE user set password = ? where email = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, pass);
            preparedStatement.setString(2, email);
            int check = preparedStatement.executeUpdate();
            if (check > 0) {
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
    }
//    public User getUserById(int id){
//        Connection connect = null;
//        User user = new User();
//        try {
//            connect = Connect.getConnection();
//            String sql = "SELECT userID,email,name,access,role,dob from user WHERE userID =?";
//            PreparedStatement preparedStatement = connect.prepareStatement(sql);
//            preparedStatement.setInt(1, id);
//            ResultSet resultSet = preparedStatement.executeQuery();
//            if (resultSet.next()) {
//                user.setUserID(resultSet.getInt("userID"));
//                user.setEmail(resultSet.getString("email"));
//                user.setFullName(resultSet.getString("name"));
//
//                user.setAccess(resultSet.getString("access"));
//                user.setRole(resultSet.getString("role"));
//                user.setDob(resultSet.getDate("dob"));
//                return  user;
//            }
//        }catch (SQLException e){
//            throw new RuntimeException(e);
//        }
//        finally {
//            Connect.closeConnection(connect);
//        }
//        return  user;


    public ArrayList<User> getUserByName(String name) {
        Connection connection = null;
        ArrayList<User> listUser = new ArrayList<>();
        ArrayList<User> res = new ArrayList<User>();
        try {
            connection = Connect.getConnection();
            String getAllUser = "select userID, email,name, access, role, dob from user where  name like ?";
            PreparedStatement preparedStatementGetUser = connection.prepareStatement(getAllUser);
            preparedStatementGetUser.setString(1, "%" + name + "%");
            ResultSet resultSetGetUser = preparedStatementGetUser.executeQuery();
            while (resultSetGetUser.next()) {
                User user = new User();
                user.setUserID(resultSetGetUser.getInt("userID"));
                user.setEmail(resultSetGetUser.getString("email"));
                user.setFullName(resultSetGetUser.getString("name"));

                user.setAccess(Boolean.parseBoolean(resultSetGetUser.getString("access")));
                user.setRole(Boolean.parseBoolean(resultSetGetUser.getString("role")));
                user.setDob(resultSetGetUser.getDate("dob"));
                listUser.add(user);
            }
            for (User user : listUser) {
                if (!"admin".equals(user.getRole())) {
                    res.add(user);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return res;
    }
//
    public boolean updateUser(int userID, String nameColumn, String value) {
        boolean check = connect.inTransaction(handle -> {
            return handle.createUpdate("UPDATE users SET " + nameColumn + "=? WHERE userID =?").bind(0, value)
                    .bind(1, userID).execute() > 0;
        });
        return check;
    }

    public boolean updateUser1(User user) {
        boolean check = connect.inTransaction(handle -> {
            return handle.createUpdate("UPDATE users SET fullName = ? , gender = ?, phoneNumbers = ?, dob = ?, email = ? WHERE userID = ?")
                    .bind(0, user.getFullName())
                    .bind(1, user.getGender())
                    .bind(2, user.getPhoneNumbers())
                    .bind(3, user.getDob())
                    .bind(4, user.getEmail())
                    .bind(5, user.getUserID())
                    .execute() > 0;
        });
        return check;
    }
    public int getCount() {
        Connection connection = null;
        try {
            connection = Connect.getConnection();
            String sql = "select count(userID) as total from user ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet res = preparedStatement.executeQuery();
            if (res.next()) {
                return res.getInt("total");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return 0;
    }

    public int getCountThisMonth() {
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH) + 1;

        Connection connection = null;
        try {
            connection = Connect.getConnection();
            String sql = "select count(userID) as total from user where year(dob) = ? and month(dob) = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, currentYear);
            preparedStatement.setInt(2, currentMonth);
            ResultSet res = preparedStatement.executeQuery();
            if (res.next()) {
                return res.getInt("total");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Connect.closeConnection(connection);
        }
        return 0;
    }

//    public boolean updateUser(int userID, String nameColumn, String value) {
//        boolean check = handle.execute("UPDATE users SET " + nameColumn + "=? WHERE userID =?", value, userID) > 0;
//        return check;
//    }


    public static void main(String[] args) {
//        User user = checkLogin("phuoc@gmail.com","123");
//        User user = getUserById(1);
//        System.out.println(user);
//        List<User> users = getAllUsers();
//        for (User user : users) {
//            System.out.println(user);
//        }
//        System.out.println(updateUser(1,"role", String.valueOf(true)));

    }


//    public User getUserById(int id) {
//        Optional<User> result = connect.withHandle(handle -> {
//            return handle.createQuery("SELECT * FROM users WHERE userID = ?")
//                    .bind(0, id).mapToBean(User.class).list().stream().findFirst();
//        });
//        return result.orElse(null);
//    }

    public boolean updatePassword(User user, String newpass1) {
        boolean check = connect.inTransaction(handle -> {
            return handle.createUpdate("UPDATE users SET password = ? WHERE userID = ?")
                    .bind(0, newpass1)
                    .bind(1, user.getUserID()).execute() > 0;
        });
        return check;
    }
}




