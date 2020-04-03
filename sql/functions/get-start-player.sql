DELIMITER //
CREATE FUNCTION getStartPlayer(deckid int)
RETURNS INT UNSIGNED
BEGIN
    DECLARE startPlayer INT UNSIGNED DEFAULT 0;
    
    DECLARE player1Id INT UNSIGNED DEFAULT 0;
    DECLARE player2Id INT UNSIGNED DEFAULT 0;

    DECLARE player1SmallestTrump INT UNSIGNED DEFAULT 0;
    DECLARE player2SmallestTrump INT UNSIGNED DEFAULT 0;

    DECLARE trump VARCHAR(6);

    SET trump = (SELECT trump FROM Decks WHERE id_deck = deckid);
    SET player1Id = (SELECT MIN(id_player) FROM players WHERE id_deck = deckid);
    SET player2Id = (SELECT MAX(id_player) FROM players WHERE id_deck = deckid);
    
    SET player1SmallestTrump = getPlayerSmallestTrump(player1Id, trump);
    SET player2SmallestTrump = getPlayerSmallestTrump(player2Id, trump);


    IF (player1SmallestTrump IS NULL AND player2SmallestTrump IS NULL) THEN
        IF (RAND() > 0.5) THEN
            SET startPlayer = player1Id;
        ELSE
            SET startPlayer = player2Id;
        END IF;
    ELSE
        IF ((player1SmallestTrump IS NULL) OR (player1SmallestTrump < player2SmallestTrump)) THEN
                SET startPlayer = player2Id;

        ELSEIF ((player2SmallestTrump IS NULL) OR (player1SmallestTrump > player2SmallestTrump)) THEN
            SET startplayer = player1Id;

        END IF;
    END IF;

    RETURN startPlayer;
END //