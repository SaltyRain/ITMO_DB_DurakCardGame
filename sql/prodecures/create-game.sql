DELIMITER //
CREATE PROCEDURE createGame(user_login varchar(50), user2_login varchar(50), user_password varchar(255))
creategame_label : BEGIN
    DECLARE nextDeck INT UNSIGNED DEFAULT 0;
    DECLARE userId INT UNSIGNED DEFAULT 0;
    DECLARE userId2 INT UNSIGNED DEFAULT 0;
    -- DECLARE deckTrump VARCHAR(6);

    IF (user_login = user2_login) THEN
        SELECT "GAME WITH YOURSELF!";
        LEAVE creategame_label;
    END IF;

    SET userId2 = getUserId(user2_login);
    IF (userId2 IS NULL) THEN
        SELECT "userId2 IS NULL";
        LEAVE creategame_label;
    END IF;

    IF(NOT checkPassword(user_login, user_password))
    THEN
        SELECT "INCORRECT PSWD";
        LEAVE creategame_label;
    END IF;

    SET userId = getUserId(user_login);

     -- Поиск игроков в инвайтах
    IF(NOT EXISTS (SELECT 1 FROM invites WHERE id_inviting = userId AND id_invited = userId2 ))
    THEN
        SELECT "NOT INVITED";
        LEAVE creategame_label;
    END IF;


    SET nextDeck = (SELECT 1 + (SELECT MAX(id_deck) FROM decks));
    -- Добавление колоду
    INSERT INTO decks VALUES(nextDeck, NULL, NULL, NULL); 

    -- Добавление игроков
    INSERT INTO players VALUES(NULL, userId, (SELECT MAX(id_deck) FROM decks));
	INSERT INTO players VALUES(NULL, userId2, (SELECT MAX(id_deck) FROM decks));

    UPDATE invites SET confirm = TRUE WHERE id_inviting = userId2 AND id_invited = userId;

    -- Перемешивание колоды
    CALL shuffleDeck(nextDeck);

    -- сохранение значения козыря
    -- SET deckTrump = getDeckTrump(nextDeck);
    UPDATE decks SET trump = getDeckTrump(nextDeck) WHERE id_deck = nextDeck;
    
    -- определение начинающего игрока и запись в таблицу decks значения
    CALL setStartPlayer(nextDeck);
    
   SELECT 'OK', nextDeck;
END //

