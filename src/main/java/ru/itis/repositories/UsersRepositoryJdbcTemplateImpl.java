package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.User;

import javax.sql.DataSource;
import java.sql.*;
import java.util.List;
import java.util.Optional;

public class UsersRepositoryJdbcTemplateImpl implements UsersRepository {

    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

    public UsersRepositoryJdbcTemplateImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.dataSource = dataSource;
    }

    //language=SQL
    private static final String SQL_FIND_BY_EMAIL = "select * from account where email = ?";
    private static final String SQL_FIND_ALL = "select * from account";
    private static final String SQL_INSERT_USER = "insert into account(email, first_name, last_name, hash_password) values (?, ?, ?, ?)";
    private static final String SQL_INSERT_USER_AND_RETURN = "insert into account(email, first_name, last_name, hash_password) values (?, ?, ?, ?) returning id";
    private static final String SQL_FIND_BY_ID = "select * from account where id = ?";
    private static final String SQL_DELETE_USER_BY_ID = "delete from account where id = ?";

    private final RowMapper<User> userRowMapper = (row, rowNumber) -> User.builder()
            .id(row.getLong("id"))
            .firstName(row.getString("first_name"))
            .lastName(row.getString("last_name"))
            .email(row.getString("email"))
            .hashPassword(row.getString("hash_password"))
            .build();

    @Override
    public Optional<User> findByEmail(String email) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_EMAIL, userRowMapper, email));
    }

    @Override
    public void save(User entity) {
        jdbcTemplate.update(SQL_INSERT_USER, entity.getEmail(),
                entity.getFirstName(),
                entity.getLastName(),
                entity.getHashPassword());
    }

    @Override
    public Long saveAndReturnId(User entity) {
        try (Connection con = this.dataSource.getConnection()){
            PreparedStatement ps = con.prepareStatement(SQL_INSERT_USER_AND_RETURN, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, entity.getEmail());
            ps.setString(2, entity.getFirstName());
            ps.setString(3, entity.getLastName());
            ps.setString(4, entity.getHashPassword());
            int affectedRows = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            long id = 0L;
            while (rs.next()) {
                id = rs.getLong("id");
            }
            return id;
        } catch (SQLException e) {
            throw new IllegalArgumentException(e);
        }
    }

    @Override
    public void update(User entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_USER_BY_ID, id);
    }

    @Override
    public Optional<User> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_ID, userRowMapper, id));
    }

    @Override
    public List<User> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, userRowMapper);
    }
}
