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
        header("Location: http://localhost/$extra");
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

?>
<!-- Warning: mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, bool given in C:\xampp\htdocs\durak\game.php on line 23 -->


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

        <section class="deck">
            <h2 class="visually-hidden">Колода</h2>

            <div class="table-card deck__back-card"><img src="img/back.png" alt="Колода"></div>
            <div class="table-card deck__kozyr" id="cardDefend"><img src="img/2.png" id="2"></div>
            <div class="deck__card-counter"></div>
        </section>

        <section class="table">
            <h2 class="visually-hidden">Стол</h2>
        </section>

        <section class="trash">
            <h2 class="visually-hidden">Бита</h2>
        
            <div class="table-card trash__back-card" id="trashCard">
                <img src="img/back.png" alt="">
            </div>
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
    <script src="js/handlers.js"></script>
    <script src="js/draw-game.js"></script>
    <script>
        let resultString = '<?php echo $resultString; ?>';
        resultString = resultString.substring(0, resultString.length-1); // убираем + в конце

        let resultRows = resultString.split('+');
        let resultArray = [];
        resultRows.forEach(function(item, i, arr) {
            resultArray.push(JSON.parse(item));
        });
        // Поля массива: 
        // attackingCard - атакующая карта на столе. Если 0, то ее нет
        // defendingCard - защищающаяся карта на  столе. Если 0, то ее нет. Если -1, то игрок пасует
        // deckCardsAmount - кол-во карт в колоде
        // trashCardsAmount - кол-во карт в сбросе
        // oponentCardsAmount - кол-во карт у противника
        // trumpCard - карта-козырь игры
        // playerCard - карты игрока
        console.log(resultArray);
        console.log(resultArray[0].id_playerCard);
        console.log(resultArray[0].oponentCardsAmount);

        let myCardsArray = [];
        resultArray.forEach(function(item) {
            myCardsArray.push(item.playerCard);
        })
        let myCardsSet = new Set(myCardsArray);
        // Изначальная отрисовка страницы
        drawOponentHand(resultArray[0].oponentCardsAmount);
        drawMyHand(myCardsSet);
        drawTableCard(TABLE, ATTACKER_CARD_CONTAINER, resultArray[0].attackingCard);
        drawTableCard(TABLE, DEFENDER_CARD_CONTAINER, resultArray[0].defendingCard);
        // drawOponentHand(resultArray[0].oponentCardsAmount);


        

        
    </script>
    
    </main>
</body>
</html>


