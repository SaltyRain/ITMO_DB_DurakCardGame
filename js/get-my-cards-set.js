function getMyCardsSet(array) {
    let myCardsArray = [];
    array.forEach(function(item) {
        myCardsArray.push(item.playerCard);
    })
    return new Set(myCardsArray);
}