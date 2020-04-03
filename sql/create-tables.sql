CREATE TABLE users (
    id_user INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login varchar(50),
    password varchar(255)
);

CREATE TABLE decks (
    id_deck INT UNSIGNED NOT NULL PRIMARY KEY,
    id_attacker INT UNSIGNED NOT NULL,
    trump varchar(6),
    winner INT UNSIGNED
);

CREATE TABLE players (
    id_player INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_user INT UNSIGNED NOT NULL,
    id_deck INT UNSIGNED NOT NULL, 
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (id_deck) REFERENCES decks(id_deck)
);



CREATE TABLE cardTypes (
    id_typecard INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rank INT UNSIGNED NOT NULL,
    suit varchar(6)
);

CREATE TABLE cards (
    id_card INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_typecard INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_typecard) REFERENCES cardTypes(id_typecard)
);

CREATE TABLE cardsInDeck (
    id_card INT UNSIGNED NOT NULL PRIMARY KEY,
    id_deck INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_card) REFERENCES cards(id_card),
    FOREIGN KEY (id_deck) REFERENCES decks(id_deck)
);

CREATE TABLE playersCards (
    id_card INT UNSIGNED NOT NULL PRIMARY KEY,
    id_player INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_card) REFERENCES cards(id_card),
    FOREIGN KEY (id_player) REFERENCES players(id_player)
);



CREATE TABLE attackingCard (
    id_card INT UNSIGNED NOT NULL PRIMARY KEY,
    FOREIGN KEY (id_card) REFERENCES cards(id_card)
);

CREATE TABLE defendingCard (
    id_card INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (id_card) REFERENCES cards(id_card)
);


CREATE TABLE invites (
    id_inviting INT UNSIGNED NOT NULL,
    id_invited INT UNSIGNED NOT NULL,
    date_inv DATE DEFAULT NULL,
    confirm TINYINT DEFAULT NULL,
    PRIMARY KEY (id_inviting, id_invited)
);