package ru.itis.servlets;

import ru.itis.models.FileInfo;
import ru.itis.models.Film;
import ru.itis.models.User;
import ru.itis.services.FilesService;
import ru.itis.services.FilmService;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/film")
public class FilmServlet extends HttpServlet {

    private UserService userService;
    private FilmService filmService;
    private FilesService filesService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
        this.filmService = (FilmService) context.getAttribute("filmService");
        this.filesService = (FilesService) context.getAttribute("filesService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession httpSession = req.getSession(false);
        String uuid;
        User user = null;
        if (httpSession != null) {
            uuid = (String) httpSession.getAttribute("uuid");
            if (uuid != null) {
                user = userService.getUserByUUID(uuid);
            }
        }
        Long filmId = Long.parseLong(req.getParameter("id"));
        Film film = filmService.findFilmById(filmId);
        List<String> countries = filmService.findCountriesByFilmTitle(film.getTitle());
        List<String> genres = filmService.findGenresByFilmTitle(film.getTitle());
        req.setAttribute("user", user);
        req.setAttribute("genres", genres);
        req.setAttribute("countries", countries);
        req.setAttribute("film", film);
        req.getRequestDispatcher("/jsp/film.jsp").forward(req, resp);
    }

}
