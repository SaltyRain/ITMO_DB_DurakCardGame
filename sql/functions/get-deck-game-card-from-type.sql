DELIMITER //
CREATE FUNCTION getDeckGameCardFromType(typecardid INT UNSIGNED, deckid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cards.id_card FROM cards NATURAL JOIN cardsInDeck WHERE cards.id_typecard = typecardid AND  cardsInDeck.id_deck = deckid);
END //