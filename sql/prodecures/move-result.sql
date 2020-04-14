DELIMITER //
CREATE PROCEDURE moveResult(user_login varchar(50), user_password varchar(255), attackerid INT UNSIGNED, defenderid INT UNSIGNED, deckid INT UNSIGNED)
moveresult_label : BEGIN

    DECLARE attackCard INT UNSIGNED;
    DECLARE defCard INT UNSIGNED;

    

    DECLARE nextDeckCard INT UNSIGNED;

    -- То, что возвращается игроку в ответе
    DECLARE winnerId INT UNSIGNED;
    DECLARE newAttackerCardId INT UNSIGNED;
    DECLARE existsNewDefenderCard INT UNSIGNED DEFAULT 0;
    DECLARE cardsInDeckAmount INT UNSIGNED;

    -- Проверка пароля
    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE moveresult_label;
    END IF;

    -- Проверяем, является ли игрок атакующим
    IF (attackerid <> (SELECT id_attacker FROM decks WHERE id_deck = deckid)) THEN
        SELECT "YOU CANT USE MOVERESULT";
        LEAVE moveresult_label;
    END IF;

    SET defCard = (SELECT id_card FROM defendingCards WHERE id_deck = deckid);
    SET attackCard = (SELECT id_card FROM attackingCards WHERE id_deck = deckid);
    -- Если противник пасанул
    IF (defCard = -1) THEN
        -- карта атакующего добавляется противнику в руку
        INSERT INTO playersCards(id_card, id_player) VALUE (attackCard, defenderid);
        SET existsNewDefenderCard = 1;

    ELSE
        -- Игрок отбился
        -- Меняем атакующего игрока
        UPDATE decks SET id_attacker = defenderid WHERE id_deck = deckid;
    END IF;

    -- Проверяем на результат всей игры
    SET winnerId = GameResult(attackerid, defenderid, deckid);
    IF (winnerId = 0) THEN
        -- игра не закончилась
        -- заканчиваем ход

        -- если колода не закончилась
        IF (EXISTS (SELECT * FROM cardsInDeck WHERE id_deck = deckid)) THEN
            
            IF ((SELECT COUNT(*) FROM playersCards WHERE id_player = attackerid) < 6) THEN
                -- достаем следующую карту из колоды
                SET nextDeckCard = (SELECT MIN(id_card) FROM cardsInDeck WHERE id_deck = deckid);
                -- даем карту атакующему игроку
                START TRANSACTION;
                    INSERT INTO playersCards(id_card, id_player) VALUE (nextDeckCard, attackerid);
                    DELETE FROM cardsInDeck WHERE id_card = nextDeckCard AND id_deck = deckid;
                COMMIT;

                SET newAttackerCardId = nextDeckCard;
            END IF;
        ELSE 
            SET newAttackerCardId = 0;
        END IF;

        -- Если противник отбился
        IF (defCard <> -1) THEN
            -- если колода не закончилась
            IF (EXISTS (SELECT * FROM cardsInDeck WHERE id_deck = deckid)) THEN
                
                IF ((SELECT COUNT(*) FROM playersCards WHERE id_player = defenderid) < 6) THEN
                    -- достаем следующую карту из колоды
                    SET nextDeckCard = (SELECT MIN(id_card) FROM cardsInDeck WHERE id_deck = deckid);
                    -- даем карту атакующему игроку
                    START TRANSACTION;
                        INSERT INTO playersCards(id_card, id_player) VALUE (nextDeckCard, defenderid);
                        DELETE FROM cardsInDeck WHERE id_card = nextDeckCard AND id_deck = deckid;
                    COMMIT;

                    SET existsNewDefenderCard = 1;
                END IF;
            ELSE 
                SET existsNewDefenderCard = 0;
            END IF;
        END IF;
    ELSE 
        -- игра закончилась
        UPDATE decks SET winner = winnerId WHERE id_deck = deckid;
        -- возвращается только id победителя
        SELECT winnerId; 
        LEAVE moveresult_label;
    END IF;

    SET cardsInDeckAmount = (SELECT COUNT(*) FROM cardsInDeck WHERE id_deck = deckid);

    -- Удаляем карты со стола
    -- DELETE FROM attackingCards WHERE id_deck = deckid;
    -- DELETE FROM defendingCards WHERE id_deck = deckid;
    TRUNCATE TABLE attackingCards;
    TRUNCATE TABLE defendingCards;

    SELECT winnerId, newAttackerCardId, existsNewDefenderCard, cardsInDeckAmount;
END //