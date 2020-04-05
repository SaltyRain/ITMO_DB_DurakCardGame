function insertCard(section, containerClassName, cardId) {
    const cardContainer = document.createElement('div');
    cardContainer.className = containerClassName;

    const card = document.createElement('img');
    card.src = 'img/' + cardId + '.png';
    if (cardId !== 'back') {
        card.id = cardId;
        // card.alt = 'Карта в моей руке ' + cardId;
    }
    // else {
    //     card.alt = 'Карта опонента';
    // }

    section.append(cardContainer);
    cardContainer.append(card);
}

function removeCard(containerClassName) {
    console.log(containerClassName);
    document.querySelectorAll('.' + containerClassName + ':last-child')[0].remove();
}

function removeDeckCard(containerClassName) {
    console.log(containerClassName);
    document.querySelectorAll('.' + containerClassName)[0].remove();
}

function removeParticularCard(cardId) {
    console.log(cardId);
    console.log(String(cardId));
    document.getElementById(String(cardId)).parentNode.remove();
}