DELIMITER //
CREATE PROCEDURE defendMove(user_login varchar(50), user_password varchar(255), deckid INT, attackcard INT UNSIGNED, defendcard INT)
defendmove_label : BEGIN
    DECLARE playerId INT UNSIGNED;
    DECLARE attackCardSuit varchar(6);
    DECLARE defendCardSuit varchar(6);
    -- Проверка пароля
    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE attackmove_label;
    END IF;

    SET playerId = getPlayerId(getUserId(user_login), deckid);

    
    -- Проверяем, есть ли такая карта в руке защищающегося
    IF (NOT EXISTS (SELECT id_card FROM playersCards WHERE id_player = playerId AND id_card = defendcard)) THEN
        SELECT "YOU DONT HAVE THIS CARD";
        LEAVE attackmove_label;
    END IF;

    -- Проверяем, есть ли уже защищающаяся карта на столе
    IF (EXISTS (SELECT * FROM defendingCards WHERE id_deck = deckid)) THEN
        SELECT "THERE IS DEFENDING CARD ALREADY";
        LEAVE attackmove_label;
    END IF;

    -- Если игрок пасует - записываем в defendingCards -1
    IF (defendcard = -1) THEN
        INSERT INTO defendingCards(id_card, id_deck) VALUE (-1, deckid);
    ELSE
        -- Проверяем, может ли игрок отбиться этой картой
        -- Может отбиться, если у него ко
        SET attackCardSuit

END //