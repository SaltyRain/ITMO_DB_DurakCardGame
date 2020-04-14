function switchPassButton(playerId, attackerId) {
    const passButton = document.querySelector('#passButton');
    if (+playerId !== +attackerId) {
        passButton.removeAttribute("disabled");
    }
    else {
        passButton.setAttribute("disabled", "disabled");
    }
}

function switchOkButton(playerId, attackerId) {
    const okButton = document.querySelector('#okButton');
    console.log(currentGameStatus.defendingCard);
    if (playerId === attackerId && (currentGameStatus.attackingCard !== 0 && (currentGameStatus.defendingCard !== 0 || currentGameStatus.defendingCard === -1))) {
        console.log('включаю')
        okButton.removeAttribute("disabled");
    }
    else {
        console.log('не включаю')
        okButton.setAttribute("disabled", "disabled");
    }
}

function turnOnOkButton(playerId, attackerId) {
    const okButton = document.querySelector('#okButton');
    if (playerId === attackerId) {
        okButton.removeAttribute("disabled");
    }
    else {
        okButton.setAttribute("disabled", "disabled");
    }
}
