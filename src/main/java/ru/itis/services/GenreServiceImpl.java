package ru.itis.services;

import ru.itis.models.FilmGenre;
import ru.itis.models.Genre;
import ru.itis.repositories.FilmGenresRepository;
import ru.itis.repositories.GenresRepository;

import java.util.List;
import java.util.Optional;

public class GenreServiceImpl implements GenreService {

    private final GenresRepository genresRepository;
    private final FilmGenresRepository filmGenresRepository;

    public GenreServiceImpl(GenresRepository genresRepository, FilmGenresRepository filmGenresRepository) {
        this.genresRepository = genresRepository;
        this.filmGenresRepository = filmGenresRepository;
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

    @Override
    public void save(Long filmId, String genre) {
        Integer genreId = genresRepository.findIdByGenreName(genre);
        FilmGenre filmGenre = FilmGenre.builder()
                .filmId(filmId)
                .genreId(genreId)
                .build();
        filmGenresRepository.save(filmGenre);
    }

}
