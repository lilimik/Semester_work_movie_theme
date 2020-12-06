package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.Genre;
import ru.itis.models.Restriction;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class RestrictionsRepositoryImpl implements RestrictionsRepository {

    private final JdbcTemplate jdbcTemplate;

    public RestrictionsRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_ALL = "select * from restriction";

    RowMapper<Restriction> restrictionRowMapper = (row, rowNumber) -> Restriction.builder()
            .age(row.getShort("age"))
            .build();

    @Override
    public void save(Restriction entity) {

    }

    @Override
    public void update(Restriction entity) {

    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public Optional<Restriction> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public List<Restriction> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, restrictionRowMapper);
    }
}
