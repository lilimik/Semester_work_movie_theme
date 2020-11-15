package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.FilmCountry;

import javax.sql.DataSource;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class FilmCountriesRepositoryImpl implements FilmCountriesRepository {

    private final JdbcTemplate jdbcTemplate;

    public FilmCountriesRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_ALL = "select * from film_genres";
    private static final String SQL_DELETE_COUNTRY_BY_FILM_ID = "delete from film_genres where film_id = ?";
    private static final String SQL_INSERT_FILM_COUNTRY = "insert into film_countries(film_id, country_id) values (?, ?)";

    RowMapper<FilmCountry> filmCountryRowMapper = (row, rowNumber) -> FilmCountry.builder()
            .filmId(row.getLong("film_id"))
            .countryId(row.getInt("country_id"))
            .build();

    @Override
    public void save(FilmCountry entity) {
        jdbcTemplate.update(SQL_INSERT_FILM_COUNTRY, entity.getFilmId(), entity.getCountryId());
    }

    @Override
    public void update(FilmCountry entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_COUNTRY_BY_FILM_ID, id);
    }

    @Override
    public Optional<FilmCountry> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public List<FilmCountry> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, filmCountryRowMapper);
    }

}
