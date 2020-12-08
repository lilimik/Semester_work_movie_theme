package ru.itis.repositories;

import ru.itis.models.Country;

public interface CountriesRepository extends CrudRepository<Country> {
    Integer findIdByCountryName(String countryName);
}
