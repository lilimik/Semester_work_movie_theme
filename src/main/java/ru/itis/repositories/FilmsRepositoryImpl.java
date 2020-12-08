package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.dto.FilmRO;
import ru.itis.models.Film;
import ru.itis.repositories.utils.FilmsExtractor;

import javax.sql.DataSource;
import java.sql.*;
import java.util.*;

public class FilmsRepositoryImpl implements FilmsRepository {

    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;
    private static Long pkFilmId = 101L;

    public FilmsRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.dataSource = dataSource;
    }

    //Language=SQL
    private static final String SQL_FIND_FILMS_BY_YEAR = "select * from films where year = ?";
    private static final String SQL_INSERT_FILM = "insert into films(title, box_office, budget, description, year, restriction_age) values (?, ?, ?, ?, ?, ?)";
    private static final String SQL_DELETE_FILM_BY_ID = "delete from films where id = ?";
    private static final String SQL_FIND_ALL = "select * from films";
    private static final String SQL_FIND_BY_ID = "select * from films where id = ?";
    private static final String SQL_FIND_FILM_ID_BY_TITLE = "select * from films where title = ?";
    private static final String SQL_FIND_FILMS_BY = "select f.*,g.name genre_name, c.name country_name from films f join film_genres fg on f.id = fg.film_id join genres g on fg.genre_id = g.id join film_countries fc on f.id = fc.film_id join countries c on fc.country_id = c.id where ";
    private static final String SQL_BY_GENRES = "g.name = ?";
    private static final String SQL_BY_COUNTRIES = "c.name = ?";
    private static final String SQL_FIND_GENRES_COUNTRIES_BY_FILM = "select f.*,g.name genre_name, c.name country_name from films f join film_genres fg on f.id = fg.film_id join genres g on fg.genre_id = g.id join film_countries fc on f.id = fc.film_id join countries c on fc.country_id = c.id where f.title = ?";
    private static final String SQL_INSERT_FILM_AND_RETURN = "insert into films(id, title, box_office, budget, description, year, restriction_age) values (?, ?, ?, ?, ?, ?, ?)";

    RowMapper<Film> filmRowMapper = (row, rowNumber) -> Film.builder()
            .id(row.getLong("id"))
            .title(row.getString("title"))
            .boxOffice(row.getString("box_office"))
            .budget(row.getString("budget"))
            .description(row.getString("description"))
            .year(row.getShort("year"))
            .restriction(row.getByte("restriction_age"))
            .build();


    @Override
    public void save(Film entity) {
    }

    @Override
    public void update(Film entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_FILM_BY_ID, id);
    }

    @Override
    public Optional<Film> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_ID, filmRowMapper, id));
    }

    @Override
    public List<Film> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, filmRowMapper);
    }

    @Override
    public Optional<Film> findFilmByTitle(String title) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_FILM_ID_BY_TITLE, filmRowMapper, title));
    }

    @Override
    public List<Film> findFilmsByYear(Short year) {
        return jdbcTemplate.query(SQL_FIND_FILMS_BY_YEAR, filmRowMapper, year);
    }

    @Override
    public List<FilmRO> findFilmsByGenreName(String genreName) {
        return jdbcTemplate.query(SQL_FIND_FILMS_BY + SQL_BY_GENRES, new FilmsExtractor(), genreName);
    }

    @Override
    public List<FilmRO> findFilmsByCountryName(String countryName) {
        return jdbcTemplate.query(SQL_FIND_FILMS_BY + SQL_BY_COUNTRIES, new FilmsExtractor(), countryName);
    }

    @Override
    public List<FilmRO> findGenresByFilmTitle(String filmTitle) {
        return jdbcTemplate.query(SQL_FIND_GENRES_COUNTRIES_BY_FILM, new FilmsExtractor(), filmTitle);
    }

    @Override
    public List<FilmRO> findCountriesByFilmTitle(String filmTitle) {
        return jdbcTemplate.query(SQL_FIND_GENRES_COUNTRIES_BY_FILM, new FilmsExtractor(),filmTitle);
    }

    @Override
    public Long saveAndReturnId(Film entity) {
        try (Connection con = this.dataSource.getConnection()){
            PreparedStatement ps = con.prepareStatement(SQL_INSERT_FILM_AND_RETURN);
            ps.setLong(1, pkFilmId);
            ps.setString(2, entity.getTitle());
            ps.setLong(3, Long.parseLong(entity.getBoxOffice()));
            ps.setLong(4, Long.parseLong(entity.getBudget()));
            ps.setString(5, entity.getDescription());
            ps.setShort(6, entity.getYear());
            ps.setByte(7, entity.getRestriction());
            ps.executeUpdate();
            long id = pkFilmId;
            pkFilmId++;
            return id;
        } catch (SQLException e) {
            throw new IllegalArgumentException(e);
        }
    }
}
