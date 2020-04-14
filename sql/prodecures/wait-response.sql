DELIMITER //
CREATE PROCEDURE waitResponse(user_login varchar(50), user2_login varchar(50), user_password varchar(255))
waitresponse_label: BEGIN
    DECLARE userid INT UNSIGNED DEFAULT 0;
    DECLARE userid2 INT UNSIGNED DEFAULT 0;

    IF(user2_login = user_login) THEN
        SELECT "WAIT BY YOURSELF";
        LEAVE waitresponse_label;
    END IF;

    SET userid2 = getUserId(user2_login);
    IF(userid2 IS NULL) THEN
        SELECT "NULL INVITED";
        LEAVE waitresponse_label;
    END IF;

    IF(NOT checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSWD";
        LEAVE waitresponse_label;
    END IF;

    SET userid = getUserId(user_login);
    IF((SELECT confirm FROM invites WHERE id_inviting = userid AND id_invited = userid2) = FALSE) THEN
        SELECT "WAITING";
        LEAVE waitresponse_label;
    ELSE
        DELETE FROM invites WHERE id_inviting = userid AND id_invited = userid2;
        SELECT MAX(id_deck) FROM decks;
    END IF;
END //