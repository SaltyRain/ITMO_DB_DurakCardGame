<?php
    function invite($user_login, $user2_login, $user_password, $link) {
        $result = mysqli_query($link, 'CALL invite("'.$user_login.'", "'.$user2_login.'", "'.$user_password.'");');
        if (!$result) {
          die('Неверный запрос: ' . mysqli_error($link));
        }
        return $result;
    }

    function invitelistener($user_login, $user_password, $link) {
        $result = mysqli_query($link, 'CALL inviteListener("'.$user_login.'", "'.$user_password.'");');
        if (!$result) {
            die('Неверный запрос: ' . mysqli_error($link));
        }
        return $result;
    }

    function waitresponse($user_login, $user2_login, $user_password, $link) {
        $result = mysqli_query($link, 'CALL waitResponse("'.$user_login.'", "'.$user2_login.'", "'.$user_password.'");');
        if (!$result) {
          die('Неверный запрос: ' . mysqli_error($link));
        }
        return $result;
    }

    function creategame($user_login, $user2_login, $user_password, $link) {
        $result = mysqli_query($link, 'CALL createGame("'.$user_login.'", "'.$user2_login.'", "'.$user_password.'");');
        if (!$result) {
          die('Неверный запрос: ' . mysqli_error($link));
        }
        return $result;
      }



    if(!isset($_POST['login']) && !isset($_POST['password']) && !isset($_POST['func']))
    {
        die('no data');
    }
    
    $link = mysqli_connect('localhost', 'root', '', 'durak');
    if (!$link) {
      die('Ошибка соединения: ' . mysqli_error($link));
    }



    $log = htmlspecialchars($_POST['login']);
    $pswd = htmlspecialchars($_POST['password']);
    $func = htmlspecialchars($_POST['func']);

    switch ($func) {
    case 'invite':
        $resp = invite($log, htmlspecialchars($_POST['login2']), $pswd, $link);
        $resp = mysqli_fetch_array($resp, MYSQLI_NUM);
        die($resp[0]);
        break;
    case 'waitresponse':
        $resp = waitresponse($log, htmlspecialchars($_POST['login2']), $pswd, $link);
        $resp = mysqli_fetch_array($resp, MYSQLI_NUM);
        die($resp[0]);
        break;
    case 'invitelistener':
        $resp = invitelistener($log, $pswd, $link);
        $resp = mysqli_fetch_assoc($resp);
        die(json_encode($resp));
        break;
    case 'creategame':
        $resp = creategame($log, htmlspecialchars($_POST['login2']), $pswd, $link);
        $resp = mysqli_fetch_assoc($resp);
        die(json_encode($resp));
        break;
    default:
        die('wrong request');
        break;
    }
?>


