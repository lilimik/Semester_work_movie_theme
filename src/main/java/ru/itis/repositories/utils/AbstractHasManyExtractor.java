package ru.itis.repositories.utils;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public abstract class AbstractHasManyExtractor<T, V, R> implements ResultSetExtractor<List<R>> {

    public abstract T buildOwnerModel(ResultSet resultSet) throws SQLException;
    public abstract V buildManyModel(ResultSet resultSet) throws SQLException;

    public abstract List<R> buildResult( Map<T, List<V>> map);

    @Override
    public List<R> extractData(ResultSet resultSet) throws SQLException, DataAccessException {
        Map<T, List<V>> map = new LinkedHashMap<>();

        while (resultSet.next()) {
            T t = this.buildOwnerModel(resultSet);
            map.putIfAbsent(t, new LinkedList<>());
            map.get(t).add(this.buildManyModel(resultSet));
        }
        return this.buildResult(map);
    }
}
