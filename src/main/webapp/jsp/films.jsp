<%@ page import="ru.itis.models.User" %>
<%@ page import="ru.itis.models.Genre" %>
<%@ page import="ru.itis.models.Country" %>
<%@ page import="ru.itis.models.Restriction" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Фильмы</title>

    <link rel="SHORTCUT ICON" href="WebContent/image/main_image.png">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
            integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://bootstraptema.ru/plugins/2015/bootstrap3/bootstrap.min.css"/>
    <link rel="stylesheet" href="WebContent/style/root.css">
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    List<Country> countries = (List<Country>) request.getAttribute("countries");
    List<Restriction> restrictions = (List<Restriction>) request.getAttribute("restrictions");
%>

<div class="index">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark position-fixed">
        <div class="class=d-inline-flex">
            <a class="navbar-brand p-0 m-0" href="${pageContext.request.contextPath}/"><img
                    style="width: 50px; height: 50px;" id="main_image"
                    src="WebContent/image/main_image.png"
                    alt="main"></a>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><span>КиноФетиш</span></a>
        </div>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
            <div class="justify-content-center">
                <ul class="navbar-nav">
                    <% if (user != null) {%>
                    <img src="${pageContext.request.contextPath}/avatar?id=<%=user.getId()%>"
                         alt="avatar" style="width: 50px; height: 50px;">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button"
                           data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            Аккаунт
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown1">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Профиль</a>
                            <a class="dropdown-item text-danger"
                               href="${pageContext.request.contextPath}/logOut">Выйти</a>
                        </div>
                    </li>
                    <% } else { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                           data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            Авторизация
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/signIn">Вход</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/signUp">Регистрация</a>
                        </div>
                    </li>
                    <% } %>
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="${pageContext.request.contextPath}/users">
                            Пользователи
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="${pageContext.request.contextPath}/films">
                            Фильмы
                        </a>
                    </li>
                </ul>
            </div>
            <div class="d-flex justify-content-end">
                <form class="form-inline my-2 my-lg-0 flex-end" action="${pageContext.request.contextPath}/find_film">
                    <input class="form-control mr-sm-2" type="search" name="need_film" placeholder="Найти фильм"
                           aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Найти</button>
                </form>
            </div>
        </div>
    </nav>
</div>

<div class="content">

    <div class="container mt-5">
        <div class="row">

            <div class="col-md-offset-3 col-md-6">
                <div class="container" style="width: 300px">
                    <form class="form-horizontal pb-1" data-toggle="validator" action="${pageContext.request.contextPath}/films" method="post">
                        <div class="form-group">
                            <label for="title" class="text-white">Название:</label>
                            <input type="text" class="form-control" name="title" id="title" required>
                        </div>
                        <div class="form-group">
                            <label for="boxOffice" class="text-white">Кассовые сборы:</label>
                            <input type="text" class="form-control" name="boxOffice" id="boxOffice" required>
                        </div>
                        <div class="form-group">
                            <label for="budget" class="text-white">Бюджет фильма:</label>
                            <input type="text" class="form-control" name="budget" id="budget" required>
                        </div>
                        <div class="form-group">
                            <label for="description" class="text-white">Описание фильма:</label>
                            <textarea class="form-control" name="description" id="description" rows="3"
                                      required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="year" class="text-white">Год выпуска:</label>
                            <select class="form-control" name="year" id="year" required>
                                <%for (int i = 1895; i < 2020; i++) {%>
                                <option><%=i%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="genres" class="text-white">Жанры:</label>
                            <select multiple class="form-control" name="genresList" id="genres" required>
                                <%for (Genre genre : genres) {%>
                                <option><%=genre.getName()%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="countries" class="text-white">Страны:</label>
                            <select multiple class="form-control" name="countryList" id="countries" required>
                                <%for (Country country : countries) {%>
                                <option><%=country.getName()%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="restriction" class="text-white">Ограничение по возрасту:</label>
                            <select class="form-control" name="restriction" id="restriction" required>
                                <%for (Restriction restriction : restrictions) {%>
                                <option><%=restriction.getAge()%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <button class="btn btn-primary" type="submit">
                            создать
                        </button>
                    </form>
                </div>
                <br>
            </div>
        </div>
    </div>
</div>

</body>
</html>
