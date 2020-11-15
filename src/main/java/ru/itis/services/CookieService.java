package ru.itis.services;

import ru.itis.models.Cookie;

public interface CookieService {
    Long findIdByUuid(String uuid);
    void save(Cookie cookie);
}
