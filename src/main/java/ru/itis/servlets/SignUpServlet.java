package ru.itis.servlets;

import ru.itis.dto.SignUpForm;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signUp")
public class SignUpServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/sign_up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (request.getParameter("password1").equals(request.getParameter("password2"))) {
            SignUpForm form = SignUpForm.builder()
                    .email(request.getParameter("email"))
                    .firstName(request.getParameter("first_name"))
                    .lastName(request.getParameter("last_name"))
                    .password(request.getParameter("password1"))
                    .build();
            userService.signUp(form);
            response.sendRedirect("signIn");
        } else
            response.sendRedirect("/signUp");
    }
}
