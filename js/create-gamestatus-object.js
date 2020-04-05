function createGameStatusObject(array) {
    const gameStatus = {
        attackingCard : array[0].attackingCard,
        defendingCard : array[0].defendingCard,
        deckCardsAmount : array[0].deckCardsAmount,
        trashCardsAmount : array[0].trashCardsAmount,
        oponentCardsAmount : array[0].oponentCardsAmount,
        trumpCard : array[0].trumpCard,
        winnerId : array[0].winnerId,
        attackerId : array[0].attackerId,
        
        myCardsAmount : array.length,

        myCardsSet : getMyCardsSet(array)
    }
    return gameStatus;
}