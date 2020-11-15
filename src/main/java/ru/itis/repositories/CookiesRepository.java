package ru.itis.repositories;

import ru.itis.models.Cookie;

public interface CookiesRepository extends CrudRepository<Cookie> {
    Long findIdByUuid(String uuid);
    int updateCookie(Cookie cookie);
}
