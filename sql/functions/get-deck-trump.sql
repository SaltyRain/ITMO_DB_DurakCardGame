DELIMITER //
CREATE FUNCTION getDeckTrump(deckid int unsigned)
RETURNS VARCHAR(6)
BEGIN
    RETURN (SELECT suit FROM cardTypes WHERE id_typecard = (SELECT id_typecard FROM cards WHERE id_card = (SELECT max(id_card) FROM cardsInDeck WHERE id_deck = deckid)));

END //