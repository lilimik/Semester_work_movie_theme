package ru.itis.servlets;

import ru.itis.models.Film;
import ru.itis.models.User;
import ru.itis.services.FilmService;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class RootServlet extends HttpServlet {

    private UserService userService;
    private FilmService filmService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
        this.filmService = (FilmService) context.getAttribute("filmService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false);
        String uuid;
        User user = null;
        if (httpSession != null) {
            uuid = (String) httpSession.getAttribute("uuid");
            if (uuid != null)
                user = userService.getUserByUUID(uuid);
        }
        List<Film> horrorFilms = filmService.findFilmsByGenreName("ужасы");
        request.setAttribute("horrorFilms", horrorFilms);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/root.jsp").forward(request, response);
    }

}
