package dao;

import java.util.List;

public interface GenericDAO<T> {
//    <T> List<T> querry(String sql, RowMapper<T> rowMapper, Object... objects);

    int save(String sql, Object... objects);

    boolean update(String sql, Object... objects);

}
