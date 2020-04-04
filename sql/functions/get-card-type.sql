DELIMITER //
CREATE FUNCTION getCardType(cardid INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT id_typecard FROM cardTypes WHERE id_typecard = (SELECT id_typecard FROM cards WHERE id_card = cardid));
END //