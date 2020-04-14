DELIMITER //
CREATE PROCEDURE attackMove(user_login varchar(50), user_password varchar(255), deckid INT, typecardid INT UNSIGNED)
attackmove_label : BEGIN
    DECLARE playerId INT UNSIGNED;
    DECLARE cardId INT UNSIGNED;
    -- Проверка пароля
    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE attackmove_label;
    END IF;

    SET playerId = getPlayerId(getUserId(user_login), deckid);
    SET cardId = getPlayerGameCardFromType(typecardid, playerId);

    -- Проверяем, является ли текущий игрок атакующим
    IF (playerId <> (SELECT id_attacker FROM decks WHERE id_deck = deckid)) THEN
        SELECT "NOT YOUR ATTACK TURN";
        LEAVE attackmove_label;
    END IF;

    -- Проверяем, есть ли такая карта в руке атакующего
    IF (NOT EXISTS (SELECT id_card FROM playersCards WHERE id_player = playerId AND id_card = cardId)) THEN
        SELECT "YOU DONT HAVE THIS CARD";
        LEAVE attackmove_label;
    END IF;

    -- Проверяем, есть ли уже атакущая карта на столе
    IF (EXISTS (SELECT * FROM attackingCards WHERE id_deck = deckid)) THEN
        SELECT "THERE IS ATTACKING CARD ALREADY";
        LEAVE attackmove_label;
    END IF;



    START TRANSACTION;
        -- Добавляем карту на стол в ячейку атакуюшей карты
        INSERT INTO attackingCards(id_card, id_deck) VALUE (cardId, deckid);
        -- Удаляем карту и руки игрока
        DELETE FROM playersCards WHERE id_card = cardId AND id_player = playerId;
    COMMIT;
    
    SELECT "INSERTING ATTACKING CARD";
END //