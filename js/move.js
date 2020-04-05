function chooseMove(usingCard) {
    if (+window.myId === +currentGameStatus.attackerId) {
        attackMove(usingCard);
    }
    else {
        defendMove(usingCard);
    }
}

function attackMove(usingCard) {
    request (
        {
            'user_login' : window.userLogin,
            'user_password' : window.userPassword,
            'gameid' : window.gameId,
            'cardId' : usingCard,
            'func' : 'attackmove'
        },
        'gameplay.php', _attackmove
    )
}

function defendMove(usingCard) {
    request (
        {
            'user_login' : window.userLogin,
            'user_password' : window.userPassword,
            'gameid' : window.gameId,
            'attackCardId' : currentGameStatus.attackingCard,
            'defendCardId' : usingCard,
            'func' : 'defendmove'
        },
        'gameplay.php', _defendmove
    )
}

function moveResult() {
    request (
        {
            'user_login' : window.userLogin,
            'user_password' : window.userPassword,
            'attackerId' : window.myId,
            'defenderId' : window.oponentId,
            'gameid' : window.gameId,
            'func' : 'moveresult'
        },
        'gameplay.php', _moveresult
    )
}
