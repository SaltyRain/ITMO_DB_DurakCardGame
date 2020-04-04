-- CALL getGameStatus('kek','kek', 25);
-- deckCardsAmount
SELECT COUNT(*) FROM cardsInDeck WHERE id_deck = 25;
-- oponentCardsAmount
SELECT COUNT(*) FROM playersCards WHERE id_player = 51;

-- userId 
SELECT getUserId('kek');
-- playerId
SELECT id_player FROM players WHERE id_user = 50;
-- oponentId
SELECT id_player FROM players WHERE id_deck = 25 AND id_player <> 50;

-- trashCardsAmount
SELECT (36 - 23 - 21 -  
                            (SELECT COUNT(*) FROM attackingCards WHERE id_deck = 25) - 
                            (SELECT COUNT(*) FROM defendingCards WHERE id_deck = 25) - 
                            (SELECT COUNT(*) FROM playersCards WHERE id_player = 50)) as trashCardsAmount;


SELECT (EXISTS (SELECT id_card FROM attackingCards WHERE id_deck = 25));
 SELECT getCardType((SELECT MAX(id_card) FROM cardsInDeck WHERE id_deck = 25));
SELECT 25, id_typecard FROM cardTypes WHERE id_typecard IN (SELECT id_typecard FROM cards WHERE id_card IN (SELECT id_card FROM playersCards WHERE id_player = 50));