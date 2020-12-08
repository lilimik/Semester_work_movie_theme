package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.Country;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class CountriesRepositoryImpl implements CountriesRepository {

    private final JdbcTemplate jdbcTemplate;

    public CountriesRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_INSERT_COUNTRY = "insert into countries(id, name) values (?, ?)";
    private static final String SQL_FIND_ALL = "select * from countries";
    private static final String SQL_DELETE_COUNTRY_BY_ID = "delete from countries where id = ?";
    private static final String SQL_FIND_COUNTRY_BY_ID = "select * from countries where id = ?";
    private static final String SQL_FIND_ID_BY_COUNTRY = "select id from countries where name = ?";

    RowMapper<Country> countryRowMapper = (row, rowNumber) -> Country.builder()
            .id(row.getInt("id"))
            .name(row.getString("name"))
            .build();

    @Override
    public void save(Country entity) {
        jdbcTemplate.update(SQL_INSERT_COUNTRY, entity.getId(), entity.getName());
    }

    @Override
    public void update(Country entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_COUNTRY_BY_ID, id);
    }

    @Override
    public Optional<Country> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_COUNTRY_BY_ID, countryRowMapper, id));
    }

    @Override
    public List<Country> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, countryRowMapper);
    }

    @Override
    public Integer findIdByCountryName(String countryName) {
        return jdbcTemplate.queryForObject(SQL_FIND_ID_BY_COUNTRY, Integer.class, countryName);
    }
}
