package ru.itis.servlets;

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

@WebServlet("/find_film")
public class FindFilmServlet extends HttpServlet {

    private FilmService filmService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.filmService = (FilmService) context.getAttribute("filmService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String filmTitle = req.getParameter("need_film");
        Long filmId;
        filmId = filmService.findFilmByTitle(filmTitle).getId();
        if (filmId != null)
            resp.sendRedirect("/film?id=" + filmId);
        else resp.sendRedirect("/");
    }
}
