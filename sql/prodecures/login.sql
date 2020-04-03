DELIMITER //
CREATE PROCEDURE login(user_login varchar(50), user_password varchar(50))
BEGIN
    IF(checkPassword(user_login, user_password))
    THEN
        SELECT "OK";
    ELSE
        SELECT "DENIED";
    END IF;
END //