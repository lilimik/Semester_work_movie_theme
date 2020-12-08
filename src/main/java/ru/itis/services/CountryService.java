package ru.itis.services;

import ru.itis.models.Country;

import java.util.List;

public interface CountryService {
    Country findById(Integer id);
    List<Country> findAll();
    void save(Long filmId, String country);
}
