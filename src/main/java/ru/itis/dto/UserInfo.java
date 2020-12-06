package ru.itis.dto;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class UserInfo {
    private Long accountId;
    private String firstName;
    private String lastName;
    private String password;
}
