function parseServerData(parsingString) {
    parsingString = parsingString.substring(0, parsingString.length-1); // убираем + в конце

    let resultRows = parsingString.split('+');
    let resultArray = [];
    resultRows.forEach(function(item) {
        resultArray.push(JSON.parse(item));
    });

    return resultArray;
}

function updateGameStatus(resultString) {

    let newGameStatusArray = [];
    newGameStatusArray = parseServerData(resultString);

    currentGameStatus.attackingCard = newGameStatusArray[0].attackingCard;
    currentGameStatus.defendingCard =  newGameStatusArray[0].defendingCard;
    currentGameStatus.deckCardsAmount = newGameStatusArray[0].deckCardsAmount;
    currentGameStatus.trashCardsAmount = newGameStatusArray[0].trashCardsAmount;
    currentGameStatus.oponentCardsAmount = newGameStatusArray[0].oponentCardsAmount;
    currentGameStatus.trumpCard = newGameStatusArray[0].trumpCard;
    currentGameStatus.winnerId = newGameStatusArray[0].winnerId;
    currentGameStatus.attackerId = newGameStatusArray[0].attackerId;
    
    currentGameStatus.myCardsAmount = newGameStatusArray.length; 

    currentGameStatus.myCardsSet = getMyCardsSet(newGameStatusArray);
}

