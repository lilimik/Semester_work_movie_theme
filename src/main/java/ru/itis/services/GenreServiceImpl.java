package ru.itis.services;

import ru.itis.models.Genre;
import ru.itis.repositories.GenresRepository;

import java.util.List;
import java.util.Optional;

public class GenreServiceImpl implements GenreService {

    private final GenresRepository genresRepository;

    public GenreServiceImpl(GenresRepository genresRepository) {
        this.genresRepository = genresRepository;
    }

    @Override
    public Genre findById(Integer id) {
        Genre genre = null;
        Optional<Genre> OptionalGenre = genresRepository.findById(id.longValue());
        if (OptionalGenre.isPresent())
            genre = OptionalGenre.get();
        return genre;
    }

    @Override
    public List<Genre> findAll() {
        return genresRepository.findAll();
    }

}
