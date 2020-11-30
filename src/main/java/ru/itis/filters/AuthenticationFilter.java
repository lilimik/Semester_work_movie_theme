package ru.itis.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {


    @Override
    public void init(FilterConfig filterConfig) {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpSession session = request.getSession(false);

        Boolean isAuthenticated = false;
        boolean sessionExists = session != null;
        boolean isLoginPage = request.getRequestURI().equals("/signIn");
        boolean isRegisterPage = request.getRequestURI().equals("/signUp");
        boolean isRootPage = request.getRequestURI().equals("/");
        boolean isStaticResource = request.getRequestURI().startsWith("/WebContent");

        if (sessionExists) {
            isAuthenticated = (Boolean) session.getAttribute("authenticated");

            if (isAuthenticated == null) {
                isAuthenticated = false;
            }
        }

        // если авторизован и запрашивает не логин или если не авторизован и запрашивает логин
        if (isAuthenticated & (!isLoginPage & !isRegisterPage) || !isAuthenticated & (isLoginPage || isRegisterPage) || isStaticResource || isRootPage) {
            // отдаем ему то, что он хочет
            filterChain.doFilter(request, response);
        } else if (isAuthenticated & (isLoginPage || isRegisterPage)) {
            // пользователь аутенцифицирован и запрашивает страницу входа или регистрации
            // - отдаем ему корень
            response.sendRedirect("/");
        } else {
            // если пользователь не аутенцицицирован и запрашивает другие страницы
            response.sendRedirect("/signIn");
        }

    }

    @Override
    public void destroy() {

    }
}
