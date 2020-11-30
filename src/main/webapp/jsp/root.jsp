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
    <link rel="stylesheet" href="WebContent/style/root.css">
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    List<Film> horrorFilms = (List<Film>) request.getAttribute("horrorFilms");
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
                <form class="form-inline my-2 my-lg-0 flex-end">
                    <input class="form-control mr-sm-2" type="search" placeholder="Фильмы, персоны" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Найти</button>
                </form>
            </div>
        </div>
    </nav>
</div>

<div class="content">
    <div class="row-12 ">
        <div class="col-md-9">


            <div class="genres">
                <h3 class="text-light text-center" id="for_carouselExampleFade1"><a class="none_link_line"
                                                                                    href="#"><b>Хорроры</b></a>
                </h3>
            </div>


            <div id="carouselExampleFade1" class="carousel slide pb-0 pt-0 row"
                 data-ride="carousel">

                <a class="carousel-control-prev col-md-1" href="#carouselExampleFade1" role="button"
                   data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only bg-link-carousel">Previous</span>
                </a>

                <div class="carousel-inner col-md-10">

                    <%
                        int num = 0;
                        for (int i = 0; i < horrorFilms.size(); i++) {
                            if (num == 0) {
                                if (i == 0) {
                    %>
                    <div class="carousel-item active">
                        <div class="container text-center ">

                            <div class="text-center pl-0 pr-0 container d-flex flex-row ">
                                <%
                                } else {%>
                                <div class="carousel-item">
                                    <div class="container text-center ">

                                        <div class="text-center pl-0 pr-0 container d-flex flex-row ">
                                            <%
                                                    }
                                                }
                                            %>

                                            <% if (num < 3) {%>
                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src=
                                                                 "https://sun9-67.userapi.com/slCzrgrN0oMdA4Y9IgRpI-ojwHdtxqUNbiONIw/9NHjPDiI7zA.jpg"
                                                         class="card-img-top" alt="Red roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1"><%=horrorFilms.get(i).getTitle()%>
                                                        </h5>
                                                        <div class="text-center">
                                                            <small><b> Год:</b><%=horrorFilms.get(i).getYear()%>
                                                            </small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2"><%=horrorFilms.get(i).getDescription()%>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%
                                                num++;
                                                if (num == 3 || i == horrorFilms.size() - 1) {%>
                                        </div>
                                    </div>
                                </div>
                                <%
                                            num = 0;
                                        }
                                    }
                                %>


                                <%}%>

                            </div>
                            <a class="carousel-control-next col-md-1" href="#carouselExampleFade1" role="button"
                               data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>


                        <div class="pb-3">
                            <h3 class="text-light text-center" id="for_carouselExampleFade2"><a class="none_link_line"
                                                                                                href="flowers.html">Цветы</a>
                            </h3>
                        </div>


                        <div id="carouselExampleFade2" class="carousel slide pb-0 pt-0 row"
                             data-ride="carousel">

                            <a class="carousel-control-prev col-md-1" href="#carouselExampleFade2" role="button"
                               data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>

                            <div class="carousel-inner col-md-10">

                                <div class="carousel-item active">
                                    <div class="container text-center ">


                                        <div class="text-center pl-0 pr-0 container d-flex flex-row ">


                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-27.userapi.com/pmJtNFhMWpyQPqgzxOnb4el1FwgKkr_thn_Clg/VCO4M19YC7s.jpg"
                                                         class="card-img-top" alt="Red roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Красные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 60см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 60 см имеет длину стебля от 50
                                                                до 60
                                                                см.
                                                                Красные
                                                                розы
                                                                –
                                                                воплощение любви и душевного притяжения, подаренные
                                                                любимому
                                                                человеку, розы найдут путь в его сердце и поселят там
                                                                счастье и
                                                                радость</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-73.userapi.com/Uqr3kz04xgcTV1RyFlZRTfFW_IVxgC9kJR8V3g/zSrapdYEcf4.jpg"
                                                         class="card-img-top" alt="Red roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Красные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 70см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 70 см имеет длину стебля от 60
                                                                до 70
                                                                см.
                                                                Красные
                                                                розы
                                                                –
                                                                воплощение любви и душевного притяжения, подаренные
                                                                любимому
                                                                человеку, розы найдут путь в его сердце и поселят там
                                                                счастье и
                                                                радость</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-3.userapi.com/-0haqms3i_sMnzg2QTlHh4u7AEIIrfaqrYddHw/knsaZsXH6S4.jpg"
                                                         class="card-img-top" alt="Red roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Красные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 80см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 80 см имеет длину стебля от 70
                                                                до 80
                                                                см.
                                                                Красные
                                                                розы
                                                                –
                                                                воплощение любви и душевного притяжения, подаренные
                                                                любимому
                                                                человеку, розы найдут путь в его сердце и поселят там
                                                                счастье и
                                                                радость</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="carousel-item">
                                    <div class="container text-center">

                                        <div class="text-center pl-0 pr-0 container d-flex flex-row ">

                                            <div class="block col-md-6 col-xl-3">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-24.userapi.com/WyCu-pDo5DQ__m9RCd3htb29SRVYYdn-MzcsXA/SHDoGByLsaU.jpg"
                                                         class="card-img-top" alt="Black roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Черные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 60см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 60 см имеет длину стебля от 50
                                                                до 60
                                                                см.
                                                                Черные
                                                                розы -
                                                                брутальные и эпатажные, будто созданы для того, чтобы
                                                                подчеркнуть необычность момента дарения. Этот загадочный
                                                                цветок
                                                                воспринимается
                                                                по-разному</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-63.userapi.com/iI995UnSwRY5eIaRD46dDsF93Pvf9HQ83AYdmg/a2Sm7IknmNQ.jpg"
                                                         class="card-img-top" alt="Black roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Черные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 70см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 70 см имеет длину стебля от 60
                                                                до 70
                                                                см.
                                                                Черные
                                                                розы -
                                                                брутальные и эпатажные, будто созданы для того, чтобы
                                                                подчеркнуть необычность момента дарения. Этот загадочный
                                                                цветок
                                                                воспринимается
                                                                по-разному</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-2.userapi.com/zunN1CEm6tQPQ5d_myIh6MBs62Pe9tTuLU0ZWg/aAAITB0q3Os.jpg"
                                                         class="card-img-top" alt="Black roses">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">Черные розы</h5>
                                                        <div class="text-center">
                                                            <small><b>Длина стебля:</b> 80см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Роза 80 см имеет длину стебля от 70
                                                                до 80
                                                                см.
                                                                Черные
                                                                розы -
                                                                брутальные и эпатажные, будто созданы для того, чтобы
                                                                подчеркнуть необычность момента дарения. Этот загадочный
                                                                цветок
                                                                воспринимается
                                                                по-разному</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                            <a class="carousel-control-next col-md-1" href="#carouselExampleFade2" role="button"
                               data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>


                        <div class="pb-3">
                            <h3 class="text-light text-center" id="for_carouselExampleFade3"><a class="none_link_line"
                                                                                                href="pots.html">Горшки</a>
                            </h3>
                        </div>


                        <div id="carouselExampleFade3" class="carousel mb-5 slide pb-0 pt-0 row"
                             data-ride="carousel">

                            <a class="carousel-control-prev col-md-1" href="#carouselExampleFade3" role="button"
                               data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>

                            <div class="carousel-inner col-md-10">

                                <div class="carousel-item active">
                                    <div class="container text-center ">


                                        <div class="text-center pl-0 pr-0 container d-flex flex-row ">


                                            <div class="block col-md-6 col-xl-3 text-center ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-2.userapi.com/y6Qf5gWXa9fbhc4ZMFmjlm1pjGrB1fX6tdLBLA/CTVYhkkPKHc.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Стандарт</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 17см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Когда хочется, чтобы горшок был
                                                                просто
                                                                горшком,
                                                                или
                                                                Вам
                                                                трудно подобрать для любимого цветка нужный по форме
                                                                вариант -
                                                                терракотовый
                                                                горшок будет очень кстати. Это лучшее решение для того,
                                                                чтобы
                                                                подчеркнуть
                                                                красоту самого растения, к тому же горшок впишется в
                                                                любой
                                                                интерьер.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-64.userapi.com/AalC2h7WEbK5DPiqqswynSQVGGNv3Vw0XTNM9A/gpI5wp4Z7H4.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0 row-md-12">
                                                        <h5 class="card-title pt-1 mb-1">горшок Бордатто</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 14см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Горшок классической формы с
                                                                обрамлённым
                                                                небольшим
                                                                округлым
                                                                бортиком краем.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-68.userapi.com/OKq34qprUG-NXHadHpRsOQ59zF0a4HWs8h1mwQ/Sb2I1YXaYcU.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Циотолла</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 15см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Цветочная керамическая чаша
                                                                терракотового
                                                                цвета
                                                                прекрасно
                                                                подходит для цветов и вьющихся растений. Форма чаши
                                                                подойдёт для
                                                                создания
                                                                цветочных композиций, в т.ч. и из суккулентов.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="carousel-item">
                                    <div class="container text-center">

                                        <div class="text-center pl-0 pr-0 container d-flex flex-row">

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-68.userapi.com/OKq34qprUG-NXHadHpRsOQ59zF0a4HWs8h1mwQ/Sb2I1YXaYcU.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Циотолла</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 19см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Цветочная керамическая чаша
                                                                терракотового
                                                                цвета
                                                                прекрасно
                                                                подходит для цветов и вьющихся растений. Форма чаши
                                                                подойдёт для
                                                                создания
                                                                цветочных композиций, в т.ч. и из суккулентов.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-2.userapi.com/y6Qf5gWXa9fbhc4ZMFmjlm1pjGrB1fX6tdLBLA/CTVYhkkPKHc.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Стандарт</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 35см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Когда хочется, чтобы горшок был
                                                                просто
                                                                горшком,
                                                                или
                                                                Вам
                                                                трудно подобрать для любимого цветка нужный по форме
                                                                вариант -
                                                                терракотовый
                                                                горшок будет очень кстати. Это лучшее решение для того,
                                                                чтобы
                                                                подчеркнуть
                                                                красоту самого растения, к тому же горшок впишется в
                                                                любой
                                                                интерьер.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-64.userapi.com/AalC2h7WEbK5DPiqqswynSQVGGNv3Vw0XTNM9A/gpI5wp4Z7H4.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0 row-md-12">
                                                        <h5 class="card-title pt-1 mb-1">горшок Бордатто</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 20см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Горшок классической формы с
                                                                обрамлённым
                                                                небольшим
                                                                округлым
                                                                бортиком краем.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="carousel-item">
                                    <div class="container text-center">

                                        <div class="text-center pl-0 pr-0 container d-flex flex-row ">

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow" style="width: auto">
                                                    <img src="https://sun9-64.userapi.com/AalC2h7WEbK5DPiqqswynSQVGGNv3Vw0XTNM9A/gpI5wp4Z7H4.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0 row-md-12">
                                                        <h5 class="card-title pt-1 mb-1">горшок Бордатто</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 30см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Горшок классической формы с
                                                                обрамлённым
                                                                небольшим
                                                                округлым
                                                                бортиком краем.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-68.userapi.com/OKq34qprUG-NXHadHpRsOQ59zF0a4HWs8h1mwQ/Sb2I1YXaYcU.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Циотолла</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 28см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Цветочная керамическая чаша
                                                                терракотового
                                                                цвета
                                                                прекрасно
                                                                подходит для цветов и вьющихся растений. Форма чаши
                                                                подойдёт для
                                                                создания
                                                                цветочных композиций, в т.ч. и из суккулентов.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="block col-md-6 col-xl-3 ">
                                                <div class="card shadow " style="width: auto">
                                                    <img src="https://sun9-2.userapi.com/y6Qf5gWXa9fbhc4ZMFmjlm1pjGrB1fX6tdLBLA/CTVYhkkPKHc.jpg"
                                                         class="card-img-top" alt="pots">
                                                    <div class="card-body p-0">
                                                        <h5 class="card-title pt-1 mb-1">горшок Стандарт</h5>
                                                        <div class="text-center">
                                                            <small><b>Диаметр:</b> 23см</small>
                                                        </div>
                                                        <div class="scroll">
                                                            <p class="card-text p-2">Когда хочется, чтобы горшок был
                                                                просто
                                                                горшком,
                                                                или
                                                                Вам
                                                                трудно подобрать для любимого цветка нужный по форме
                                                                вариант -
                                                                терракотовый
                                                                горшок будет очень кстати. Это лучшее решение для того,
                                                                чтобы
                                                                подчеркнуть
                                                                красоту самого растения, к тому же горшок впишется в
                                                                любой
                                                                интерьер.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>


                            </div>

                            <a class="carousel-control-next col-md-1" href="#carouselExampleFade3" role="button"
                               data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>


                    <div class="col-md-3 text-center position-fixed second_div border-left border-dark pad_div2"
                         style="background-color: white; height: 100%">

                        <nav id="navbar-example2" class="navbar navbar-dark" style="background-color: white;">

                            <ul class="nav nav-tabs flex-column text-center pt-2">
                                <li class="nav-item">
                                    <a class="nav-link" href="#for_carouselExampleFade1">@Букеты</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#for_carouselExampleFade2">@Цветы</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#for_carouselExampleFade3">@Горшки</a>
                                </li>
                            </ul>
                        </nav>


                        <legend class="mb-0"><b>Фильтр</b></legend>

                        <ul class="nav nav-tabs nav-fill" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link" id="genre" data-toggle="tab" href="#home" role="tab"
                                   aria-controls="home" aria-selected="true">Жанр</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="countries" data-toggle="tab" href="#profile" role="tab"
                                   aria-controls="profile" aria-selected="false">Страна</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="year" data-toggle="tab" href="#contact" role="tab"
                                   aria-controls="contact" aria-selected="false">Год</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="restriction" data-toggle="tab" href="#contact" role="tab"
                                   aria-controls="contact" aria-selected="false">Ограничение</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="genre">

                                <form>
                                    <div class="scroll pl-0" style="width: 105%; height: 380px">

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-10 text-center"><b>Кол-во цветов:</b></h4>
                                                </div>

                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="kol-vo_5"
                                                           value="5">
                                                    <label class="form-check-label col-md-6" for="kol-vo_5">
                                                        5 шт
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="kol-vo_15"
                                                           value="15">
                                                    <label class="form-check-label col-md-6" for="kol-vo_15">
                                                        15 шт
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="kol-vo_25"
                                                           value="25">
                                                    <label class="form-check-label col-md-6" for="kol-vo_25">
                                                        25 шт
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="kol-vo_51"
                                                           value="51">
                                                    <label class="form-check-label col-md-6" for="kol-vo_51">
                                                        51 шт
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="kol-vo_101"
                                                           value="101">
                                                    <label class="form-check-label col-md-6" for="kol-vo_101">
                                                        101 шт
                                                    </label>
                                                </div>

                                            </div>
                                        </fieldset>

                                    </div>
                                </form>


                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="countries">

                                <form>
                                    <div class="scroll pl-0" style="width: 105%; height: 380px">

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-10 text-center"><b>Длина стебля:</b></h4>
                                                </div>

                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="dl_st_60"
                                                           value="60">
                                                    <label class="form-check-label col-md-6" for="dl_st_60">
                                                        60 см
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="dl_st_70"
                                                           value="70">
                                                    <label class="form-check-label col-md-6" for="dl_st_70">
                                                        70 см
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="dl_st_80"
                                                           value="80">
                                                    <label class="form-check-label col-md-6" for="dl_st_80">
                                                        80 см
                                                    </label>
                                                </div>

                                            </div>
                                        </fieldset>

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-5 text-center"><b>цвет:</b></h4>
                                                </div>

                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="red"
                                                           value="red">
                                                    <label class="form-check-label col-md-6" for="red">
                                                        Красный
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="black"
                                                           value="black">
                                                    <label class="form-check-label col-md-6" for="black">
                                                        Черный
                                                    </label>
                                                </div>


                                            </div>
                                        </fieldset>

                                    </div>
                                </form>

                            </div>
                            <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="restriction">

                                <form>
                                    <div class="scroll pl-0" style="width: 105%; height: 380px">

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-5 text-center"><b>цвет:</b></h4>
                                                </div>

                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="terracotta"
                                                           value="terracotta">
                                                    <label class="form-check-label col-md-6" for="terracotta">
                                                        Терракотовый
                                                    </label>
                                                </div>

                                            </div>
                                        </fieldset>

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-10 text-center"><b>Материал:</b></h4>
                                                </div>

                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="ceramics"
                                                           value="керимика">
                                                    <label class="form-check-label col-md-6" for="ceramics">
                                                        Керамика
                                                    </label>
                                                </div>
                                                <div class="form-check col-md-12 row">
                                                    <input class="form-check-input col-md-6" type="checkbox"
                                                           name="gridRadios"
                                                           id="clay"
                                                           value="глина">
                                                    <label class="form-check-label col-md-6" for="clay">
                                                        Глина
                                                    </label>
                                                </div>

                                            </div>
                                        </fieldset>

                                        <fieldset class="form-group pt-3">
                                            <div class="row text-left">

                                                <div class="col-form-label col-md-12 pt-0">
                                                    <h4 class=" col-md-10 text-center"><b>диаметр:</b></h4>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_14"
                                                               value="14">
                                                        <label class="form-check-label col-md-8" for="dl_14">
                                                            14 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_15"
                                                               value="15">
                                                        <label class="form-check-label col-md-8" for="dl_15">
                                                            15 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_17"
                                                               value="17">
                                                        <label class="form-check-label col-md-8" for="dl_17">
                                                            17 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_19"
                                                               value="19">
                                                        <label class="form-check-label col-md-8" for="dl_19">
                                                            19 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_20"
                                                               value="20">
                                                        <label class="form-check-label col-md-8" for="dl_20">
                                                            20 см
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_23"
                                                               value="23">
                                                        <label class="form-check-label col-md-8" for="dl_23">
                                                            23 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_28"
                                                               value="28">
                                                        <label class="form-check-label col-md-8" for="dl_28">
                                                            28 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_30"
                                                               value="30">
                                                        <label class="form-check-label col-md-8" for="dl_30">
                                                            30 см
                                                        </label>
                                                    </div>
                                                    <div class="form-check col-md-12 row">
                                                        <input class="form-check-input col-md-4" type="checkbox"
                                                               name="gridRadios"
                                                               id="dl_35"
                                                               value="35">
                                                        <label class="form-check-label col-md-8" for="dl_35">
                                                            35 см
                                                        </label>
                                                    </div>
                                                </div>

                                            </div>
                                        </fieldset>

                                    </div>
                                </form>

                            </div>
                        </div>

                    </div>


                </div>
            </div>
</body>
</html>
