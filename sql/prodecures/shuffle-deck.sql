DELIMITER //
CREATE PROCEDURE shuffleDeck(deckid int)
BEGIN
    
    DECLARE player1 INT UNSIGNED DEFAULT 0;
    DECLARE player2 INT UNSIGNED DEFAULT 0;

    /* Копируем все карты из типов карт в карты в перемешанном виде */
    INSERT INTO cards SELECT NULL, id_typecard FROM cardTypes ORDER BY RAND();
    
    /* Замешиваем все карты в колоду */
    INSERT INTO cardsInDeck	SELECT * FROM (SELECT id_card, id_deck FROM cards, decks WHERE id_deck = deckid ORDER BY id_card DESC LIMIT 36) as m1 ORDER BY RAND();
            
    /* Раздаем по 6 карт каждому игроку */

    SET player1 = (SELECT min(id_player) FROM players WHERE players.id_deck = deckid);
    SET player2 = (SELECT max(id_player) FROM players WHERE Players.id_deck = deckid);

    CREATE TEMPORARY TABLE cardsToPlayer (
        id_card INT UNSIGNED,
        id_player INT UNSIGNED
    );

    INSERT INTO cardsToPlayer SELECT id_card, player1 FROM cardsInDeck WHERE id_deck = deckid LIMIT 6;
    INSERT INTO playersCards SELECT * FROM cardsToPlayer;
    DELETE FROM cardsInDeck WHERE id_card IN (SELECT id_card FROM cardsToPlayer);

    TRUNCATE TABLE cardsToPlayer;

    INSERT INTO cardsToPlayer SELECT id_card, player2 FROM cardsInDeck WHERE id_deck = deckid LIMIT 6;
    INSERT INTO playersCards SELECT * FROM cardsToPlayer;
    DELETE FROM cardsInDeck WHERE id_card IN (SELECT id_card FROM cardsToPlayer);

    DROP TABLE cardsToPlayer;

END //