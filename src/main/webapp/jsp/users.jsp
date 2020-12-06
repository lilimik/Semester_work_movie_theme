<%@ page import="ru.itis.models.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Пользователи</title>

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
        function renderTable(users, table) {

            let innerHtml =
                '<thead>\n' +
                '   <tr>\n' +
                '       <th scope="col">ID</th>' +
                '       <th scope="col">Email</th>' +
                '       <th scope="col">FirstName</th>' +
                '       <th scope="col">LastName</th>' +
                '   </tr>' +
                '</thead>' +
                '<tbody>';

            for (let i = 0; i < users.length; i++) {
                innerHtml += '<tr>';
                innerHtml += '  <th scope="row">' + users[i]['id'] + '</th>';
                innerHtml += '  <td>' + users[i]['email'] + '</td>';
                innerHtml += '  <td>' + users[i]['firstName'] + '</td>';
                innerHtml += '  <td>' + users[i]['lastName'] + '</td>';
                innerHtml += '</tr>';
            }

            innerHtml += '</tbody>';
            table.html(innerHtml);

        }

        function saveUser(email, firstName, lastName, password) {

            let data = {
                "email": email,
                "firstName": firstName,
                "lastName": lastName,
                "password": password
            };

            $.ajax({
                type: "POST", // метод запроса
                url: "/users", // url запроса
                data: JSON.stringify(data), // JSON-объект в JSON-строку
                // что происходит, если запрос прошел успешно
                success: function (response) {
                    // рисуем таблицу на основе ответа на запрос
                    renderTable(response, $('#table'))
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
                <div class="container" style="width: 250px">
                    <div class="form-group">
                        <label for="email" class="text-white">Почта:</label>
                        <input type="email" class="form-control" name="email" id="email">
                    </div>
                    <div class="form-group">
                        <label for="firstName" class="text-white">Имя:</label>
                        <input type="text" class="form-control" name="firstName" id="firstName">
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="text-white">Фамилия:</label>
                        <input type="text" class="form-control" name="lastName" id="lastName">
                    </div>
                    <div class="form-group">
                        <label for="password" class="text-white">Пароль:</label>
                        <input type="password" class="form-control" name="password" id="password">
                    </div>
                    <button class="btn btn-primary" onclick="saveUser($('#email').val(),
                                                                  $('#firstName').val(),
                                                                  $('#lastName').val(),
                                                                  $('#password').val())">
                        создать
                    </button>
                </div>
                <br>

                <table id="table" class="text-white">

                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
