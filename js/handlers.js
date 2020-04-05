/*___________ invites ____________*/

function _wait(response, obj = null) {
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if(resp_ob.WAITING === 'WAITING')
        return;
    showModal('modal2');
    document.querySelector('#inviter').textContent = resp_ob.login;
}

function _invite(response, obj) {
    console.log(response.responseText);
    if(response.responseText !== "OK")
        return;
    var login2 = document.getElementById('user_login').value;
    document.querySelector('#inviter').textContent = '.';
    showModal('modal1');
    waitresponse(obj['login'], obj['password'], login2);
}

function _waitresp(response, obj = null) {
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if (resp_ob.nextDeck !== 0) {
        window.location.href = "game.php?gameid=" + response.responseText;
    }
}



function _confirm(response, obj) {
    // console.log(response);
    // console.log(obj);
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if (resp_ob.nextDeck !== 0) {
        window.location.href = "game.php?gameid=" + resp_ob.nextDeck;
    }
}


// ------------------------- GAME -----------------------------------

function _changegamestatus(response, obj) {
    const newArray = parseServerData(response.responseText);
    const newGameStatus = createGameStatusObject(newArray);

    let flag = false;

    // Изменение кол-ва карт в руке противника
    if (+currentGameStatus.oponentCardsAmount !== +newGameStatus.oponentCardsAmount) {
        changeOponentHand(+newGameStatus.oponentCardsAmount);
        console.log('Изменение кол-ва карт в руке противника');
        flag = true;
    }

    // Изменение моей руки
    if (+currentGameStatus.myCardsAmount !== +newGameStatus.myCardsAmount) {
        changeMyHand(+newGameStatus.myCardsAmount, +newGameStatus.myCardsSet);
        console.log('Изменение моей руки');
        flag = true;
    }

    // Изменение атакующей карты
    if (+currentGameStatus.attackingCard !== +newGameStatus.attackingCard) {
        changeTableCardOrShowPassMessage('table', 'table__card_attack', 'table-card.table__card.table__card_attack', +newGameStatus.attackingCard);
        console.log('Изменение атакующей карты');
        flag = true;
    }

    // Изменение защищающейся карты
    if (+currentGameStatus.defendingCard !== +newGameStatus.defendingCard) {
        changeTableCardOrShowPassMessage('table', 'table__card_defend', 'table-card.table__card.table__card_defend', +newGameStatus.defendingCard);
        console.log('Изменение защищающейся карты');
        flag = true;
    }

    // Колода закончилась. Убрать колоду и оставить только масть
    if (+newGameStatus.deckCardsAmount === 0) {
        changeDeckToSuit();
        console.log('Колода закончилась. Убрать колоду и оставить только масть');
        flag = true;
    }

    // Изменение счетчика карт
    if (+currentGameStatus.deckCardsAmount !== +newGameStatus.deckCardsAmount) {
        changeCounter(+newGameStatus.deckCardsAmount);
        console.log('Изменение счетчика карт');
        flag = true;
    }

    // Добавление биты, если она появилась 
    if ((+currentGameStatus.trashCardsAmount !== +newGameStatus.trashCardsAmount) && (+currentGameStatus.trashCardsAmount === 0) ) {
        drawDeckOrTrash(TRASH, 'trash__back-card', +newGameStatus.trashCardsAmount);
        console.log('Добавление биты, если она появилась');
        flag = true;
    }

    // Изменение сообщения о ходе
    changeRole(+newGameStatus.attackerId);

    // Переключение кнопки ок
    if (((+currentGameStatus.attackingCard !== +newGameStatus.attackingCard) || (+currentGameStatus.defendingCard !== +newGameStatus.defendingCard)) && (+newGameStatus.attackingCard !== 0) && (+newGameStatus.defendingCard !== 0)) {
        console.log('Переключение кнопки ок');
        switchOkButton(+window.myId, +currentGameStatus.attackerId);
    }

    // Сообщение о победителе
    if (+currentGameStatus.winnerId !== +newGameStatus.winnerId) {
        showWinner(+newGameStatus.winnerId);
        return;
    }

    // изменяем состояние игры
    if (flag === true) {
        console.log('Меняю состояние игры');
        console.log(currentGameStatus);
        window.currentGameStatus = updateGameStatus(response.responseText);
    }
}

function _attackmove(response, obj) {
    console.log('_attackmove');
    // console.log(response);
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    console.log(obj);
    console.log(obj['cardId']);
    if (("INCORRECT PSWD" in resp_ob) || ("NOT YOUR ATTACK TURN" in resp_ob) || ("YOU DONT HAVE THIS CARD" in resp_ob) || ("THERE IS ATTACKING CARD ALREADY" in resp_ob))
        return;
    if (("INSERTING ATTACKING CARD" in resp_ob)) {
        // убираем карту из руки и вставляем ее на стол
        removeParticularCard(obj['cardId']);
        insertCard(document.querySelector('.table'), ATTACKER_CARD_CONTAINER, obj['cardid']);

        currentGameStatus.myCardsSet.delete(obj['cardid']);
        currentGameStatus.attackingCard = obj['cardid'];
    }
}

function _defendmove(response, obj) {
    console.log('_defendmove');
    let resp_ob = JSON.parse(response.responseText);
    if (("INCORRECT PSWD" in resp_ob)  || ("YOU DONT HAVE THIS CARD" in resp_ob) || ("THERE IS DEFENDING CARD ALREADY" in resp_ob) || ("YOU CANT USE THIS CARD" in resp_ob))
        return;
    if (("INSERTING DEFENDING CARD" in resp_ob)) {
        // убираем карту из руки и вставляем ее на стол
        console.log('убираем карту из руки и вставляем ее на стол');
        removeParticularCard(obj['defendCardId']);
        insertCard(document.querySelector('.table'), DEFENDER_CARD_CONTAINER, obj['defendCardId']);

        currentGameStatus.myCardsSet.delete(obj['defendCardId']);
        currentGameStatus.defendingCard = obj['defendCardId'];
    }
    if (("YOU PASSED" in resp_ob)) {
        showPass();
        currentGameStatus.defendingCard = -1;


    }
}

function _moveresult(response, obj) {
    console.log('_moveresult');
    console.log(response);
    let resp_ob = JSON.parse(response.responseText);
    console.log(resp_ob);
}