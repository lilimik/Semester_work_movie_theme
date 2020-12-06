package ru.itis.servlets;

import ru.itis.models.*;
import ru.itis.services.*;

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
    private GenreService genreService;
    private CountryService countryService;
    private RestrictionService restrictionService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
        this.genreService = (GenreService) context.getAttribute("genreService");
        this.countryService = (CountryService) context.getAttribute("countryService");
        this.restrictionService = (RestrictionService) context.getAttribute("restrictionService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false);
        String uuid;
        User user = null;
        if (httpSession != null) {
            uuid = (String) httpSession.getAttribute("uuid");
            if (uuid != null) {
                user = userService.getUserByUUID(uuid);
            }
        }
        List<Genre> genres = genreService.findAll();
        request.setAttribute("genres", genres);
        List<Country> countries = countryService.findAll();
        request.setAttribute("countries", countries);
        List<Restriction> restrictions = restrictionService.findAll();
        request.setAttribute("restrictions", restrictions);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/root.jsp").forward(request, response);
    }

}
