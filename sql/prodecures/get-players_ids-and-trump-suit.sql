DELIMITER //
CREATE PROCEDURE getPlayersIdsAndTrumpSuit(user_login varchar(50), deckid INT UNSIGNED)
BEGIN
    DECLARE myId INT UNSIGNED;
    DECLARE oponentId INT UNSIGNED;
    DECLARE trumpSuit varchar(6);

    SET myId = getPlayerId(getUserId(user_login), deckid);
    SET oponentId = (SELECT id_player FROM players WHERE id_deck = deckid AND id_player <> myId);
    SET trumpSuit = (SELECT trump FROM decks WHERE id_deck = deckid);

    SELECT myId, oponentId, trumpSuit;
END //
