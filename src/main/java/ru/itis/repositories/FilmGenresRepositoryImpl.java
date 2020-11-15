package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.FilmGenre;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class FilmGenresRepositoryImpl implements FilmGenresRepository {

    private final JdbcTemplate jdbcTemplate;

    public FilmGenresRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_ALL = "select * from film_genres";
    private static final String SQL_DELETE_GENRES_BY_FILM_ID = "delete from film_genres where film_id = ?";
    private static final String SQL_INSERT_FILM_GENRE = "insert into film_genres(film_id, genre_id) values (?, ?)";

    RowMapper<FilmGenre> filmGenreRowMapper = (row, rowNumber) -> FilmGenre.builder()
            .filmId(row.getLong("film_id"))
            .genreId(row.getInt("genre_id"))
            .build();

    @Override
    public void save(FilmGenre entity) {
        jdbcTemplate.update(SQL_INSERT_FILM_GENRE, entity.getFilmId(), entity.getGenreId());
    }

    @Override
    public void update(FilmGenre entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_GENRES_BY_FILM_ID, id);
    }

    @Override
    public Optional<FilmGenre> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public List<FilmGenre> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, filmGenreRowMapper);
    }
}
