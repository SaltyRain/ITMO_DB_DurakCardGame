DELIMITER //
CREATE FUNCTION getAttackGameCardFromType(typecardid INT UNSIGNED, deckid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cards.id_card FROM cards NATURAL JOIN attackingCards WHERE cards.id_typecard = typecardid AND  attackingCards.id_deck = deckid);
END //
