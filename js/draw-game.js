function initialDraw() {
    drawOponentHand(currentGameStatus.oponentCardsAmount);
    drawMyHand(currentGameStatus.myCardsSet);

    drawTableCard(TABLE, ATTACKER_CARD_CONTAINER, currentGameStatus.attackingCard);
    drawTableCard(TABLE, DEFENDER_CARD_CONTAINER, currentGameStatus.defendingCard);
    drawTableCard(DECK, KOZYR_CARD_CONTAINER, currentGameStatus.trumpCard);
    
    drawDeckOrTrash(DECK, DECK_CARD_CONTAINER, currentGameStatus.deckCardsAmount);
    drawDeckOrTrash(TRASH, TRASH_CARD_CONTAINER, currentGameStatus.trashCardsAmount);

    drawPlayerRole(currentGameStatus.attackerId);
    drawCounter(currentGameStatus.deckCardsAmount);

    drawSuit();
}

function drawTableCard(sectionName, containerClassName, cardId) {
    const section = document.querySelector('.' + sectionName);
    if (+cardId !== 0 && +cardId !== -1)
        insertCard(section, containerClassName, cardId);
}

function drawDeckOrTrash(sectionName, containerClassName, cardsAmount) {
    const section = document.querySelector('.' + sectionName);
    if (+cardsAmount > 0)
    insertCard(section, containerClassName, BACK_CARD);
}


function drawOponentHand(cardsAmount) {
    const oponentHand = document.querySelector('.' + OPONENT_HAND);
    for (let i = 0; i < cardsAmount; i++) {
        insertCard(oponentHand, OPONENT_HAND_CARD_CONTAINER, BACK_CARD);
    }
}

function drawMyHand(cardsSet) {
    const myHand = document.querySelector('.' + MY_HAND);
    cardsSet.forEach(function(item) {
        insertCard(myHand, MY_HAND_CARD_CONTAINER, item);
    })
}

function drawCounter(cardsAmount) {
    const section = document.querySelector('.' + DECK);
    const counterContainer = document.createElement('div');
    counterContainer.className = COUNTER_CONTAINER;
    counterContainer.textContent = 'Карт в колоде: ' + cardsAmount;

    section.append(counterContainer);
}

function drawPlayerRole(attackerId) {
    const whooseTurn = document.querySelector('.game-info__whoose-turn');
    if (+window.myId === +attackerId) {
        whooseTurn.textContent = 'Ваш ход';
    }
    else {
        whooseTurn.textContent = 'Ход противника';
    }
}

function drawSuit() {
    if (+currentGameStatus.deckCardsAmount === 0) {
        if ((document.querySelector('.deck__back-card')) === null) {
            const section = document.querySelector('.deck');
            const container = document.createElement('div');
            container.className = 'deck__back-card';
    
            const suit = document.createElement('img');
            suit.src = 'img/' + window.trumpSuit + '.png';
           
        }
        else {
            document.querySelector('.deck__back-card').children[0].src = 'img/' + window.trumpSuit + '.png';
        }
    }
}









