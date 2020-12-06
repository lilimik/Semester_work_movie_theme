package ru.itis.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import ru.itis.dto.GenreForm;
import ru.itis.models.Film;
import ru.itis.services.FilmService;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/genreForm")
public class GenreFormServlet extends HttpServlet {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private FilmService filmService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.filmService = (FilmService) context.getAttribute("filmService");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("Жанры:");

        ArrayList<String> genres = objectMapper.readValue(request.getReader(), TypeFactory.defaultInstance().constructCollectionType(List.class, String.class));

        genres.forEach(System.out::println);

        Map<String, List<Film>> films = new HashMap<>();
        for (String genre : genres) {
            List<Film> filmList = filmService.findFilmsByGenreName(genre);
            films.put(genre, filmList);
        }
        // сформировали JSON-строку-ответ
        String filmsAsJson = objectMapper.writeValueAsString(films);
        System.out.println(filmsAsJson);
        response.setContentType("application/json");
        // отправили ответ
        response.getWriter().println(filmsAsJson);
    }
}
