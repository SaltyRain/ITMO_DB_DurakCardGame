DELIMITER //
CREATE FUNCTION getPlayerId(userid INT UNSIGNED, deckid INT UNSIGNED) 
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT id_player FROM players WHERE id_user = userid AND id_deck = deckid);
END //