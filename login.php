<?php
    session_start();
    function login($user_login, $user_password, $link) {
        $result = mysqli_query($link, 'CALL login("'.$user_login.'","'.$user_password.'");');
        if (!$result) {
            die('Неверный запрос: ' . mysqli_error($link));
        }
        return $result;
    }
    $error = false;
    if (isset($_POST['login-sign-in']) && isset($_POST['pass-sign-in']))
    {
        $link = mysqli_connect('localhost', 'root', '', 'durak');
        if (!$link) {
            die('Ошибка соединения: ' . mysqli_error($link));
        }
        $response = login(htmlspecialchars($_POST['login-sign-in']), htmlspecialchars($_POST['pass-sign-in']), $link);
        $response = mysqli_fetch_array($response, MYSQLI_NUM);

        if($response[0] == "OK")
        {
            $sessVar1 = 'user_login';
            $sessVar2 = 'user_password';

            $_SESSION[$sessVar1] = htmlspecialchars($_POST['login-sign-in']);
            $_SESSION[$sessVar2] = htmlspecialchars($_POST['pass-sign-in']) ;

            // $host = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
            $extra = 'index.php';
            header("Location: http://localhost/durak/$extra");
            exit;
        }
        else {
            $error = true;
        }
    }
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Логин | Карточная игра "ДураК"</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <main>
    <h1 class="page-heading">Карточная игра "ДураК"</h1>
    <section class="sign-in-up-form">
            <form action="login.php" method="post" class="sign-in-up-form"> 
                <h2 class="sign-in-up-form__title">Вход в игру</h2>
                <div class="sign-in-up-form__item">
                    <label for="login-sign-in" class="hidden">Логин: </label>
                    <input type="text"  name="login-sign-in" required>
                </div>

                <div class="sign-in-up-form__item">
                    <label for="pass-sign-in" class="hidden">Пароль: </label>
                    <input type="text"  name="pass-sign-in" required>
                </div>
                
                <p>Еще нет аккаунта? <a href="register.php">Зарегистрируйтесь</a></p>
                <button type="submit" class="sign-in-up-form__button sign-in-up-form__button_log-in">Войти</button>
                <?php echo ($error ? '<div class="error">Login error...</div>' : ''); ?>
            </form>
        </section>
    </main>
</body>
</html>