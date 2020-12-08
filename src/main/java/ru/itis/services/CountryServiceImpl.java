package ru.itis.services;

import ru.itis.models.Country;
import ru.itis.models.FilmCountry;
import ru.itis.repositories.CountriesRepository;
import ru.itis.repositories.FilmCountriesRepository;

import java.util.List;
import java.util.Optional;

public class CountryServiceImpl implements CountryService {

    private final CountriesRepository countriesRepository;
    private final FilmCountriesRepository filmCountriesRepository;

    public CountryServiceImpl(CountriesRepository countriesRepository, FilmCountriesRepository filmCountriesRepository) {
        this.countriesRepository = countriesRepository;
        this.filmCountriesRepository = filmCountriesRepository;
    }

    @Override
    public Country findById(Integer id) {
        Country country = null;
        Optional<Country> optionalCountry = countriesRepository.findById(id.longValue());
        if (optionalCountry.isPresent()) {
            country = optionalCountry.get();
        }
        return country;
    }

    @Override
    public List<Country> findAll() {
        return countriesRepository.findAll();
    }

    @Override
    public void save(Long filmId, String country) {
        Integer countryId = countriesRepository.findIdByCountryName(country);
        FilmCountry filmCountry = FilmCountry.builder()
                .filmId(filmId)
                .countryId(countryId)
                .build();
        filmCountriesRepository.save(filmCountry);
    }

}
