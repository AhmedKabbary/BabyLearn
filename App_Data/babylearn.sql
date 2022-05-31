DROP TABLE users;
DROP TABLE users_sessions;
DROP TABLE contents;
DROP TABLE users_progress;

CREATE TABLE users
(
    UserId VARCHAR(36) NOT NULL,
    Username VARCHAR(30) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    HashedPassword VARCHAR(255) NOT NULL,
    Gender char(1) NOT NULL,
    BirthDate DATE NOT Null,
    Picture VARCHAR(255),

    PRIMARY KEY (UserId)
);
CREATE TABLE users_sessions
(
    UserId VARCHAR(36) NOT NULL,
    JTI VARCHAR(36) NOT NULL,
    LoginDate DATETIME NOT NULL,
    ExpDate DATETIME NOT NULL,

    PRIMARY KEY (UserId, JTI)
);
CREATE TABLE contents
(
    Id VARCHAR(30) NOT NULL,
    Word VARCHAR(255) NOT NULL,
    Category VARCHAR(255) NOT NULL,
    Picture VARCHAR(255) NOT NULL,
    Drawing VARCHAR(255) NULL,

    PRIMARY KEY (Id)
);
CREATE TABLE users_progress
(
    UserId VARCHAR(36) NOT NULL,
    ContentId VARCHAR(36) NOT NULL,
    Points INT NOT NULL,

    PRIMARY KEY (UserId, ContentId)
);

delete from users;
delete from users_sessions;
delete from contents;
delete from users_progress;


INSERT INTO contents VALUES ('1-001', 'red', 'colors', 'assets/contents/colors/red.png', NULL);
INSERT INTO contents VALUES ('1-002', 'yellow', 'colors', 'assets/contents/colors/yellow.png', NULL);
INSERT INTO contents VALUES ('1-003', 'green', 'colors', 'assets/contents/colors/green.png', NULL);
INSERT INTO contents VALUES ('1-004', 'blue', 'colors', 'assets/contents/colors/blue.png', NULL);
INSERT INTO contents VALUES ('1-005', 'orange', 'colors', 'assets/contents/colors/orange.png', NULL);
INSERT INTO contents VALUES ('1-008', 'pink', 'colors', 'assets/contents/colors/pink.png', NULL);
INSERT INTO contents VALUES ('1-009', 'cyan', 'colors', 'assets/contents/colors/cyan.png', NULL);
INSERT INTO contents VALUES ('1-010', 'brown', 'colors', 'assets/contents/colors/brown.png', NULL);

INSERT INTO contents VALUES ('2-001', 'potatos', 'food', 'assets/contents/food/potatos.jpg', NULL);
INSERT INTO contents VALUES ('2-002', 'tomatos', 'food', 'assets/contents/food/tomatos.jpg', NULL);
INSERT INTO contents VALUES ('2-003', 'cucumber', 'food', 'assets/contents/food/cucumber.png', NULL);
INSERT INTO contents VALUES ('2-004', 'carrots', 'food', 'assets/contents/food/carrots.png', NULL);
INSERT INTO contents VALUES ('2-005', 'lemon', 'food', 'assets/contents/food/lemon.jpg', NULL);
INSERT INTO contents VALUES ('2-006', 'apple', 'food', 'assets/contents/food/apple.png', NULL);
INSERT INTO contents VALUES ('2-007', 'orange', 'food', 'assets/contents/food/orange.jpg', NULL);
INSERT INTO contents VALUES ('2-008', 'strawberry', 'food', 'assets/contents/food/strawberry.jpg', NULL);
INSERT INTO contents VALUES ('2-009', 'mango', 'food', 'assets/contents/food/mango.jpg', NULL);
INSERT INTO contents VALUES ('2-010', 'pineapple', 'food', 'assets/contents/food/pineapple.jpg', NULL);

INSERT INTO contents VALUES ('3-001', 'cat', 'animals', 'assets/contents/animals/cat.jpg', NULL);
INSERT INTO contents VALUES ('3-002', 'dog', 'animals', 'assets/contents/animals/dog.jpg', NULL);
INSERT INTO contents VALUES ('3-003', 'lion', 'animals', 'assets/contents/animals/lion.jpg', NULL);
INSERT INTO contents VALUES ('3-004', 'giraffe', 'animals', 'assets/contents/animals/giraffe.jpg', NULL);
INSERT INTO contents VALUES ('3-005', 'monkey', 'animals', 'assets/contents/animals/monkey.jpg', NULL);
INSERT INTO contents VALUES ('3-006', 'sheep', 'animals', 'assets/contents/animals/sheap.jpg', NULL);

INSERT INTO contents VALUES ('4-001', 'ear', 'organs', 'assets/contents/organs/ear.jpg', 'assets/contents/organs/ear.jpg');
INSERT INTO contents VALUES ('4-002', 'nose', 'organs', 'assets/contents/organs/nose.jpg', 'assets/contents/organs/nose.jpg');
INSERT INTO contents VALUES ('4-003', 'eye', 'organs', 'assets/contents/organs/eye.jpg', 'assets/contents/organs/eye.jpg');
INSERT INTO contents VALUES ('4-004', 'mouth', 'organs', 'assets/contents/organs/mouth.jpg', 'assets/contents/organs/mouth.jpg');
INSERT INTO contents VALUES ('4-005', 'hand', 'organs', 'assets/contents/organs/hand.jpg', 'assets/contents/organs/hand.jpg');
INSERT INTO contents VALUES ('4-006', 'leg', 'organs', 'assets/contents/organs/leg.jpg', 'assets/contents/organs/leg.jpg');

SELECT * FROM users;
SELECT * FROM users_sessions;
SELECT * FROM contents;
SELECT * FROM users_progress;

-- get 4 new words for the child to learn
SELECT TOP 4 * FROM contents WHERE Id NOT IN (SELECT ContentId FROM users_progress WHERE UserId = 'id') ORDER BY NEWID();
-- get the 10 weakest words for the child
SELECT TOP 10 users_progress.ContentId, contents.Word, contents.Picture FROM users_progress INNER JOIN contents ON users_progress.ContentId = contents.Id AND users_progress.UserId='id' ORDER BY Points;
-- get our categories with the total words in each one of them with the user progress in it
SELECT Category, COUNT(Id) AS Total, COUNT(Points) AS Done FROM contents LEFT JOIN users_progress ON contents.Id = users_progress.ContentId AND users_progress.UserId = 'id' GROUP BY Category
-- get a random drawing for the child to draw
SELECT TOP 1 Drawing FROM contents WHERE Drawing IS NOT NULL ORDER BY NEWID();
