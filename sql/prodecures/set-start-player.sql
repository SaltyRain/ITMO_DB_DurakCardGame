DELIMITER //
CREATE PROCEDURE setStartPlayer(deckid INT UNSIGNED)
BEGIN
	DECLARE startPlayer INT UNSIGNED DEFAULT 0;
    SET startPlayer = getStartPlayer(deckid);
    UPDATE Decks SET id_attacker = startPlayer WHERE id_deck = deckid;
END //
