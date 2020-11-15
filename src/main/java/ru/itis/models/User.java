package ru.itis.models;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class User {
    private Long id;
    private String email;
    private String hashPassword;
    private String firstName;
    private String lastName;
}
