DELIMITER //
CREATE PROCEDURE truncateTables()
BEGIN
    TRUNCATE TABLE playersCards;
    TRUNCATE TABLE cardsInDeck;
    TRUNCATE TABLE attackingCard;
    TRUNCATE TABLE defendingCard;
    TRUNCATE TABLE cards;
END //