package ru.itis.services;

import ru.itis.models.FileInfo;
import ru.itis.repositories.AvatarRepository;
import ru.itis.repositories.PosterRepository;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Optional;

public class FilesServiceImpl implements FilesService {

    private final AvatarRepository avatarRepository;
    private final PosterRepository posterRepository;

    public FilesServiceImpl(AvatarRepository avatarRepository, PosterRepository posterRepository) {
        this.avatarRepository = avatarRepository;
        this.posterRepository = posterRepository;
    }

    @Override
    public void saveAvatarToStorage(InputStream file, Long userId, String originalFileName, String storageFileName, String contentType, Long size) {
        FileInfo fileInfo = FileInfo.builder()
                .fkId(userId)
                .originalName(originalFileName)
                .storageName(storageFileName)
                .type(contentType)
                .size(size)
                .build();

        try {
        Files.copy(file, Paths.get("C:\\Users\\kazak\\IdeaProjects\\Semester\\src\\main\\webapp\\WebContent\\avatars\\" + fileInfo.getFkId() + "." + fileInfo.getType().split("/")[1]));
        avatarRepository.save(fileInfo);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public void savePosterToStorage(InputStream file, Long filmId, String originalFileName, String storageFileName, String contentType, Long size) {
        FileInfo fileInfo = FileInfo.builder()
                .fkId(Long.parseLong(storageFileName))
                .originalName(originalFileName)
                .size(size)
                .type(contentType)
                .build();

        try {
            Files.copy(file, Paths.get("C:\\Users\\kazak\\IdeaProjects\\Semester\\src\\main\\webapp\\WebContent\\posters\\" + fileInfo.getFkId() + "." + fileInfo.getType().split("/")[1]));
            posterRepository.save(fileInfo);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public void writeFileToStorage(Long fkId, OutputStream outputStream) {
        FileInfo fileInfo = getAvatarInfo(fkId);
        File file = new File("C:/Users/kazak/IdeaProjects/Semester/src/main/webapp/" +
                fileInfo.getStorageName());
        System.out.println(file.toPath());
        try {
            Files.copy(file.toPath(), outputStream);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public FileInfo getAvatarInfo(Long fkId) {
        FileInfo fileInfo = null;
        Optional<FileInfo> optionalFileInfo = avatarRepository.findById(fkId);
        if (optionalFileInfo.isPresent()) {
            fileInfo = optionalFileInfo.get();
        }
        return fileInfo;
    }

    @Override
    public FileInfo getPosterInfo(Long fkId) {
        FileInfo fileInfo = null;
        Optional<FileInfo> optionalFileInfo = posterRepository.findById(fkId);
        if (optionalFileInfo.isPresent()) {
            fileInfo = optionalFileInfo.get();
        }
        return fileInfo;
    }

    @Override
    public void saveDefaultAvatarToStorage(Long accountId) {
        avatarRepository.saveDefaultAvatar(accountId);
    }
}
