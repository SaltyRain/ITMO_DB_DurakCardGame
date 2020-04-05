function sendGameStatusRequest(userLogin, userPassword, GameId) {
    setInterval(function() {
        // Проверка для атакующего игрока
        if (+window.myId === +currentGameStatus.attackerId) {
            //Не шлет, если стол пустой или когда есть (защищающаяся карта ИЛИ противник пасанул)
            // +currentGameStatus.attackingCard !== 0 && 
            if ((+currentGameStatus.attackingCard === 0 && +currentGameStatus.defendingCard === 0) || (+currentGameStatus.defendingCard !== 0 || +currentGameStatus.defendingCard === -1)) {
                return; //прекращаем посылать запрос
            }
        }
        else {
            // Проверка для защищающегося игрока 
            // Если на столе есть атакующая карта
            if (+currentGameStatus.attackingCard !== 0 && +currentGameStatus.defendingCard === 0)
                return; //прекращаем посылать запрос
        }
        console.log('Отправка запроса о состоянии игры');
        request(
            {
                'user_login' : userLogin,
                'user_password' : userPassword,
                'gameid' : GameId,
                'func' : 'getgamestatus'
            },
            'gameplay.php', _changegamestatus
        );
    }, 1500);
}