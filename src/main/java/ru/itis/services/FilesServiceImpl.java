package ru.itis.services;

import ru.itis.models.FileInfo;
import ru.itis.repositories.AvatarRepository;
import ru.itis.repositories.PosterRepository;

import java.io.IOException;
import java.io.InputStream;
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
    public void saveAvatarToStorage(InputStream file, String originalFileName, String storageFileName, String contentType, Long size) {
        FileInfo fileInfo = FileInfo.builder()
                .fkId(Long.parseLong(storageFileName))
                .originalName(originalFileName)
                .storageName(storageFileName)
                .size(size)
                .type(contentType)
                .build();

        try {
        Files.copy(file, Paths.get("C:\\Users\\kazak\\IdeaProjects\\Semester\\src\\main\\webapp\\WebContent\\avatars\\" + fileInfo.getFkId() + "." + fileInfo.getType().split("/")[1]));
        avatarRepository.save(fileInfo);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public void savePosterToStorage(InputStream file, String originalFileName, String storageFileName, String contentType, Long size) {
        FileInfo fileInfo = FileInfo.builder()
                .fkId(Long.parseLong(storageFileName))
                .originalName(originalFileName)
                .size(size)
                .type(contentType)
                .build();

        try {
            Files.copy(file, Paths.get("C:\\Users\\kazak\\IdeaProjects\\Semester\\src\\main\\webapp\\WebContent\\posters\\" + fileInfo.getFkId() + "." + fileInfo.getType().split("/")[1]));
            avatarRepository.save(fileInfo);
        } catch (IOException e) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public Optional<FileInfo> getAvatarInfo(Long fkId) {
        return avatarRepository.findById(fkId);
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
