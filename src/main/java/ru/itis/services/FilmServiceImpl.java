package ru.itis.services;

import ru.itis.dto.FilmRO;
import ru.itis.models.Film;
import ru.itis.repositories.FilmCountriesRepository;
import ru.itis.repositories.FilmGenresRepository;
import ru.itis.repositories.FilmsRepository;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class FilmServiceImpl implements FilmService {

    private final FilmsRepository filmsRepository;
    private final FilmGenresRepository filmGenresRepository;
    private final FilmCountriesRepository filmCountriesRepository;
    private final GenreService genreService;
    private final CountryService countryService;

    public FilmServiceImpl(FilmsRepository filmsRepository, FilmGenresRepository filmGenresRepository, FilmCountriesRepository filmCountriesRepository, GenreService genreService, CountryService countryService) {
        this.filmsRepository = filmsRepository;
        this.filmGenresRepository = filmGenresRepository;
        this.filmCountriesRepository = filmCountriesRepository;
        this.genreService = genreService;
        this.countryService = countryService;
    }

    private List<Film> getFilmsFromFilmsRO(List<FilmRO> filmsRO) {
        List<Film> films = new LinkedList<>();
        for (FilmRO filmRO: filmsRO) {
            Film film = Film.builder()
                    .id(filmRO.getId())
                    .title(filmRO.getTitle())
                    .boxOffice(filmRO.getBoxOffice())
                    .budget(filmRO.getBudget())
                    .description(filmRO.getDescription())
                    .year(filmRO.getYear())
                    .restriction(filmRO.getRestriction())
                    .build();
            films.add(film);
        }
        return films;
    }

    @Override
    public Film findFilmByTitle(String title) {
        Film film = null;
        Optional<Film> optionalFilm = filmsRepository.findFilmByTitle(title);
        if (optionalFilm.isPresent()) {
            film = optionalFilm.get();
        }
        return film;
    }

    @Override
    public Film findFilmById(Long filmId) {
        Film film = null;
        Optional<Film> optionalFilm = filmsRepository.findById(filmId);
        if (optionalFilm.isPresent()) {
            film = optionalFilm.get();
        }
        return film;
    }

    @Override
    public List<Film> findFilmsByGenreName(String genreName) {
        List<FilmRO> filmsRO = filmsRepository.findFilmsByGenreName(genreName);
        return getFilmsFromFilmsRO(filmsRO);
    }

    @Override
    public List<Film> findFilmsByCountryName(String countryName) {
        List<FilmRO> filmsRO = filmsRepository.findFilmsByCountryName(countryName);
        return getFilmsFromFilmsRO(filmsRO);
    }

//    @Override
//    public List<String> findGenresByFilmTitle(String filmTitle) {
//        Film film = findFilmByTitle(filmTitle);
//        List<Integer> genresId = genreService.findGenresIdByFilmId(filmId);
//        List<String> genresName = new LinkedList<>();
//        if (!genresId.isEmpty()) {
//            for (Integer genreId : genresId) {
//                genresName.add(genreService.findNameById(genreId));
//            }
//        }
//        return genresName;
//    }

//    @Override
//    public List<String> findCountriesByFilmTitle(String filmTitle) {
//        Long filmId = findFilmIdByTitle(filmTitle);
//        List<Integer> countriesId = countryService.findCountriesIdByFilmId(filmId);
//        List<String> countriesName = new LinkedList<>();
//        if (!countriesId.isEmpty()) {
//            for (Integer countryId : countriesId) {
//                countriesName.add(countryService.findNameById(countryId));
//            }
//        }
//        return countriesName;
//    }

    @Override
    public List<Film> findFilmsByYear(Short year) {
        return filmsRepository.findFilmsByYear(year);
    }


}