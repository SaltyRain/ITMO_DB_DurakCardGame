DELIMITER //
CREATE FUNCTION getUserId(user_login varchar(50))
RETURNS INT
BEGIN
    RETURN (SELECT id_user FROM users WHERE login = user_login);
END //