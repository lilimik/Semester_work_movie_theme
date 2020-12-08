package ru.itis.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import ru.itis.dto.FilmRO;
import ru.itis.dto.SignUpForm;
import ru.itis.models.*;
import ru.itis.services.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@WebServlet("/films")
public class FilmsServlet extends HttpServlet {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private UserService userService;
    private FilmService filmService;
    private GenreService genreService;
    private CountryService countryService;
    private RestrictionService restrictionService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
        this.filmService = (FilmService) context.getAttribute("filmService");
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
        request.getRequestDispatcher("/jsp/films.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // приняли JSON на вход, и с помощью ObjectMapper превратили в User-объект
        Map<String, String[]> parameterMap = request.getParameterMap();
        System.out.println(parameterMap.toString());
        List<String> genresList = Arrays.asList(parameterMap.get("genresList"));
        List<String> countryList = Arrays.asList(parameterMap.get("countryList"));

        Film form = Film.builder()
                .title(parameterMap.get("title")[0])
                .boxOffice(parameterMap.get("boxOffice")[0])
                .budget(parameterMap.get("budget")[0])
                .description(parameterMap.get("description")[0])
                .year(Short.parseShort(parameterMap.get("year")[0]))
                .restriction(Byte.parseByte(parameterMap.get("restriction")[0]))
                .build();

        Long filmId = filmService.save(form);

        for (String genre : genresList) {
            genreService.save(filmId, genre);
        }

        for (String country : countryList) {
            countryService.save(filmId, country);
        }
        response.sendRedirect("/films");
//        List<User> users = userService.findAll();
//        // сформировали JSON-строку-ответ
//        String userAsJson = objectMapper.writeValueAsString(users);
//        System.out.println(userAsJson);
//        response.setContentType("application/json");
//        // отправили ответ
//        response.getWriter().println(userAsJson);
    }

}
