DELIMITER //
CREATE FUNCTION getPlayerSmallestTrump(idplayer INT UNSIGNED, trump varchar(6))
RETURNS INT UNSIGNED
BEGIN
     RETURN (SELECT min(id_card) FROM playersCards 
     	WHERE id_player = idplayer AND id_card IN (SELECT id_card FROM cards 
			WHERE id_typecard IN (SELECT id_typecard FROM cardTypes WHERE suit = trump)));
END //