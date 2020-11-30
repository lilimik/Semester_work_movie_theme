package ru.itis.servlets;

import ru.itis.models.FileInfo;
import ru.itis.models.User;
import ru.itis.services.FilesService;
import ru.itis.services.UserService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserService userService;
    private FilesService filesService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.userService = (UserService) context.getAttribute("userService");
        this.filesService = (FilesService) context.getAttribute("filesUploadService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false);
        String uuid = (String) httpSession.getAttribute("uuid");
        User user = userService.getUserByUUID(uuid);
        Optional<FileInfo> optionalFileInfo = filesService.getAvatarInfo(user.getId());
        if (optionalFileInfo.isPresent()) {
            FileInfo fileInfo = optionalFileInfo.get();
            response.setContentType(fileInfo.getType());
            response.setContentLength(fileInfo.getSize().intValue());
            response.setHeader("Content-Disposition", "filename\"" + fileInfo.getOriginalName() + "\"");
            response.flushBuffer();
            request.setAttribute("userAvatar", fileInfo.getStorageName());
        } else request.setAttribute("userAvatar", "WebContent/avatars/anon.png");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part part = request.getPart("avatar");
        String userId = request.getParameter("userId");
        filesService.saveAvatarToStorage(part.getInputStream(), part.getSubmittedFileName(), "WebContent/avatars/" + userId + "." + part.getContentType().split("/")[1], part.getContentType(), part.getSize());
    }
}
