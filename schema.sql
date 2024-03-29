CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    role TEXT NOT NULL
);

INSERT INTO roles (role) VALUES ('user');
INSERT INTO roles (role) VALUES ('seller');
INSERT INTO roles (role) VALUES ('moderator');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL, 
    password TEXT NOT NULL,
    joined DATE NOT NULL DEFAULT CURRENT_DATE,
    role INTEGER REFERENCES roles(id) DEFAULT 1,
    visible BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    title TEXT UNIQUE NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL NOT NULL,
    release_date DATE NOT NULL,
    release_time TIME NOT NULL,
    creator_id INTEGER REFERENCES users(id),
    visible BOOLEAN NOT NULL DEFAULT TRUE
    CHECK (price >= 0)
);

CREATE TABLE images (
    game_id INTEGER REFERENCES games(id),
    imagename TEXT,
    imagedata BYTEA
);

CREATE TABLE temp_images (
    user_id INTEGER REFERENCES users(id),
    imagename TEXT,
    imagedata BYTEA
);

CREATE TABLE library (
    user_id INTEGER REFERENCES users(id),
    game_id INTEGER REFERENCES games(id)
);

CREATE TABLE wishlist (
    user_id INTEGER REFERENCES users(id),
    date DATE NOT NULL,
    game_id INTEGER REFERENCES games(id)
);

CREATE TABLE cart (
    user_id INTEGER REFERENCES users(id),
    game_id INTEGER REFERENCES games(id)
);

CREATE TABLE reviews (
    user_id INTEGER REFERENCES users(id),
    game_id INTEGER REFERENCES games(id),
    date DATE NOT NULL,
    edited DATE,
    rating TEXT NOT NULL,
    review TEXT NOT NULL
);

CREATE TABLE history (
    user_id INTEGER REFERENCES users(id),
    game_id INTEGER REFERENCES games(id),
    date DATE NOT NULL,
    sum DECIMAL NOT NULL
);

CREATE TABLE balance (
    user_id INTEGER REFERENCES users(id),
    amount DECIMAL NOT NULL DEFAULT 0.00
    CHECK (amount >= 0)
);