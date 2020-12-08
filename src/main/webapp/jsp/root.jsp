<%@ page import="java.util.List" %>
<%@ page import="ru.itis.models.*" %>
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
    <link rel="stylesheet" href="WebContent/style/root.css">
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

    <script>

        function renderCarousels(mapFilms, carousels) {

            const keys = Object
                .keys(mapFilms)
                .map(genre => ({genre, films: mapFilms[genre]}))
                .map(({genre, films}, i) => {

                    let innerHtml =
                        '<div class="pb-3">' +
                        '<h3 class="text-light text-center" id="for_carouselExampleFade' + i + '"><a class="none_link_line" href="#">' + genre + '</a>' +
                        '</h3>' +
                        '</div>' +


                        '<div id="carouselExampleFade' + i + '" class="carousel slide pb-0 pt-0 row" data-ride="carousel">' +

                        '    <a class="carousel-control-prev col-md-1" href="#carouselExampleFade' + i + '" role="button" data-slide="prev">' +
                        '        <span class="carousel-control-prev-icon" aria-hidden="true"></span>' +
                        '        <span class="sr-only bg-link-carousel">Previous</span>' +
                        '    </a>' +

                        '<div class="carousel-inner col-md-10">';

                    let num = 0;
                    for (let j = 0; j < films.length; j++) {
                        if (num === 0) {
                            if (j === 0) {

                                innerHtml += '<div class="carousel-item active">' +
                                    '<div class="container text-center ">' +

                                    '<div class="text-center pl-0 pr-0 container d-flex flex-row ">';

                            } else {

                                innerHtml += '<div class="carousel-item">' +
                                    '<div class="container text-center ">' +

                                    '<div class="text-center pl-0 pr-0 container d-flex flex-row ">';

                            }
                        }


                        if (num < 3) {
                            innerHtml += '<div class="block col-md-6 col-xl-3 ">' +
                                '<div class="card shadow " style="width: auto">' +
                                '<img src= "https://hype.tech/covers/1913/hype-ru-cover-clean-7011.jpg" class="card-img-top" alt="Red roses">' +
                                '<div class="card-body p-0">' +
                                '<h5 class="card-title pt-1 mb-1">' + films[j].title + '</h5>' +
                                '<div class="text-center">' +
                                '<small><b> Год:</b>' + films[j].year + '</small>' +
                                '</div>' +
                                '<div class="scroll">' +
                                '<p class="card-text p-2">' + films[j].description + '</p>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';

                            num++;
                            if (num === 3 || j === films.length - 1) {

                                innerHtml += '</div>' +
                                    '</div>' +
                                    '</div>';

                                num = 0;
                            }
                        }
                    }

                    innerHtml += '</div>' +
                        '<a class="carousel-control-next col-md-1" href="#carouselExampleFade' + i + '" role="button"' +
                        ' data-slide="next">' +
                        '<span class="carousel-control-next-icon" aria-hidden="true"></span>' +
                        '<span class="sr-only">Next</span>' +
                        '</a>' +
                        '</div>';

                    return innerHtml;
                })

            keys.forEach(key => carousels.append(key))
        }



        function findFilmsByGenres() {

            let data = [];

            $('#genreForm').find(`input:checked`).each(function () {
                data.push($(this).val());
            });

            $.ajax({
                type: "POST", // метод запроса
                url: "/genreForm", // url запроса
                data: JSON.stringify(data), // JSON-объект в JSON-строку
                // что происходит, если запрос прошел успешно
                success: function (response) {
                    renderCarousels(response, $('#carousels'))
                },
                // тип данных, который мы отправляем
                dataType: "json",
                contentType: "application/json"
            })

        }

    </script>

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
                <ul class="navbar-nav justify-content-between">
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
    <div class="row-12 ">
        <div class="col-md-9" id="carousels">


            <div class="col-md-3 text-center position-fixed second_div border-left border-dark pad_div2"
                 style="background-color: white; height: 100%">


                <legend class="mb-0"><b>Фильтр</b></legend>

                <ul class="nav nav-tabs nav-fill" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link" id="genre" data-toggle="tab"
                           href="#for_genre" role="tab"
                           aria-controls="home" aria-selected="true">Жанр</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="country" data-toggle="tab"
                           href="#for_country" role="tab"
                           aria-controls="profile" aria-selected="false">Страна</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="restriction" data-toggle="tab"
                           href="#for_restriction"
                           role="tab"
                           aria-controls="contact" aria-selected="false">Ограничение</a>
                    </li>
                </ul>

                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="for_genre"
                         role="tabpanel"
                         aria-labelledby="genre">

                        <form id="genreForm">

                            <div class="col-form-label col-md-12 pt-0">
                                <h4 class=" col-md-10 text-center"><b>Все жанры:</b>
                                </h4>
                            </div>

                            <div class="scroll pl-0" style="width: 105%; height: 380px">

                                <fieldset class="form-group pt-3">
                                    <div class="row text-left">

                                            <% for (Genre genre : genres) {%>
                                        <div class="form-check col-md-12 row">
                                            <input class="form-check-input col-md-6"
                                                   type="checkbox"
                                                   name="gridRadios"
                                                   id="<%=genre.getName()%>"
                                                   value="<%=genre.getName()%>">
                                            <label class="form-check-label col-md-6"
                                                   for="<%=genre.getName()%>">
                                                <%=genre.getName()%>
                                            </label>
                                        </div>
                                            <%}%>

                                </fieldset>

                            </div>
                            <button type="button" class="btn btn-outline-primary shadow p-2 rounded"
                                    onclick="findFilmsByGenres()">
                                создать
                            </button>

                        </form>


                    </div>
                    <div class="tab-pane fade" id="for_country" role="tabpanel"
                         aria-labelledby="countries">

                        <form>

                            <div class="col-form-label col-md-12 pt-0">
                                <h4 class=" col-md-10 text-center"><b>Страны:</b></h4>
                            </div>

                            <div class="scroll pl-0" style="width: 105%; height: 380px">

                                <fieldset class="form-group pt-3">
                                    <div class="row text-left">

                                            <% for (Country country : countries) {%>
                                        <div class="form-check col-md-12 row">
                                            <input class="form-check-input col-md-6"
                                                   type="checkbox"
                                                   name="gridRadios"
                                                   id="<%=country.getName()%>"
                                                   value="<%=country.getName()%>">
                                            <label class="form-check-label col-md-6"
                                                   for="<%=country.getName()%>">
                                                <%=country.getName()%>
                                            </label>
                                        </div>
                                            <%}%>

                                </fieldset>

                            </div>
                            <input type="submit" value="Найти">
                        </form>

                    </div>

                    <div class="tab-pane fade" id="for_restriction" role="tabpanel"
                         aria-labelledby="restriction">
                        <form>

                            <div class="col-form-label col-md-12 pt-0">
                                <h4 class=" col-md-10 text-center"><b>По возрасту:</b>
                                </h4>
                            </div>

                            <div class="scroll pl-0" style="width: 105%; height: 380px">

                                <fieldset class="form-group pt-3">
                                    <div class="row text-left">

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                    <% for (Restriction restriction: restrictions) {%>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6"
                                                           type="checkbox"
                                                           name="gridRadios"
                                                           id="<%=restriction.getAge()%>"
                                                           value="<%=restriction.getAge()%>">
                                                    <label class="form-check-label col-md-6"
                                                           for="<%=restriction.getAge()%>">
                                                        <%=restriction.getAge()%>
                                                    </label>
                                                </div>
                                                    <%}%>

                                        </fieldset>

                                    </div>
                                </fieldset>

                            </div>
                            <input type="submit" value="Найти">
                        </form>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>
</body>
</html>
