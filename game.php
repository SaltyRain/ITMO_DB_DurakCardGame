<?php
    session_start();
    $link = mysqli_connect('localhost', 'root', '', 'durak');
    if (!$link) {
    die('Ошибка соединения: ' . mysqli_error($link));
    }

    if(!isset($_SESSION['user_login']) && !isset($_SESSION['user_password']))
    {
        $host = $_SERVER['HTTP_HOST'];
        $uri = rtrim(dirname($_SESSION['PHP_SELF']), '/\\');
        $extra = 'login.php';
        header("Location: http://localhost/durak/$extra");
        exit;
    }

    
    $log = htmlspecialchars($_SESSION['user_login']);
    $pswd = htmlspecialchars($_SESSION['user_password']);
    $gameid = $_GET['gameid'];

    $query = 'CALL getGameStatus("'.$log.'", "'.$pswd.'", "'.$gameid.'");';
    
    if ($result = mysqli_query($link, $query)) {
        $resultString = '';
        /* извлечение ассоциативного массива */
        while ($row = mysqli_fetch_assoc($result)) {
            $resultString = $resultString . json_encode($row) . '+';
        }

    /* удаление выборки */
    mysqli_free_result($result);

    }

    
    /* закрытие соединения */
    mysqli_close($link);

    $link2 = mysqli_connect('localhost', 'root', '', 'durak');
    if (!$link2) {
        die('Ошибка соединения: ' . mysqli_error($link2));
    }

    $query2 = 'CALL getPlayersIdsAndTrumpSuit("'.$log.'", "'.$gameid.'");';

    $result2 = mysqli_query($link2, $query2);
    if (!$result2) {
        die('Неверный запрос: ' . mysqli_error($link2));
    }

    $playersidsandtrumpsuit = mysqli_fetch_array($result2);
    
    $myid = $playersidsandtrumpsuit[0];
    $oponentid = $playersidsandtrumpsuit[1];
    $trumpsuit = $playersidsandtrumpsuit[2];
    
    /* закрытие соединения */
    mysqli_close($link2);

?>


<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>ДураК | Партия</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <header>
    <h1 class="visually-hidden">Карточная игра "ДураК"</h1>
    </header>

    <main>

        <section class="oponent-hand">
            <h2 class="visually-hidden">Рука противника</h2>

        </section>

        <!-- <div class="pass-message" id="hideMe">
            Пас
        </div> -->
        <div class="pass-message-section">

        </div>

        <section class="deck">
            <h2 class="visually-hidden">Колода</h2>
        </section>

        <section class="table">
            <h2 class="visually-hidden">Стол</h2>
        </section>

        <section class="trash">
            <h2 class="visually-hidden">Бита</h2>
        

        </section>

        <section class="hand">
            <h2 class="visually-hidden">Твоя рука</h2>
        </section>

        <section class="game-info">
        
            <span class="playerid"></span>
            <span class="game-info__whoose-turn"></span>

            <button class="game-info__btn btn" type="button" id="passButton" disabled>Беру</button>
            <button class="game-info__btn btn" type="button" id="okButton" disabled>ОК</button>
        </section>


    <script src="js/request.js"></script>
    <script src="js/asyncwaiters.js"></script>
    

    <script src="js/constants.js"></script>

    <script src="js/update-game-status.js"></script>

    <script src="js/insert-remove-card.js"></script>

    <script src="js/draw-game.js"></script>
    <script src="js/handlers.js"></script>

    

    <script src="js/switch-player-buttons.js"></script>
    
    <script src="js/send-gamestatus-request.js"></script>
    <script src="js/get-my-cards-set.js"></script>

    <script src="js/create-gamestatus-object.js"></script>
    <script src="js/show-winner.js"></script>
    <script src="js/move.js"></script>
    <script src="js/show-pass.js"></script>
    <script>
        // Константные значения, изначальный парсинг данных и изначальная отрисовка
        window.myId = <?php echo $myid ?>;
        window.oponentId = <?php echo $oponentid ?>;
        window.trumpSuit = '<?php echo $trumpsuit ?>';
        window.userLogin = '<?php echo $log ?>';
        window.userPassword = '<?php echo $pswd ?>';
        window.gameId = '<?php echo $gameid ?>';

        // Поля массива: 
        // attackingCard - атакующая карта на столе. Если 0, то ее нет
        // defendingCard - защищающаяся карта на  столе. Если 0, то ее нет. Если -1, то игрок пасует
        // deckCardsAmount - кол-во карт в колоде
        // trashCardsAmount - кол-во карт в сбросе
        // myCardsAmount - число карт в моей руке
        // oponentCardsAmount - кол-во карт у противника
        // trumpCard - карта-козырь игры
        // winnerId - победитель игры. Если 0 - игра продолжается
        // attackerId - id атакующего игрока
        // myCardsSet - множество моих карт

        const initalString = '<?php echo $resultString; ?>';
        const initalArray = parseServerData(initalString);


        let currentGameStatus = createGameStatusObject(initalArray);

        
        updateGameStatus(initalString);
        initialDraw();

        console.log(window.myId);
        console.log(currentGameStatus.attackerId);
        switchPassButton(+window.myId, +currentGameStatus.attackerId);
        switchOkButton(+window.myId, +currentGameStatus.attackerId);

        
        sendGameStatusRequest(window.userLogin, window.userPassword, window.gameId);
        

        
    </script>
     <script src="js/event-listeners.js"></script>
     <script src="js/change-game.js"></script>

    </main>
</body>
</html>


