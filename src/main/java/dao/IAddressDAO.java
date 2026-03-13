package dao;

import model.Address;

import java.util.List;


public interface IAddressDAO {
    List<Address> findAddressesById(int id);

    List<Address> findAll();

    boolean update(Address Addresses);

    int save(Address address);

    boolean delete(Address Addresses);
}
