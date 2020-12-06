package ru.itis.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import ru.itis.dto.SignUpForm;
import ru.itis.models.User;
import ru.itis.services.FilesService;
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

@WebServlet("/users")
public class UsersServlet extends HttpServlet {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private UserService userService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
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
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // приняли JSON на вход, и с помощью ObjectMapper превратили в User-объект
        SignUpForm form = objectMapper.readValue(request.getReader(), SignUpForm.class);

        userService.signUp(form);
        List<User> users = userService.findAll();
        // сформировали JSON-строку-ответ
        String userAsJson = objectMapper.writeValueAsString(users);
        System.out.println(userAsJson);
        response.setContentType("application/json");
        // отправили ответ
        response.getWriter().println(userAsJson);
    }
}
