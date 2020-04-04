DELIMITER //
CREATE PROCEDURE truncateTables()
BEGIN
    TRUNCATE TABLE playersCards;
    TRUNCATE TABLE cardsInDeck;
    TRUNCATE TABLE attackingCards;
    TRUNCATE TABLE defendingCards;
    TRUNCATE TABLE cards;
END //