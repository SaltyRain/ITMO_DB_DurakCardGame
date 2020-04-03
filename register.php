<?php
session_start();
function register($user_login, $user_password, $link) {
    $result = mysqli_query($link, 'CALL InsertUser("'.$user_login.'", "'.$user_password.'");');
    if (!$result) {
        die('Неверный запрос: ' . mysqli_error($link));
    }
    return $result;
}

$done = false;
$error = false;

if (isset($_POST['login-sign-up'])  && isset($_POST['pass-sign-up']))
{
    $link = mysqli_connect('localhost', 'root', '', 'durak');
  if (!$link) {
    die('Ошибка соединения: ' . mysqli_error($link));
  }
  $response = register(htmlspecialchars($_POST['login-sign-up']), htmlspecialchars($_POST['pass-sign-up']), $link);
  $response = mysqli_fetch_array($response, MYSQLI_NUM);
  if($response[0] == "OK")
  {
    $done = true;
  } else {
    $error = true;
  }
}

if($done) {
    $uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
    $extra = 'login.php';
    header("Location: http://localhost/durak/$extra");
    exit;
}


?>




<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Регистрация | Карточная игра "ДураК"</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <main>
        <h1 class="page-heading">Карточная игра "ДураК"</h1>
        <section class="sign-in-up-form">
            <form action="register.php" method="post" class="sign-in-up-form"> 
                <h2 class="sign-in-up-form__title">Регистрация</h2>

                <div class="sign-in-up-form__item">
                    <label for="login-sign-up" class="hidden">Логин: </label>
                    <input type="text"  name="login-sign-up" required>
                </div>


                <div class="sign-in-up-form__item">
                        <label for="pass-sign-up" class="hidden">Пароль: </label>
                        <input type="text"  name="pass-sign-up" required>
                </div>

                
                <button type="submit" class="sign-in-up-form__button sign-in-up-form__button_register ">Зарегистрироваться</button>
            </form>
        </section>

    </main>
</body>
</html>