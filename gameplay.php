<?php
function getgamestatus($user_login, $user_password, $deckid, $link) {
    $query = 'CALL getGameStatus("'.$user_login.'", "'.$user_password.'", "'.$deckid.'");';
    // $result = mysqli_query($link, $query);
    if ($result = mysqli_query($link, $query)) {
        $resultString = '';
        /* извлечение ассоциативного массива */
        while ($row = mysqli_fetch_assoc($result)) {
            $resultString = $resultString . json_encode($row) . '+';
        }

    }

    /* удаление выборки */
    mysqli_free_result($result);
    return $resultString;
}

function attackmove($user_login, $user_password, $deckid, $cardid, $link) {
    $query = 'CALL attackMove("'.$user_login.'", "'.$user_password.'", "'.$deckid.'", "'. $cardid.'");';
    $result = mysqli_query($link, $query);
    if (!$result) {
        die ('Неверный запрос: ' . mysqli_error($link));
    }
    return $result;
}

function defendmove($user_login, $user_password, $deckid, $attackercardid, $defendercardid, $link) {
    $query = 'CALL defendMove("'.$user_login.'", "'.$user_password.'", "'.$deckid.'", "'. $attackercardid.'", "'. $defendercardid.'");';
    $result = mysqli_query($link, $query);
    if (!$result) {
        die ('Неверный запрос: ' . mysqli_error($link));
    }
    return $result;
}

function moveresult($user_login, $user_password, $attackerid, $defenderid, $deckid, $link) {
    $query = 'CALL moveResult("'.$user_login.'", "'.$user_password.'", "'.$attackerid.'", "'. $defenderid.'", "'. $deckid.'");';
    $result = mysqli_query($link, $query);
    if (!$result) {
        die ('Неверный запрос: ' . mysqli_error($link));
    }
    return $result;
}

if(!isset($_POST['user_login']) && !isset($_POST['user_password']) && !isset($_POST['func']))
{
    die('no data');
}

$link = mysqli_connect('localhost', 'root', '', 'durak');
if (!$link) {
die('Ошибка соединения: ' . mysqli_error($link));
}

$log = htmlspecialchars($_POST['user_login']);
$pswd = htmlspecialchars($_POST['user_password']);
$gameid = htmlspecialchars($_POST['gameid']);
$func = htmlspecialchars($_POST['func']);


switch($func) {
    case 'getgamestatus':
        $resp = getgamestatus($log, $pswd, $gameid, $link);
        die($resp);
    break;
    case 'attackmove':
        $resp = attackmove($log, $pswd, $gameid, htmlspecialchars($_POST['cardId']) , $link);
        $resp = mysqli_fetch_assoc($resp);
        die(json_encode($resp));
    break;
    case 'defendmove':
        $resp = defendmove($log, $pswd, $gameid, htmlspecialchars($_POST['attackCardId']), htmlspecialchars($_POST['defendCardId']), $link);
        $resp = mysqli_fetch_assoc($resp);
        die(json_encode($resp));
    break;
    case 'moveresult':
        $resp = moveresult($log, $pswd, htmlspecialchars($_POST['attackerId']), htmlspecialchars($_POST['defenderId']), $gameid, $link);
        $resp = mysqli_fetch_assoc($resp);
        die(json_encode($resp));
    break;
    default:
    die('wrong request');
    break;
}

?>