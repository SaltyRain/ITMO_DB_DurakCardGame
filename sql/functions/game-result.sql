DELIMITER //
CREATE FUNCTION gameResult(player1 INT UNSIGNED, player2 INT UNSIGNED, deckid INT UNSIGNED)
RETURNS INT 
BEGIN
    -- Если в колоде закончились карты
    IF (NOT EXISTS (SELECT * FROM cardsInDeck WHERE id_deck = deckid)) THEN
        -- Если карты закончились у обоих игроков
        IF ((NOT EXISTS (SELECT * FROM playersCards WHERE id_player = player1)) AND (NOT EXISTS (SELECT * FROM playersCards WHERE id_player = player2))) THEN
            RETURN -1;
        -- Если карты закончились у первого игрока
        ELSEIF (NOT EXISTS (SELECT * FROM playersCards WHERE id_player = player1)) THEN
            RETURN player1;
        -- Если карты закончились у второго игрока
        ELSEIF (NOT EXISTS (SELECT * FROM playersCards WHERE id_player = player2)) THEN
            RETURN player2;
        END IF;
    END IF;
    -- игра не закончилась
    RETURN 0;

END //