DELIMITER //
CREATE FUNCTION checkPassword(user_login varchar(50), user_password varchar(255))
RETURNS TINYINT
BEGIN
    RETURN EXISTS (SELECT 1 FROM users WHERE login = user_login AND password = (SELECT SHA2(user_password, 256)));
END //