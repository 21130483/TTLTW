package dao;

import model.User;

import java.util.List;

public interface IUserDAO extends GenericDAO<User> {
    User findUserByEmail(String email);

    User findUserById(int id);

    List<User> findAll();

    boolean update(User user);

    int save(User user);

    boolean delete(User user);

}
