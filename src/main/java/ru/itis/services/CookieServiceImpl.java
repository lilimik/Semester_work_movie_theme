package ru.itis.services;

import ru.itis.models.Cookie;
import ru.itis.repositories.CookiesRepository;

public class CookieServiceImpl implements CookieService {

    private final CookiesRepository cookiesRepository;

    public CookieServiceImpl(CookiesRepository cookiesRepository) {
        this.cookiesRepository = cookiesRepository;
    }
    @Override
    public Long findIdByUuid(String uuid) {
        return cookiesRepository.findIdByUuid(uuid);
    }

    @Override
    public void save(Cookie cookie) {
        cookiesRepository.save(cookie);
    }
}
