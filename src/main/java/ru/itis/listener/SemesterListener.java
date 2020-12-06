package ru.itis.listener;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.itis.repositories.*;
import ru.itis.services.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class SemesterListener implements ServletContextListener {

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/semester";
    private static final String DB_USERNAME = "postgres";
    private static final String DB_PASSWORD = "11235813mixa";
    private static final String DB_DRIVER = "org.postgresql.Driver";

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext context = servletContextEvent.getServletContext();
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setDriverClassName(DB_DRIVER);
        dataSource.setUrl(DB_URL);
        dataSource.setUsername(DB_USERNAME);
        dataSource.setPassword(DB_PASSWORD);

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        UsersRepository usersRepository = new UsersRepositoryJdbcTemplateImpl(dataSource);
        CookiesRepository cookiesRepository = new CookiesRepositoryImpl(dataSource);
        GenresRepository genresRepository = new GenresRepositoryImpl(dataSource);
        CountriesRepository countriesRepository = new CountriesRepositoryImpl(dataSource);
        FilmGenresRepository filmGenresRepository = new FilmGenresRepositoryImpl(dataSource);
        FilmCountriesRepository filmCountriesRepository = new FilmCountriesRepositoryImpl(dataSource);
        FilmsRepository filmsRepository = new FilmsRepositoryImpl(dataSource);
        AvatarRepository avatarRepository = new AvatarRepositoryImpl(dataSource);
        PosterRepository posterRepository = new PostersRepositoryImpl(dataSource);
        PersonsRepository personsRepository = new PersonsRepositoryImpl(dataSource);
        RestrictionsRepository restrictionsRepository = new RestrictionsRepositoryImpl(dataSource);

        RestrictionService restrictionService = new RestrictionServiceImpl(restrictionsRepository);
        CountryService countryService = new CountryServiceImpl(countriesRepository);
        GenreService genreService = new GenreServiceImpl(genresRepository);
        FilmService filmService = new FilmServiceImpl(filmsRepository, filmGenresRepository, filmCountriesRepository , genreService, countryService);
        CookieService cookieService = new CookieServiceImpl(cookiesRepository);
        FilesService filesService = new FilesServiceImpl(avatarRepository, posterRepository);
        UserService userService = new UserServiceImpl(usersRepository, passwordEncoder, cookieService, filesService);

        context.setAttribute("restrictionService", restrictionService);
        context.setAttribute("filesService", filesService);
        context.setAttribute("userService", userService);
        context.setAttribute("cookieService", cookieService);
        context.setAttribute("countryService", countryService);
        context.setAttribute("genreService", genreService);
        context.setAttribute("filmService", filmService);

    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
