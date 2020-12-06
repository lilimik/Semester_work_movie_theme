package ru.itis.servlets;

import ru.itis.models.FileInfo;
import ru.itis.services.FilesService;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@WebServlet("/avatar")
@MultipartConfig
public class AvatarServlet extends HttpServlet {

    private FilesService filesService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        this.filesService = (FilesService) context.getAttribute("filesService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long fkId = Long.parseLong(request.getParameter("id"));
        FileInfo fileInfo = filesService.getAvatarInfo(fkId);
        response.setContentType(fileInfo.getType());
        response.setHeader("Content-Disposition", "filename=\"" + fileInfo.getOriginalName() + "\"");
        filesService.writeFileToStorage(fkId, response.getOutputStream());
        response.flushBuffer();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part part = request.getPart("file");
        Long userId = Long.parseLong(request.getParameter("userId"));
        String originalName = part.getSubmittedFileName();
        String storageName = "WebContent/avatars/" + userId + "." + part.getContentType().split("/")[1];
        String contentType = part.getContentType();
        Long size = part.getSize();
        filesService.saveAvatarToStorage(part.getInputStream(), userId, originalName, storageName, contentType, size);
        response.sendRedirect("/profile");
    }
}
