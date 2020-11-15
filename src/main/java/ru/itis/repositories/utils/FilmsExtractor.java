package ru.itis.repositories.utils;

import ru.itis.dto.FilmRO;
import ru.itis.models.Film;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Stream;

public class FilmsExtractor extends AbstractHasManyExtractor<Film, Map<String, String>, FilmRO> {

    @Override
    public Film buildOwnerModel(ResultSet resultSet) throws SQLException {
        return Film.builder()
                .id(resultSet.getLong("id"))
                .title(resultSet.getString("title"))
                .boxOffice(resultSet.getLong("box_office"))
                .budget(resultSet.getLong("budget"))
                .description(resultSet.getString("description"))
                .year(resultSet.getShort("year"))
                .restriction(resultSet.getByte("restriction_age"))
                .build();
    }

    @Override
    public Map<String, String> buildManyModel(ResultSet resultSet) throws SQLException {
        Map<String, String> map = new HashMap<>();
        map.put("genre", resultSet.getString("genre_name"));
        map.put("country", resultSet.getString("country_name"));
        return map;
    }

    @Override
    public List<FilmRO> buildResult(Map<Film, List<Map<String, String>>> map) {
        List<FilmRO> result = new LinkedList<>();
        for (Map.Entry<Film, List<Map<String, String>>> item : map.entrySet()) {
            Set<String> genres = new HashSet<>();
            Set<String> countries = new HashSet<>();

            Stream.of(item).forEach(x -> {
                List<Map<String, String>> listMaps = x.getValue();
                for (Map<String, String> stringStringMap : listMaps) {
                    genres.add(stringStringMap.get("genre"));
                    countries.add(stringStringMap.get("country"));
                }
            });

            Film film = item.getKey();
            FilmRO ro = FilmRO.builder()
                    .id(film.getId())
                    .title(film.getTitle())
                    .boxOffice(film.getBoxOffice())
                    .budget(film.getBudget())
                    .description(film.getDescription())
                    .year(film.getYear())
                    .restriction(film.getRestriction())
                    .genresList(new ArrayList<>(genres))
                    .countryList(new ArrayList<>(countries))
                    .build();
            result.add(ro);
        }
        return result;
    }
}
