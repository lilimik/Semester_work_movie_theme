package ru.itis.models;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class Film {
    private Long id;
    private String title;
    private Long boxOffice;
    private Long budget;
    private String description;
    private Short year;
    private Byte restriction;
}
