DELIMITER //
CREATE FUNCTION getCardType(cardid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT id_typecard FROM cardTypes WHERE id_typecard = (SELECT id_typecard FROM cards WHERE id_card = cardid));
END //

-- SELECT id_typecard FROM cardTypes WHERE id_typecard IN (SELECT id_typecard FROM cards WHERE id_card IN (SELECT id_card FROM playersCards WHERE id_player = playerId))