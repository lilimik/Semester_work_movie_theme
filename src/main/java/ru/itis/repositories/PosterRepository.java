package ru.itis.repositories;

import ru.itis.models.FileInfo;

import java.io.OutputStream;

public interface PosterRepository extends CrudRepository<FileInfo> {
    int updatePoster(FileInfo fileInfo);
}
