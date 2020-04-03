DELIMITER //
CREATE PROCEDURE invite (user_login varchar(50), user2_login varchar(50), user_password varchar(255))
invite_label : BEGIN 
    DECLARE userId INT UNSIGNED DEFAULT 0;
    DECLARE userId2 INT UNSIGNED DEFAULT 0;

    -- Проверка на инвайт самого себя
    IF(user2_login = user_login)
    THEN
    	SELECT "INVITE YOURSELF";
        LEAVE invite_label;
    END IF;

    SET userid2 = getUserId(user2_login);
    IF(userid2 IS NULL)
    THEN
        SELECT "NO SUCH USER";
        LEAVE invite_label;
    END IF;

    SET userid = getUserId(user_login);
    IF (inviteExists(userid, userid2))
    THEN
        SELECT "INVITE ALREADY EXISTS";
        LEAVE invite_label;
    END IF;

    -- Создание инвайта
    INSERT INTO invites(id_inviting, id_invited, date_inv, confirm) VALUES(userid, userid2, CURRENT_DATE, false);
    SELECT "OK";
END //