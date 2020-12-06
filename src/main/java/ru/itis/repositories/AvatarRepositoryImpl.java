package ru.itis.repositories;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.itis.models.FileInfo;

import javax.sql.DataSource;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

public class AvatarRepositoryImpl implements AvatarRepository {

    private final JdbcTemplate jdbcTemplate;

    public AvatarRepositoryImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    //Language=SQL
    private static final String SQL_INSERT_AVATAR = "insert into avatar(account_id, original_name, storage_name, type, size) values (?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE_AVATAR_BY_ID = "update avatar set original_name = ?, storage_name = ?, type = ?, size = ? where account_id = ?";
    private static final String SQL_FIND_BY_ID = "select * from avatar where account_id = ?";
    private static final String SQL_INSERT_DEFAULT_AVATAR = "insert into avatar(account_id, original_name, type, size, storage_name) values (?, ?, ?, ?, ?)";

    RowMapper<FileInfo> fileInfoRowMapper = (row, rowNumber) -> FileInfo.builder()
            .fkId(row.getLong("account_id"))
            .originalName(row.getString("original_name"))
            .storageName(row.getString( "storage_name"))
            .type(row.getString("type"))
            .size(row.getLong("size"))
            .build();

    @Override
    public void save(FileInfo entity) {
        if (updateAvatar(entity) == 0) {
            jdbcTemplate.update(SQL_INSERT_AVATAR, entity.getFkId(), entity.getOriginalName(),entity.getStorageName(), entity.getType(), entity.getSize());
        }
    }

    @Override
    public int updateAvatar(FileInfo entity) {
        int affectedRows = 0;
        try {
            affectedRows = jdbcTemplate.update(SQL_UPDATE_AVATAR_BY_ID, entity.getOriginalName(), entity.getStorageName(), entity.getType(), entity.getSize(), entity.getFkId());
        } catch (Exception e) {
            return affectedRows;
        }
        return affectedRows;
    }

    @Override
    public void saveDefaultAvatar(Long accountId) {
        String OriginalName = "anon.png";
        String type = "anon/png";
        Path path = Paths.get("WebContent//avatars//anon.png");
        long size = 0L;
        try {
            size = Files.size(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String StorageName = "WebContent/avatars/anon.png";
        jdbcTemplate.update(SQL_INSERT_DEFAULT_AVATAR, accountId, OriginalName, type, size , StorageName);
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
