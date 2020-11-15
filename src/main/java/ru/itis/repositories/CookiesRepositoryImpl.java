package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.Cookie;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class CookiesRepositoryImpl implements CookiesRepository {

    private final JdbcTemplate jdbcTemplate;

    public CookiesRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //language=SQL
    private static final String SQL_UPDATE_UUID_INTO_UUID_BY_ID = "update cookie set uuid = ? where id = ?";
    private static final String SQL_INSERT_NEW_UUID_INTO_UUID_BY_ID = "insert into cookie(id, uuid) values (?, ?)";
    private static final String SQL_SELECT_ID_BY_UUID = "select id from cookie where uuid = ?";
    private static final String SQL_FIND_ALL_COOKIE = "select * from cookie";
    private static final String SQL_DELETE_COOKIE_BY_ID ="delete from cookie where id = ?";

    private final RowMapper<Cookie> cookieRowMapper = (row, rowNumber) -> Cookie.builder()
            .id(row.getLong("id"))
            .UUID(row.getString("uuid"))
            .build();

    @Override
    public Long findIdByUuid(String uuid) {
        return jdbcTemplate.queryForObject(SQL_SELECT_ID_BY_UUID, Long.class, uuid);
    }

    @Override
    public void save(Cookie entity) {
        if (updateCookie(entity) == 0) {
            jdbcTemplate.update(SQL_INSERT_NEW_UUID_INTO_UUID_BY_ID, entity.getId(), entity.getUUID());
        }
    }

    @Override
    public int updateCookie(Cookie cookie) {
        int affectedRows = 0;
        try {
            affectedRows = jdbcTemplate.update(SQL_UPDATE_UUID_INTO_UUID_BY_ID, cookie.getUUID(), cookie.getId());
        } catch (Exception e) {
            return affectedRows;
        }
        return affectedRows;
    }

    @Override
    public void update(Cookie entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_COOKIE_BY_ID, id);
    }

    @Override
    public Optional<Cookie> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_SELECT_ID_BY_UUID, Cookie.class, id));
    }

    @Override
    public List<Cookie> findAll() {
            return jdbcTemplate.query(SQL_FIND_ALL_COOKIE, cookieRowMapper);
    }
}
