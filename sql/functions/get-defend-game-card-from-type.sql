DELIMITER //
CREATE FUNCTION getDefendGameCardFromType(typecardid INT UNSIGNED, deckid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cards.id_card FROM cards NATURAL JOIN defendingCards WHERE cards.id_typecard = typecardid AND  defendingCards.id_deck = deckid);
END //
