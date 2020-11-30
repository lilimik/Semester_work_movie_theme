package ru.itis.services;

import ru.itis.models.FileInfo;

import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;

public interface FilesService {
    void saveAvatarToStorage(InputStream file, String originalFileName, String storageFileName, String contentType, Long size) throws IOException;
    void savePosterToStorage(InputStream file, String originalFileName, String storageFileName, String contentType, Long size) throws IOException;
    Optional<FileInfo> getAvatarInfo(Long fkId);
    FileInfo getPosterInfo(Long fiId);
    void saveDefaultAvatarToStorage(Long accountId);
}
