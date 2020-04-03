<?php
session_start();

if(!isset($_SESSION['user_login']) && !isset($_SESSION['user_password']))
{
  $host  = $_SERVER['HTTP_HOST'];
  $uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
  $extra = 'login.php';
  header("Location: http://localhost/durak/$extra");
  exit;
}
$link = mysqli_connect('localhost', 'root', '', 'durak');
if (!$link) {
  die('Ошибка соединения: ' . mysqli_error($link));
}

$pswd = $_SESSION['user_password'];
$log = $_SESSION['user_login'];

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Главное меню | Карточная игра "ДураК"</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <main>
        <h1 class="page-heading">Главное меню</h1>
        <h2 class="page-heading"><?php echo $log?></h2>
        <section class="invite-user">
            <form action="" class="invite-user__form" onsubmit="return false">
                <label for="invited-user" class="hidden">Введите имя пользователя, с которым хотите сыграть</label>
                <input type="text"  name="invited-user" id="user_login" required>
                <button class="button" id="inv_btn" type="submit">Пригласить</button>
            </form>
        </section>

    </main>

    <div class="modal" id="modal1">
        <div class="modal-body">
            <p>Ожидание подтверждения противника...</p>
        </div>
    </div>
    <div class="modal" id="modal2">
        <div class="modal-body">
            <p>Вас пригласил пользователь <b><span id="inviter"></span></b></p>
            <button class="button" id="confirm_invite" type="button">Подтвердить</button>
        </div>
    </div>
    <div class="modal-overlay"></div>
    
    <script src="js/request.js"></script>

    <script src="js/invite.js"></script>
    <script src="js/confirm.js"></script>

    <script src="js/asyncwaiters.js"></script>
    <script src="js/handlers.js"></script>

    <script src="js/modal.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function(event) {
        let login = '<?php echo $log; ?>';
        let password = '<?php echo $pswd; ?>';
        document.querySelector('#confirm_invite').addEventListener('click', function() {
            confirm(login, password);
        });
        document.querySelector('#inv_btn').addEventListener('click', function() {
            invite(login, password)
        });
        waitinvite(login, password);
    });
    </script>

</body>
</html>