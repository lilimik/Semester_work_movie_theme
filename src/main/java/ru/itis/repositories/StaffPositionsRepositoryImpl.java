package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.StaffPosition;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class StaffPositionsRepositoryImpl implements StaffPositionsRepository {

    private final JdbcTemplate jdbcTemplate;

    public StaffPositionsRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_FIND_ALL = "select * from staff_positions";
    private static final String SQL_INSERT_STAFF_POSITION = "insert into staff_positions(description) values (?)";
    private static final String SQL_DELETE_DESCRIPTION_BY_ID = "delete from staff_positions where id = ?";
    private static final String SQL_FIND_BY_ID = "select * from staff_positions";
    private static final String SQL_FIND_ID_BY_NAME

    RowMapper<StaffPosition> staffPositionRowMapper = (row, rowNumber) -> StaffPosition.builder()
            .id(row.getShort("id"))
            .description(row.getString("description"))
            .build();

    @Override
    public void save(StaffPosition entity) {
        jdbcTemplate.update(SQL_INSERT_STAFF_POSITION, entity.getDescription());
    }

    @Override
    public void update(StaffPosition entity) {
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update(SQL_DELETE_DESCRIPTION_BY_ID, id)
    }

    @Override
    public Optional<StaffPosition> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_ID, staffPositionRowMapper, id));
    }

    @Override
    public List<StaffPosition> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, staffPositionRowMapper);
    }
}
