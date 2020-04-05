DELIMITER //
CREATE FUNCTION getPlayerGameCardFromType(typecardid INT UNSIGNED, playerid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cards.id_card FROM cards NATURAL JOIN playersCards WHERE cards.id_typecard = typecardid AND  playersCards.id_player = playerid);
END //
