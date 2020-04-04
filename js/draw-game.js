"use strict";

const BACK_CARD = 'back';
const CARD = '__card';

const TABLE = 'table';
const MY_HAND = 'hand';
const OPONENT_HAND = 'oponent-hand';


const ATTACKER_CARD_CONTAINER = 'table-card table__card table__card_attack';
const DEFENDER_CARD_CONTAINER = 'table-card table__card table__card_defend';

const MY_HAND_CARD_CONTAINER = MY_HAND + CARD;
const OPONENT_HAND_CARD_CONTAINER = OPONENT_HAND + CARD;


function drawTableCard(sectionName, containerClassName, cardId) {
    const section = document.querySelector('.' + sectionName);
    // const cardContainer = document.querySelector('.' + containerClassName);
    if (+cardId !== 0)
        insertCard(section, containerClassName, cardId);

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

function insertCard(section, containerClassName, cardId) {
    const cardContainer = document.createElement('div');
    cardContainer.className = containerClassName;

    const card = document.createElement('img');
    card.src = 'img/' + cardId + '.png';
    if (cardId !== BACK_CARD) {
        card.id = cardId;
        card.alt = 'Карта в моей руке ' + cardId;
    }
    else {
        card.alt = 'Карта опонента';
    }

    section.append(cardContainer);
    cardContainer.append(card);
}

function removeCard(containerClassName) {
    document.querySelectorAll('.' + containerClassName + ':last-child')[0].remove();
}


function changeOponentHand(cardsAmount) {
    let currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
    if (currentCardsAmount < cardsAmount) {
        const oponentHandContainer = document.querySelector('.oponent-hand');
        while (currentCardsAmount !== cardsAmount) {
            // insertOponentCard(oponentHandContainer);
            insertCard(oponentHandContainer, '.oponent-hand__card', BACK_CARD);
            currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
        }
    }
    if (currentCardsAmount > cardsAmount) {
        while (currentCardsAmount !== cardsAmount) {
            // removeOponentCard();
            removeCard('.oponent-hand__card');
            currentCardsAmount = document.querySelectorAll('.oponent-hand__card').length;
        }
    }
}

function changeHand(hand, containerClassName, cardsAmount, cardsArray = 0) {
    let currentCardsAmount = document.querySelectorAll(containerClassName).length;
    if (hand === MY_HAND) {
        const myHand = document.querySelector(hand);
        let currentCardsInHandId = [];

        let cardsInHandArray = document.querySelectorAll('.hand__card');
        cardsInHandArray.forEach(function(item) {
            currentCardsInHandId.push(item.children[0].id);
        })
        console.log(currentCardsInHandId);



        
    }
    else {
        if (currentCardsAmount < cardsAmount) {
            const oponentHand = document.querySelector(hand);
            while (currentCardsAmount !== cardsAmount) {
                insertCard(oponentHand, containerClassName, BACK_CARD);
                currentCardsAmount++;
            }
        }
        if (currentCardsAmount < cardsAmount) {
            removeCard(containerClassName);
        }
    }
    // if (currentCardsAmount < cardsAmount)
}







