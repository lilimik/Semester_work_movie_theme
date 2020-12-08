package ru.itis.repositories;

import ru.itis.models.Genre;

public interface GenresRepository extends CrudRepository<Genre> {
    Integer findIdByGenreName(String genreName);
}
