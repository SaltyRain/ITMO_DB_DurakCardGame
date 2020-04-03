DELIMITER //
CREATE PROCEDURE insertUser(user_login varchar(50), user_password varchar(50))
BEGIN   
    IF (EXISTS (SELECT 1 FROM users where login = user_login)) THEN
        SELECT "SUCH USER ALREADY EXISTS!";
    ELSE
        INSERT INTO users VALUES(NULL, user_login, SHA2(user_password, 256));
        SELECT "OK";
    END IF;
END //
