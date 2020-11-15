package ru.itis.servlets;

import ru.itis.models.User;
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

@WebServlet("/")
public class RootServlet extends HttpServlet {

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
            if (uuid != null)
                user = userService.getUserByUUID(uuid);
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/root.jsp").forward(request, response);
    }
}
