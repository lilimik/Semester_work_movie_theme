package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.FileInfo;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class PostersRepositoryImpl implements PosterRepository {

    private final JdbcTemplate jdbcTemplate;

    public PostersRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_INSERT_POSTER = "insert into poster(film_id, original_name, storage_name, type, size) values (?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE_POSTER_BY_ID = "update poster set original_name = ?, storage_name = ?, type = ?, size = ? where film_id = ?";
    private static final String SQL_FIND_BY_ID = "select * from poster where film_id = ?";


    RowMapper<FileInfo> fileInfoRowMapper = (row, rowNumber) -> FileInfo.builder()
            .fkId(row.getLong("film_id"))
            .originalName(row.getString("original_name"))
            .storageName(row.getString( "storage_name"))
            .type(row.getString("type"))
            .size(row.getLong("size"))
            .build();

    @Override
    public void save(FileInfo entity) {
        if (updatePoster(entity) == 0) {
            jdbcTemplate.update(SQL_INSERT_POSTER, entity.getFkId(), entity.getOriginalName(), entity.getStorageName(), entity.getType(), entity.getSize());
        }
    }

    @Override
    public int updatePoster(FileInfo fileInfo) {
        int affectedRows = 0;
        try {
            affectedRows = jdbcTemplate.update(SQL_UPDATE_POSTER_BY_ID, fileInfo.getOriginalName(), fileInfo.getStorageName(), fileInfo.getType(), fileInfo.getSize(), fileInfo.getFkId());
        } catch (Exception e) {
            return affectedRows;
        }
        return affectedRows;
    }

    @Override
    public void update(FileInfo entity) {
    }

    @Override
    public void delete(Long id) {
    }

    @Override
    public Optional<FileInfo> findById(Long id) {
        return Optional.ofNullable(jdbcTemplate.queryForObject(SQL_FIND_BY_ID, fileInfoRowMapper, id));
    }

    @Override
    public List<FileInfo> findAll() {
        return null;
    }
}
