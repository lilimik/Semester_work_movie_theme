<%@ page import="ru.itis.models.User" %>
<%@ page import="ru.itis.models.Film" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Главная</title>

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
    <link rel="stylesheet" href="WebContent/style/profile.css">
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    String userAvatar = (String) request.getAttribute("userAvatar");
    Film film = (Film) request.getAttribute("film");
    List<String> countries = (List<String>) request.getAttribute("countries");
    List<String> genres = (List<String>) request.getAttribute("genres");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
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
                <% if (user != null) {
                    if (userAvatar != null) {%>
                <img src="<%=userAvatar%>"
                     alt="avatar" style="width: 50px; height: 50px;">
                <%}%>
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
            </ul>
        </div>
        <div class="d-flex justify-content-end">
            <form class="form-inline my-2 my-lg-0 flex-end" action="${pageContext.request.contextPath}/find_film">
                <input class="form-control mr-sm-2" type="search" name="need_film" placeholder="Найти фильм" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Найти</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mb-5">
    <div id="main">

        <div class="row" id="real-estates-detail">
            <div class="col-lg-4 col-md-4 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <header class="panel-title">
                            <div class="text-center">
                                <strong>Фильм</strong>
                            </div>
                        </header>
                    </div>
                    <div class="panel-body">
                        <div class="text-center" id="author">
                            <%-- <%=filmPoster%> --%>
                            <img src="https://hype.tech/covers/1913/hype-ru-cover-clean-7011.jpg"
                                 alt="avatar" style="width: 245px; height: 245px">
                            <h3><%=film.getTitle()%>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-md-8 col-xs-12">
                <div class="panel">
                    <div class="panel-body">
                        <div class="tab-pane fade active in" id="detail">
                            <h4 class="text-center"><strong>Информация о фильме:</strong></h4>
                            <br>
                            <table class="table table-th-block">
                                <tbody>
                                <tr>
                                    <td class="active">Название:</td>
                                    <td><%=film.getTitle()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Год:</td>
                                    <td><%=film.getYear()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Жанр:</td>
                                    <td>
                                        <%for (String genre : genres) {%>
                                        <span><%=genre%></span><br>
                                        <%}%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Страна:</td>
                                    <td>
                                        <%for (String country : countries) {%>
                                        <span><%=country%></span><br>
                                        <%}%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Сборы:</td>
                                    <td><%=film.getBoxOffice()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Бюджет:</td>
                                    <td><%=film.getBudget()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Ограничение:</td>
                                    <td><%=film.getRestriction()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">Описание:</td>
                                    <td><%=film.getDescription()%>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
