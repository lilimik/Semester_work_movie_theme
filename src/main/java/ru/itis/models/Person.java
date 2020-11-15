package ru.itis.models;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class Person {
    private Long id;
    private String firstName;
    private String lastName;
    private Short born;
    private int countryId;
    private int sex_id;
}
