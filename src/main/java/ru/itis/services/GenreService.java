package ru.itis.services;

import ru.itis.models.Genre;

import java.util.List;

public interface GenreService {
    Genre findById(Integer id);
    List<Genre> findAll();
}
