package ru.itis.services;

import ru.itis.models.Film;

import java.util.List;

public interface FilmService {
    Film findFilmById(Long filmId);
    Film findFilmByTitle(String title);
    List<Film> findFilmsByGenreName(String genreName);
//    List<String> findGenresByFilmTitle(String filmTitle);
    List<Film> findFilmsByCountryName(String countryName);
//    List<String> findCountriesByFilmTitle(String filmTitle);
    List<Film> findFilmsByYear(Short year);
}
