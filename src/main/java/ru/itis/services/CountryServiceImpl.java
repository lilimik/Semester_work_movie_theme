package ru.itis.services;

import ru.itis.models.Country;
import ru.itis.repositories.CountriesRepository;
import ru.itis.repositories.FilmCountriesRepository;

import java.util.List;
import java.util.Optional;

public class CountryServiceImpl implements CountryService {

    private final CountriesRepository countriesRepository;

    public CountryServiceImpl(CountriesRepository countriesRepository) {
        this.countriesRepository = countriesRepository;
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

}
