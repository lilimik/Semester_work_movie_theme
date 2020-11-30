package ru.itis.models;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class FileInfo {
    private Long fkId;
    private String originalName;
    private String storageName;
    private Long size;
    private String type;
}
