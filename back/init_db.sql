DROP  DATABASE IF EXISTS groupomania;
CREATE DATABASE groupomania
    DEFAULT CHARACTER SET = 'utf8mb4';
use groupomania;
CREATE TABLE user(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    lastname VARCHAR(255) NOT NULL ,
    firstname VARCHAR(255) NOT NULL ,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    moderation INT DEFAULT 0,
    created_at DATE 
) DEFAULT CHARSET UTF8 ;

CREATE TABLE post(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(255),
    id_author INT NOT NULL, 
    FOREIGN KEY (id_author) REFERENCES user(id),
    created_at DATETIME
) DEFAULT CHARSET UTF8 ;

CREATE TABLE comment(  
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    content TEXT NOT NULL ,
    id_author INT NOT NULL,
    id_post INT NOT NULL, 
    FOREIGN KEY (id_author) REFERENCES user(id),
    FOREIGN KEY (id_post) REFERENCES post(id) ON DELETE CASCADE,
    created_at DATETIME
) DEFAULT CHARSET UTF8 ;

insert into user  VALUES
(NULL, 'wayne', 'bruce', 'wayne@gmail.com', "$2b$10$xvACjLeYLAWv5FWmBapYe.AnYVPhop3L1.K3WE00F..JL3yvujnqy", 0, NOW() ) , 
(NULL, 'kent', 'clark','kent@gmail.com', "$2b$10$xvACjLeYLAWv5FWmBapYe.AnYVPhop3L1.K3WE00F..JL3yvujnqy", 0, NOW() ) ,
(NULL, 'prince', 'diana', 'prince@gmail.com', "$2b$10$xvACjLeYLAWv5FWmBapYe.AnYVPhop3L1.K3WE00F..JL3yvujnqy", 1, NOW() )
;
insert into post (title, content, image, id_author, created_at) VALUES
("superman", "photo de superman", "http://localhost:3000/images/superman.jpg", 1, NOW() ),
("batman", "batman énervé", "http://localhost:3000/images/batman.jpg", 2, NOW() )
;

insert into comment (content, id_author, id_post, created_at) VALUES
("superman est nul", 2, 1, NOW()),
("moi je le kiffe", 3, 1, NOW()),
("lui il est riche", 1, 2, NOW()),
("bonjour, je pourrais intégrer la lj svp ?", 3, 2, NOW())


