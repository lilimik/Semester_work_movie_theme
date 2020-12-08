package ru.itis.repositories;

import ru.itis.models.Film;
import ru.itis.dto.FilmRO;

import java.util.List;
import java.util.Optional;

public interface FilmsRepository extends CrudRepository<Film>  {
    Optional<Film> findFilmByTitle(String title);
    List<Film> findFilmsByYear(Short year);
    List<FilmRO> findFilmsByGenreName(String genreName);
    List<FilmRO> findFilmsByCountryName(String countryName);
    List<FilmRO> findGenresByFilmTitle(String filmTitle);
    List<FilmRO> findCountriesByFilmTitle(String filmTitle);
    Long saveAndReturnId(Film entity);
}
