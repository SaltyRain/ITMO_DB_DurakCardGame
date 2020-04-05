DELIMITER //
CREATE FUNCTION getCardSuit(typecardid INT UNSIGNED)
RETURNS VARCHAR(6)
BEGIN
    -- проверка на для пасующего игрока
    IF (typecardid = -1) THEN
        RETURN -1;
    END IF;
    RETURN (SELECT suit FROM cardTypes WHERE id_typecard = typecardid);
END //