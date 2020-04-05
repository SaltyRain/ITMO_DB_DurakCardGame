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
    if (+playerId === +attackerId && (+currentGameStatus.attackingCard !== 0 && (+currentGameStatus.defendingCard !== 0 || +currentGameStatus.defendingCard === -1))) {
        okButton.removeAttribute("disabled");
    }
    else {
        okButton.setAttribute("disabled", "disabled");
    }
}