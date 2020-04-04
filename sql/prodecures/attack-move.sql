DELIMITER //
CREATE PROCEDURE attackMove(user_login varchar(50), user_password varchar(255), deckid INT, cardid INT UNSIGNED)
attackmove_label : BEGIN
    DECLARE playerId INT UNSIGNED;

    -- Проверка пароля
    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE attackmove_label;
    END IF;

    SET playerId = getPlayerId(getUserId(user_login), deckid);

    -- Проверяем, является ли текущий игрок атакующим
    IF (playerId <> (SELECT id_attacker FROM Decks WHERE id_deck = deckid)) THEN
        SELECT "NOT YOUR ATTACK TURN";
        LEAVE attackmove_label;
    END IF;

    -- Проверяем, есть ли такая карта в руке атакующего
    IF (NOT EXISTS (SELECT id_card FROM playersCards WHERE id_player = playerId AND id_card = cardid)) THEN
        SELECT "YOU DONT HAVE THIS CARD";
        LEAVE attackmove_label;
    END IF;

    -- Проверяем, есть ли уже атакущая карта на столе
    IF (EXISTS (SELECT * FROM attackingCards WHERE id_deck = deckid)) THEN
        SELECT "THERE IS ATTACKING CARD ALREADY";
        LEAVE attackmove_label;
    END IF;


    -- Добавляем карту на стол в ячейку атакуюшей карты
    INSERT INTO attackingCards(id_card, id_deck) VALUE (cardid, deckid);
    -- Удаляем карту и руки игрока
    DELETE FROM playersCards WHERE id_card = cardid AND id_player = playerId;

    SELECT "ATTACKING CARD INSERTED";
END //