<%@ page contentType="text/html;charset=UTF-8" %>
<html>

<head>
    <title>Логин</title>

    <link rel="SHORTCUT ICON" href="WebContent/image/main_image.png">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://bootstraptema.ru/plugins/2015/bootstrap3/bootstrap.min.css"/>
    <link rel="stylesheet" href="WebContent/style/authentication.css"/>
    <script src="https://bootstraptema.ru/plugins/jquery/jquery-1.11.3.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2015/b-v3-3-6/bootstrap.min.js"></script>
    <script src="https://bootstraptema.ru/plugins/2016/validator/validator.min.js"></script>

</head>
<body>

<div class="container mt-5">
    <div class="row">

        <div class="col-md-offset-3 col-md-6">
            <form class="form-horizontal pb-1" data-toggle="validator" action="${pageContext.request.contextPath}/signIn" method="post">
                <span class="heading">АВТОРИЗАЦИЯ</span>
                <div class="form-group">
                    <label for="inputEmail"></label><input type="email" name="email" class="form-control" id="inputEmail" placeholder="Почта"
                                                           data-error="Вы не правильно ввели Ваш E-mail" required>
                    <i class="fa fa-envelope-open"></i>
                    <a href="#" class="fa fa-exclamation-circle"></a>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group help">
                    <label for="inputPassword"></label><input type="password" data-toggle="validator" class="form-control"
                                                              name="password" id="inputPassword"
                                                              placeholder="Пароль" required>
                    <i class="fa fa-lock"></i>
                    <a href="#" class="fa fa-exclamation-circle"></a>
                </div>
                <div class="form-group">
                    <div class="main-checkbox">
                        <input type="checkbox" value="none" id="checkbox1" name="check">
                        <label for="checkbox1"></label>
                    </div>
                    <span class="text">Запомнить</span>
                    <button type="submit" class="btn btn-default">ВОЙТИ</button>
                </div>
                <div class="form-group text-center">
                    <a class="text-dark" href="${pageContext.request.contextPath}/signUp"><b>Еще не зарегистрированы?</b></a>
                </div>
            </form>
        </div>

    </div>
</div>

</body>
</html>
