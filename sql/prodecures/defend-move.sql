DELIMITER //
CREATE PROCEDURE defendMove(user_login varchar(50), user_password varchar(255), deckid INT, attacktypecard INT UNSIGNED, defendtypecard INT)
defendmove_label : BEGIN
    DECLARE playerId INT UNSIGNED;

    DECLARE defendCardId INT UNSIGNED;

    DECLARE attackCardSuit varchar(6);
    DECLARE defendCardSuit varchar(6);
    DECLARE gameTrumpSuit varchar(6);

    -- Проверка пароля
    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE defendmove_label;
    END IF;

    SET playerId = getPlayerId(getUserId(user_login), deckid);
    SET defendCardId = getPlayerGameCardFromType(defendtypecard, playerId);

    
    -- Проверяем, есть ли такая карта в руке защищающегося
    IF ((NOT EXISTS (SELECT id_card FROM playersCards WHERE id_player = playerId AND id_card = defendCardId)) AND (defendtypecard <> -1)) THEN
        SELECT "YOU DONT HAVE THIS CARD";
        LEAVE defendmove_label;
    END IF;

    -- Проверяем, есть ли уже защищающаяся карта на столе
    IF (EXISTS (SELECT * FROM defendingCards WHERE id_deck = deckid)) THEN
        SELECT "THERE IS DEFENDING CARD ALREADY";
        LEAVE defendmove_label;
    END IF;

    -- Если игрок пасует - записываем в defendingCards -1
    IF (defendtypecard = -1) THEN
        INSERT INTO defendingCards(id_card, id_deck) VALUE (-1, deckid);
        SELECT "YOU PASSED";
    ELSE
        SET attackCardSuit = getCardSuit(attacktypecard);
        SET defendCardSuit = getCardSuit(defendtypecard);
        SET gameTrumpSuit = (SELECT trump FROM decks WHERE id_deck = deckid);

        -- Проверяем, может ли игрок отбиться этой картой
        IF ((attackCardSuit = gameTrumpSuit AND defendCardSuit = gameTrumpSuit AND defendtypecard > attacktypecard) 
            OR 
            (attackCardSuit <> gameTrumpSuit AND defendCardSuit <> gameTrumpSuit AND defendtypecard > attacktypecard)
            OR 
            (attackCardSuit <> gameTrumpSuit AND defendCardSuit = gameTrumpSuit)
            
            )
        THEN
            -- Игрок может отбиться. Карта кладется на стол
            INSERT INTO defendingCards(id_card, id_deck) VALUE (defendtypecard, deckid);
            -- Удаляем из руки
            DELETE FROM playersCards WHERE id_card = defendCardId AND id_player = playerId;
            SELECT "INSERTING DEFENDING CARD";
        ELSE 
            SELECT "YOU CANT USE THIS CARD";
        END IF;
    END IF;
END //