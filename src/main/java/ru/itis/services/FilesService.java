package ru.itis.services;

import ru.itis.models.FileInfo;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public interface FilesService {
    void saveAvatarToStorage(InputStream file, Long userId, String originalFileName, String storageFileName, String contentType, Long size) throws IOException;
    void savePosterToStorage(InputStream file, Long filmId, String originalFileName, String storageFileName, String contentType, Long size) throws IOException;
    void writeFileToStorage(Long fkId, OutputStream outputStream);
    FileInfo getAvatarInfo(Long fkId);
    FileInfo getPosterInfo(Long fiId);
    void saveDefaultAvatarToStorage(Long accountId);
}
