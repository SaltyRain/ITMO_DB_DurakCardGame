DELIMITER //
CREATE FUNCTION getGameCardFromType(typecardid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cards.id_card FROM cards NATURAL JOIN cardsInDeck WHERE cards.id_typecard = 23 AND  cardsInDeck.id_deck = 25);
END //