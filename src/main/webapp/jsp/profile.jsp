<%@ page import="ru.itis.models.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Профиль</title>

    <link rel="SHORTCUT ICON" href="WebContent/image/main_image.png">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://bootstraptema.ru/plugins/2015/bootstrap3/bootstrap.min.css"/>
    <link rel="stylesheet" href="WebContent/style/profile.css"/>
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

</head>
<body>

<% User user = (User) request.getAttribute("user"); %>

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
            </ul>
        </div>
        <div class="d-flex justify-content-end">
            <form class="form-inline my-2 my-lg-0 flex-end">
                <input class="form-control mr-sm-2" type="search" placeholder="Фильмы, персоны" aria-label="Search">
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
                                <strong>Пользователь сайта</strong>
                            </div>
                        </header>
                    </div>
                    <div class="panel-body">
                        <div class="text-center" id="author">
                            <img src="https://sun9-33.userapi.com/nV356FyoOQ0S8ExA0RhNwqLjzCbRaHqOwmF36g/yVqigC76wAA.jpg"
                                 alt="avatar">

                            <h3><%=user.getFirstName()%> <%=user.getLastName()%></h3>

<%--                            <p>статус...</p>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-md-8 col-xs-12">
                <div class="panel">
                    <div class="panel-body">
                        <ul id="myTab" class="nav nav-pills">
                            <li class="active"><a href="#detail" data-toggle="tab">О пользователе</a></li>
                            <li class=""><a href="#reviews" data-toggle="tab">Отзывы</a></li>
                            <li class=""><a href="#editing" data-toggle="tab">Редактировать</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <hr>
                            <div class="tab-pane fade active in" id="detail">
                                <h4 class="text-center"><strong>Профиль</strong></h4>
                                <br>
                                <table class="table table-th-block">
                                    <tbody>
                                    <tr>
                                        <td class="active">id:</td>
                                        <td><%=user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <td class="active">email:</td>
                                        <td><%=user.getEmail()%></td>
                                    </tr>
                                    <tr>
                                        <td class="active">Имя:</td>
                                        <td><%=user.getFirstName()%></td>
                                    </tr>
                                    <tr>
                                        <td class="active">Фамилия:</td>
                                        <td><%=user.getLastName()%></td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>


                            <div class="tab-pane fade" id="reviews">
                                <h4 class="text-center"><strong>Отзывы</strong></h4>
                                <br>

                                <br><br>
                            </div>

                            <div class="tab-pane fade" id="editing">
                                <h4 class="text-center"><strong>Редактирование</strong></h4>
                                <br>

                                <form data-toggle="validator">
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label" for="exampleFormControlFile1">
                                            Ваше фото</label>
                                        <div class="col-sm-10">
                                            <input type="file" class="form-control-file " id="exampleFormControlFile1"
                                                   value="Выбрать файл">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="firstName" class="col-sm-2 col-form-label">Имя</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="firstName">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="lastName" class="col-sm-2 col-form-label">Фамилия</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="lastName">
                                        </div>
                                    </div>
                                    <div class="form-group row help">
                                        <label for="inputPassword" class="col-sm-2 col-form-label">Пароль</label>
                                        <div class="col-sm-5">
                                        <input type="password" data-toggle="validator" data-minlength="6"
                                                                                  class="form-control"
                                                                                  name="password1" id="inputPassword"
                                                                                  placeholder="Пароль">
                                        <span class="help-block text-dark">Минимум 6 символов</span>
                                        </div>
                                        <label for="inputPasswordConfirm"></label>
                                        <div class="col-sm-5">
                                        <input type="password" class="form-control"
                                                                                         name="password2" id="inputPasswordConfirm"
                                                                                         data-match="#inputPassword"
                                                                                         placeholder="Повторите пароль"
                                                                                         data-match-error="Пароли не совпадают!" >
                                        <div class="help-block with-errors"></div>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-outline-primary shadow p-2 rounded">Сохранить
                                    </button>

                                </form>

                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>