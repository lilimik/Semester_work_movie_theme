package ru.itis.repositories;

import ru.itis.models.FileInfo;

public interface AvatarRepository extends CrudRepository<FileInfo> {
    int updateAvatar(FileInfo fileInfo);
    void saveDefaultAvatar(Long accountId);
}
