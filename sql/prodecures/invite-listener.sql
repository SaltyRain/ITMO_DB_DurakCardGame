DELIMITER //
CREATE PROCEDURE inviteListener(user_login varchar(50), user_password varchar(255))
invitelistener_label : BEGIN
    DECLARE userid INT UNSIGNED DEFAULT 0;
    DECLARE userid2 INT UNSIGNED DEFAULT 0;

    IF(not checkPassword(user_login, user_password)) THEN
        SELECT "INCORRECT PSD";
        LEAVE invitelistener_label;
    END IF;

    SET userid = getUserId(user_login);
    IF(NOT EXISTS (SELECT 1 FROM invites WHERE id_invited = userid LIMIT 1)) THEN
        SELECT "WAITING";
        LEAVE invitelistener_label;
    END IF;
    
    SET userid2 = (SELECT id_inviting FROM invites WHERE id_invited = userid LIMIT 1);
	SELECT login FROM Users WHERE id_user = userid2;

END //