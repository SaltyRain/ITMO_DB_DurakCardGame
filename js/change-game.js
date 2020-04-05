function changeOponentHand(newCardsAmount) {
    let currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
    if (+currentCardsAmount < +newCardsAmount) {
        const oponentHand = document.querySelector('.oponent-hand');
        while (+currentCardsAmount !== +newCardsAmount) {
            // insertOponentCard(oponentHandContainer);
            insertCard(oponentHand, 'oponent-hand__card', BACK_CARD);
            currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
        }
    }
    if (+currentCardsAmount > +newCardsAmount) {
        while (+currentCardsAmount !== +newCardsAmount) {
            // removeOponentCard();
            removeCard('oponent-hand__card');
            currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
        }
    }
}

function changeMyHand(newCardsAmount, newCardsSet) {
    if (+currentGameStatus.myCardsAmount < +newCardsAmount) {
        const myHand = document.querySelector('.hand');
        // Берем элементы, которые отсутствуют в текущем множестве
        let cardsToInsert = new Set([...newCardsSet].filter(x => !currentGameStatus.myCardsSet.has(x)));
        while (+currentGameStatus.myCardsAmount !== +newCardsAmount) {
            cardsToInsert.forEach(function(item) {
                insertCard(myHand, 'hand__card', String(item));
                currentGameStatus.myCardsAmount = document.querySelectorAll('.hand__card').length;
            })
        }
    }
    if (currentGameStatus.myCardsAmount < newCardsAmount) {
        // Берем элементы, которые есть в текущем множестве, которые нужно удалить
        let cardsToRemove = new Set([...currentGameStatus].filter(x=> !newCardsSet.has(x)));
        while (+currentGameStatus.myCardsAmount !== +newCardsAmount) {
            cardsToRemove.forEach(function(item) {
                removeParticularCard(String(item));
            })
        }
    }
    
}

function changeTableCardOrShowPassMessage(sectionName, shortContainerClassName, containerClassName, cardId) {
    const section = document.querySelector('.' + sectionName);
    const classArray = containerClassName.split('.');
    let newClassName = classArray[0] + " " + classArray[1] + " " + classArray[2];
    console.log(newClassName);
    // Если опонент пасует
    if (+cardId === -1) {
        showPass();
    }
    if (+cardId === 0) {
        removeDeckCard(shortContainerClassName);
    }
    if (+cardId > 0) {
        insertCard(section, String(newClassName), String(cardId));
    }
}


function changeCounter(newCardsInDeckAmount) {
    document.querySelector('.deck__card-counter').textContent = 'Карт в колоде:' + newCardsInDeckAmount;
    
}

function changeDeckToSuit() {
    document.querySelector('.deck__kozyr').remove();
    document.querySelector('.deck__back-card').children[0].src = 'img/' + window.trumpSuit + '.png';

}

function changeRole(attackerId) {
    const whooseTurn = document.querySelector('.game-info__whoose-turn');
    if (+window.myId === +attackerId) {
        whooseTurn.textContent = 'Ваш ход';
    }
    else {
        whooseTurn.textContent = 'Ход противника';
    }
}