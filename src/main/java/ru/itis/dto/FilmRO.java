package ru.itis.dto;

import lombok.*;

import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
// response object
public class FilmRO {
    private Long id;
    private String title;
    private Long boxOffice;
    private Long budget;
    private String description;
    private Short year;
    private Byte restriction;
    private List<String> countryList;
    private List<String> genresList;
}
