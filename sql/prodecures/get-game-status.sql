DELIMITER //
CREATE PROCEDURE getGameStatus(user_login varchar(50), user_password varchar(255), deckid INT UNSIGNED)
getgamestate_label : BEGIN
    DECLARE userId INT UNSIGNED;

    DECLARE playerId INT UNSIGNED;
    DECLARE oponentId INT UNSIGNED;

    DECLARE deckCardsAmount INT UNSIGNED;
    DECLARE oponentCardsAmount INT UNSIGNED;
    DECLARE trashCardsAmount INT UNSIGNED;

    DECLARE attackingCard INT UNSIGNED;
    DECLARE defendingCard INT;
    DECLARE trumpCard INT UNSIGNED;

    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE getgamestate_label;
    END IF;

    SET userId = getUserId(user_login);
    SET playerId = (SELECT id_player FROM players WHERE id_user = userId AND id_deck = deckid);
    SET oponentId = (SELECT id_player FROM players WHERE id_deck = deckid AND id_player <> playerId);

    -- Кол-во карт в колоде, в руке противника и в сбросе
    SET deckCardsAmount = (SELECT COUNT(*) FROM cardsInDeck WHERE id_deck = deckid);
    SET oponentCardsAmount = (SELECT COUNT(*) FROM playersCards WHERE id_player = oponentId);

    SET trashCardsAmount = (36 - deckCardsAmount - oponentCardsAmount -  
                            (SELECT COUNT(*) FROM attackingCards WHERE id_deck = deckid) - 
                            (SELECT COUNT(*) FROM defendingCards WHERE id_deck = deckid) - 
                            (SELECT COUNT(*) FROM playersCards WHERE id_player = playerId));

    -- Карты на столе
    IF (EXISTS (SELECT id_card FROM attackingCards WHERE id_deck = deckid)) THEN
        SET attackingCard = getCardType((SELECT id_card FROM attackingCards WHERE id_deck = deckid));
    ELSE
        SET attackingCard = 0;
    END IF;

    IF (NOT EXISTS (SELECT id_card FROM defendingCards WHERE id_deck = deckid)) THEN
        SET defendingCard = 0;
    ELSEIF ((SELECT id_card FROM defendingCards WHERE id_deck = deckid) IS NULL) THEN
        SET defendingCard = -1;
    ELSE
        SET defendingCard = getCardType((SELECT id_card FROM defendingCards WHERE id_deck = deckid));
    END IF;

    -- Карта козырь
    IF (deckCardsAmount = 0) THEN
        SET trumpCard = 0;
    ELSE 
        SET trumpCard = getCardType((SELECT MAX(id_card) FROM cardsInDeck WHERE id_deck = deckid));
    END IF;

    -- Массив карт игрока
    CREATE TEMPORARY TABLE handCards (
        playerCard INT UNSIGNED
    );

    INSERT INTO handCards SELECT id_typecard FROM cardTypes WHERE id_typecard IN (SELECT id_typecard FROM cards WHERE id_card IN (SELECT id_card FROM playersCards WHERE id_player = playerId));

    SELECT deckCardsAmount, oponentCardsAmount, trashCardsAmount, attackingCard, defendingCard, trumpCard, playerCard FROM handCards;

    DROP TABLE handCards;
END //