package ru.itis.servlets;

import ru.itis.dto.UserInfo;
import ru.itis.models.User;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false);
        String uuid = (String) httpSession.getAttribute("uuid");
        User user = userService.getUserByUUID(uuid);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        if (password1.equals(password2)) {
            UserInfo form = UserInfo.builder()
                    .accountId(Long.parseLong(request.getParameter("userId")))
                    .firstName(request.getParameter("firstName"))
                    .lastName(request.getParameter("lastName"))
                    .password(password1)
                    .build();
            userService.updateUserInfo(form);
            response.sendRedirect("/profile");
        } else response.sendRedirect("/");
    }
}
