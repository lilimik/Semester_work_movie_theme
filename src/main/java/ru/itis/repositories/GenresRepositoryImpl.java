package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.Genre;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class GenresRepositoryImpl implements GenresRepository {

    private final JdbcTemplate jdbcTemplate;

    public GenresRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_ALL = "select * from genres";
    private static final String SQL_FIND_BY_ID = "select * from genres where id = ?";
    private static final String SQL_DELETE_GENRE_BY_ID = "delete from genres where id = ?";
    private static final String SQL_INSERT_GENRE = "insert into genres(id, name) values (?, ?)";

    RowMapper<Genre> genreRowMapper = (row, rowNumber) -> Genre.builder()
            .id(row.getInt("id"))
            .name(row.getString("name"))
            .build();

    @Override
    public void save(Genre entity) {
        jdbcTemplate.update(SQL_INSERT_GENRE, entity.getId(), entity.getName());
    }

    @Override
    public void update(Genre entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_GENRE_BY_ID, id);
    }

    @Override
    public Optional<Genre> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_ID, genreRowMapper, id));
    }

    @Override
    public List<Genre> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, genreRowMapper);
    }
}
