/*
	FILE Final_Script.sql
    DATE 2024-03-25
    AUTHOR Ellie Wacker
    DESCRIPTION 
		A database representing a library catalog
*/
DROP DATABASE IF EXISTS library_catalog;
CREATE DATABASE library_catalog;
USE library_catalog;

DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS book_location;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS checked_out_books;
DROP TABLE IF EXISTS books_on_hold;
DROP TABLE IF EXISTS patrons;

CREATE TABLE address
(
	address_id		INT				NOT NULL		AUTO_INCREMENT		COMMENT 'The specific Id assigned to the specific address of the library'
    , city			VARCHAR(50)		NOT NULL							COMMENT 'The city the library is located in'
    , street		VARCHAR(50)		NOT NULL							COMMENT 'The librarys street'
    , zip			INT				NOT NULL							COMMENT 'The librarys zip code'
    , phone_number  VARCHAR(50)		NULL								COMMENT 'The librarys phone number'
    , PRIMARY KEY (address_id)
) COMMENT 'The table describing the librarys address'
;

CREATE TABLE book_location
(
	location_id			INT				NOT NULL		AUTO_INCREMENT		COMMENT 'A specific Id assigned to the specific location of each book.'
    , address_id		INT				NOT NULL							COMMENT 'A specific Id assigned to the specific location of each book'
    , genre    			VARCHAR(50)    	NOT NULL                            COMMENT 'The genre of each book.'
    , demographic  		VARCHAR(50)    	NULL                                COMMENT 'The age demographic of each book.'
    , PRIMARY KEY (location_id)   
    , CONSTRAINT fk_address_address_id
		FOREIGN KEY (address_id) REFERENCES address(address_id)
)COMMENT 'The table describing the specific location of each book.'         
;

CREATE TABLE books
(
	book_id 				INT				NOT NULL		AUTO_INCREMENT		COMMENT 'A specific Id assigned to each book.'
    , location_id 			INT				NOT NULL		                    COMMENT 'A specific Id assigned to the specific location of each book.'
    , title     			VARCHAR(50)     NOT NULL                            COMMENT 'The title of the book.'
    , author_name       	VARCHAR(100)    NOT NULL                            COMMENT 'The authors name.'
    , isbn_number          	VARCHAR(17)    	NOT NULL                            COMMENT 'The isbn number of each book.'
    , year_published        DATE    		NOT NULL                            COMMENT 'The year the book was published.'
    , PRIMARY KEY (book_id)
    , CONSTRAINT fk_book_location_location_id
		FOREIGN KEY (location_id) REFERENCES book_location(location_id)
)COMMENT 'The table describing each book in the library.'
;

CREATE TABLE patrons
(
	patron_id						INT				NOT NULL		AUTO_INCREMENT		COMMENT 'A specific Id assigned to each patron.'
    , checked_out_book_id			INT				NOT NULL							COMMENT 'The sighting_id is an id given to each specific sighting.'
    , hold_id     					INT    			NOT NULL							COMMENT 'A specific Id assigned to each checked out book.'
    , first_name      				VARCHAR(50)    	NOT NULL							COMMENT 'The first name of the patron.'
    , last_name       				VARCHAR(50)    	NOT NULL							COMMENT 'The last name of the patron.'
    , email							VARCHAR(50)		NOT NULL 							COMMENT 'The patrons email address.'
    , library_card_number			INT				NOT NULL							COMMENT 'The patrons library card number.'
    , fine_amount					DECIMAL(5,2)	NULL								COMMENT 'The patrons fine amount, if they have any.'
    , PRIMARY KEY (patron_id)
)COMMENT 'The table describing each member of the library.'
;


CREATE TABLE checked_out_books
(
	checked_out_book_id			INT				NOT NULL		AUTO_INCREMENT		COMMENT 'A specific Id assigned to each checked out book.'
    , book_id 					INT				NOT NULL		                    COMMENT 'A specific Id assigned to each book.'
    , patron_id     			INT				NOT NULL		                    COMMENT 'A specific Id assigned to each patron.'
    , book_name       			VARCHAR(50)    	NOT NULL                            COMMENT 'The name of the book.'
    , due_date					DATE 			NOT NULL							COMMENT 'The due date of the book'
    , date_checked_out          DATE    		NOT NULL                            COMMENT 'The date the book was checked out.'
    , days_until_overdue 		INT				NULL                                COMMENT 'The number of days until the book is overdue.'
    , is_overdue         		BOOL    		NULL                                COMMENT 'The number of people who are waiting for the book.'
    , number_people_waiting    	INT			    NULL                                COMMENT 'The patrons fine amount, if they have any.'
    , number_times_renewed		INT			    NULL								COMMENT 'The number of times the book has been renewed.'
    , PRIMARY KEY (checked_out_book_id)
    , CONSTRAINT fk_books_book_id
		FOREIGN KEY (book_id) REFERENCES books(book_id)
	, CONSTRAINT fk_patrons_patron_id
		FOREIGN KEY (patron_id) REFERENCES patrons(patron_id)
)COMMENT 'The table describing the books each patron has checked out.'
;

CREATE TABLE books_on_hold
(
	hold_id 					INT				NOT NULL		AUTO_INCREMENT		COMMENT 'A specific Id assigned to each hold.' 
    , book_id 					INT				NOT NULL		                    COMMENT 'A specific Id assigned to each book.'
    , patron_id				    INT    			NOT NULL                            COMMENT 'A specific Id assigned to each patron.'
    , book_name       			VARCHAR(50)    	NOT NULL                            COMMENT 'The name of the book.'
    , number_people_ahead       INT    			NULL                                COMMENT 'The number of people with previous hold.'
    , date_placed_on_hold       DATE	  	 	NOT NULL                            COMMENT 'The date the hold was placed.'
    , PRIMARY KEY (hold_id)     
    , CONSTRAINT fk_patrons_patron_id_hold
		FOREIGN KEY (patron_id) REFERENCES patrons(patron_id)
)COMMENT 'The table describing any books the patron has on hold'
;


INSERT INTO address (address_id, city, street, zip, phone_number) VALUES ('1', 'Hiawatha', 'Birch street', '52934', '319-310-8975');
INSERT INTO address (address_id, city, street, zip, phone_number) VALUES ('2', 'Cedar Rapids', '6th Avenue', '52934', '319-310-8975');
INSERT INTO address (address_id, city, street, zip, phone_number) VALUES ('3', 'Marion', 'W. Willman St', '52934', '319-310-8975');

INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('1', '1', 'Romance', 'Adult');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('2', '2', 'Fantasy', 'Childrens');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('3', '3', 'Graphic Novel', 'Teen');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('4', '1', 'Sci-fi', 'Adult');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('5', '2', 'Classic', 'Adult');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('6', '3', 'Mystery', 'Adult');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('7', '1', 'Horror', 'Teen');
INSERT INTO book_location (location_id, address_id, genre, demographic) VALUES ('8', '1', 'Biography', 'Family');

INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (1, 1, 'Love Comes Softly', 'Janette Oke', '942871032-6', '2003/04/12');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (2, 2, 'Howls Moving Castle', 'Diana Wynne Jones', '134917829-2', '1986/04/14');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (3, 3, 'Spider Man', 'Susan Putney', '320519157-9', '2023/07/01');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (4, 4, 'Dune', 'Frank Herbert', '825739624-9', '1965/08/14');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (5, 5, 'Pride and Prejudice', 'Jane Austen', '980978932-7', '1813/01/28');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (6, 6, 'Murder on the Orient Express', 'Agatha Christie', '795519221-4', '1934/01/01');
INSERT INTO books (book_id, location_id, title, author_name, isbn_number, year_published) values (7, 7, 'I Am Watching You', 'Teresa Dricoll', '261071481-5', '2017/10/01');


INSERT INTO patrons (patron_id, checked_out_book_id, hold_id, first_name, last_name, email, library_card_number, fine_amount) values (1, 1, 1, 'Lyndell', 'MacAlpyne', 'lmacalpyne0@mail.ru', '10000301', '0.0');
INSERT INTO patrons (patron_id, checked_out_book_id, hold_id, first_name, last_name, email, library_card_number, fine_amount) values (2, 2, 2, 'Dede', 'Gerbi', 'dgerbi1@unesco.org', '10023304', '1.50');
INSERT INTO patrons (patron_id, checked_out_book_id, hold_id, first_name, last_name, email, library_card_number, fine_amount) values (3, 3, 3, 'Jacquelynn', 'Cawood', 'jcawood2@t.co', '100020304', '0.0');

INSERT INTO checked_out_books (checked_out_book_id, book_id, patron_id, book_name, due_date, date_checked_out, days_until_overdue, is_overdue, number_people_waiting, number_times_renewed) values (1, 1, 1, 'Love Comes Softyly', '2024/04/25', '2024/01/06', '3', false, '1', '0');
INSERT INTO checked_out_books (checked_out_book_id, book_id, patron_id, book_name, due_date, date_checked_out, days_until_overdue, is_overdue, number_people_waiting, number_times_renewed) values (2, 2, 2, 'Howls Moving Castle', '2024/05/25', '2024/03/21', '0', true, '5', '3');
INSERT INTO checked_out_books (checked_out_book_id, book_id, patron_id, book_name, due_date, date_checked_out, days_until_overdue, is_overdue, number_people_waiting, number_times_renewed) values (3, 3, 3, 'Spider Man', '2024/05/15', '2024/04/04','10', false, '0', '0');

INSERT INTO books_on_hold (hold_id, book_id, patron_id, book_name, number_people_ahead, date_placed_on_hold) values (1, 4, 1, 'Dune', '1', '2024/01/04');
INSERT INTO books_on_hold (hold_id, book_id, patron_id, book_name, number_people_ahead, date_placed_on_hold) values (2, 6, 1, 'Murder on the Orient Express', '0', '2024/02/20');
INSERT INTO books_on_hold (hold_id, book_id, patron_id, book_name, number_people_ahead, date_placed_on_hold) values (3, 5, 2, 'Pride and Prejudice', '3', '2024/04/09');


-- VIEW 1
CREATE VIEW patron_summary AS
SELECT 
	CONCAT(first_name, ' ', last_name) AS 'Patron name'
	, books_on_hold.book_name AS 'On hold books'
    , checked_out_books.book_name AS 'Checked out books'
FROM books_on_hold
INNER JOIN patrons
ON books_on_hold.hold_id = patrons.hold_id
INNER JOIN checked_out_books
ON checked_out_books.checked_out_book_id = patrons.checked_out_book_id
;
SELECT *
FROM patron_summary
;


-- VIEW 2
CREATE VIEW over_due_books AS
SELECT 
	book_name AS 'Book name'
    , number_times_renewed AS 'Number of times renewed'
    , number_people_waiting AS 'Number of people waiting'
    , DATEDIFF(CURRENT_DATE(), date_checked_out) AS 'Days checked out'
    , CONCAT('$', fine_amount) AS 'Fine amount'
FROM 
	checked_out_books
    INNER JOIN patrons
    ON checked_out_books.checked_out_book_id = patrons.checked_out_book_id
WHERE is_overdue = 1
;
SELECT *
FROM over_due_books
;



-- Tests to see if the row already exists
DELIMITER $$
DROP FUNCTION IF EXISTS fn_does_row_exist$$
CREATE FUNCTION fn_does_row_exist(
	p_location_id INT 
)
RETURNS INT
COMMENT 'Inserts a row into general_ledger_accounts.'

NOT DETERMINISTIC 
READS SQL DATA 
BEGIN
	DECLARE var_count INT;
    
    SELECT COUNT(*)
    INTO var_count
    FROM book_location
    WHERE location_id = p_location_id
    ;
    
	RETURN var_count; 
END$$
DELIMITER ;



-- CREATE
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_create$$
CREATE PROCEDURE sp_create(
	IN p_location_id INT 
    , IN p_address_id INT
    , IN p_genre VARCHAR(50)
    , IN p_demographic VARCHAR(50)
)
COMMENT 'Inserts a row into general_ledger_accounts.'

BEGIN
	DECLARE var_has_dup INT;
    START TRANSACTION;
    SELECT fn_does_row_exist(p_location_id)
	INTO var_has_dup
    ;
    
    IF var_has_dup = 1 THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Row already exists'
			, MYSQL_ERRNO = 1062;
		ROLLBACK;
    END IF;

	INSERT INTO book_location(
		location_id
        , address_id
        , genre
        , demographic
	)
    VALUES (
		p_location_id
        , p_address_id 
		, p_genre
		, p_demographic
	);
    COMMIT;
END$$
DELIMITER ;
 CALL sp_create(30, 1, 'comedy', 'dog');

SELECT *
FROM book_location
;


-- READ
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_read$$
CREATE PROCEDURE sp_read(
	IN p_location_id INT 
)
COMMENT 'Reads a row from general_ledger_accounts.'

BEGIN
	DECLARE var_has_dup INT;
    START TRANSACTION;
    SELECT fn_does_row_exist(p_location_id)
	INTO var_has_dup
    ;
    
    IF var_has_dup = 0 THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Row does not exists'
			, MYSQL_ERRNO = 1062;
		ROLLBACK;
    END IF;

	SELECT 
		location_id
        , address_id
        , genre
        , demographic
    FROM book_location
    WHERE location_id = p_location_id;
    COMMIT;
END$$
DELIMITER ;
 CALL sp_read(4);



-- UPDATE
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_update$$
CREATE PROCEDURE sp_update(
	IN p_location_id INT 
    , IN p_address_id INT
    , IN p_genre VARCHAR(50)
    , IN p_demographic VARCHAR(50)
    , IN p_og_location_id INT 
    , IN p_og_address_id INT
    , IN p_og_genre VARCHAR(50)
    , IN p_og_demographic VARCHAR(50)
)
COMMENT 'Updates a row in library location.'
BEGIN
	DECLARE var_row_match INT;
    START TRANSACTION;
    SELECT COUNT(*)
	INTO var_row_match
    FROM book_location
    WHERE 
		location_id = p_og_location_id 
		AND address_id = p_og_address_id
		AND genre = p_og_genre
		AND demographic = p_og_demographic
    ;
    
    IF var_row_match = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Row does not exist'
			, MYSQL_ERRNO = 1001;
		ROLLBACK;
    END IF;

	UPDATE book_location
    SET 
		address_id = p_address_id
		, genre = p_genre
		, demographic = p_demographic
	WHERE 
		location_id = p_og_location_id  
        AND address_id = p_og_address_id
        AND genre = p_og_genre
		AND demographic = p_og_demographic;
	COMMIT;
END$$
DELIMITER ;
CALL sp_update('9', '1', 'Horror', 'Juvenile', '5', '2', 'Classic', 'Adult');
SELECT *
FROM book_location
;

-- DELETE
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_delete$$
CREATE PROCEDURE sp_delete(
    IN p_og_location_id INT 
    , IN p_og_address_id INT
    , IN p_og_genre VARCHAR(50)
    , IN p_og_demographic VARCHAR(50)
)
COMMENT 'Deletes a row from library location.'
BEGIN
	DECLARE var_row_match INT;
    START TRANSACTION;
    SELECT COUNT(*)
	INTO var_row_match
    FROM book_location
    WHERE 
		location_id = p_og_location_id 
		AND address_id = p_og_address_id
		AND genre = p_og_genre
		AND demographic = p_og_demographic
    ;
    
    IF var_row_match = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Row does not exist'
			, MYSQL_ERRNO = 1001;
		ROLLBACK;
    END IF;

	DELETE FROM book_location
		WHERE location_id = p_og_location_id  
		AND address_id = p_og_address_id
		AND genre = p_og_genre
		AND demographic = p_og_demographic;
	COMMIT;
END$$
DELIMITER ;

-- CALL sp_delete('8', '1', 'Biography', 'Family');
SELECT *
FROM book_location
;


-- CREATE AUDIT TABLE --

DROP TABLE IF EXISTS patron_audit;
CREATE TABLE patron_audit (
	patron_id						INT				NOT NULL		
    , checked_out_book_id			INT				NOT NULL		
    , hold_id     					INT    			NOT NULL		
    , first_name      				VARCHAR(50)    	NOT NULL		
    , last_name       				VARCHAR(50)    	NOT NULL		
    , email							VARCHAR(50)		NOT NULL 		
    , library_card_number			INT				NOT NULL		
    , fine_amount					DECIMAL(5,2)	NULL							         
)
;



-- The insert trigger for patrons --

DELIMITER $$
DROP TRIGGER IF EXISTS tr_patron_after_insert$$
CREATE TRIGGER tr_patron_after_insert
AFTER INSERT ON patrons
FOR EACH ROW 
BEGIN 
	INSERT INTO patron_audit(
		patron_id				
		, checked_out_book_id	
		, hold_id     			
		, first_name      					
		, last_name       					
		, email						       
		, library_card_number	
		, fine_amount			
	)
    VALUES (
		NEW.patron_id				
		, NEW.checked_out_book_id	
		, NEW.hold_id     			
		, NEW.first_name      					
		, NEW.last_name       					
		, NEW.email						       
		, NEW.library_card_number	
		, NEW.fine_amount			
		)
    ;
    
END $$
DELIMITER ;

-- test insert trigger --
INSERT INTO patrons(
	patron_id				
	, checked_out_book_id	
	, hold_id     			
	, first_name      					
	, last_name       					
	, email						       
	, library_card_number	
	, fine_amount	
)
VALUES (
	'80' -- patron_id				
	, '90' -- checked_out_book_id	
	, '70' -- hold_id     			
	, 'Gracie' -- first_name      					
	, 'dog' -- last_name       					
	, 'dog@gmail.com' -- email						       
	, '1000902' -- library_card_number	
	, '5.00' -- fine_amount	
)
;

SELECT *
FROM patrons
;


-- UPDATE TRIGGER --

DELIMITER $$
DROP TRIGGER IF EXISTS tr_patron_after_update$$
CREATE TRIGGER tr_patron_after_update
AFTER UPDATE ON patrons
FOR EACH ROW 
BEGIN 
	INSERT INTO patron_audit(
		patron_id				
		, checked_out_book_id	
		, hold_id     			
		, first_name      					
		, last_name       					
		, email						       
		, library_card_number	
		, fine_amount			
	)
    VALUES (
		NEW.patron_id				
		, NEW.checked_out_book_id	
		, NEW.hold_id     			
		, NEW.first_name      					
		, NEW.last_name       					
		, NEW.email						       
		, NEW.library_card_number	
		, NEW.fine_amount			
		)
    ;
END $$
DELIMITER ;

UPDATE patrons 
SET last_name = 'Wacker'
WHERE last_name = 'dog'
;

SELECT *
FROM patrons
WHERE last_name = 'Wacker'
;

-- DELETE TRIGGER --

DELIMITER $$
DROP TRIGGER IF EXISTS tr_patron_after_delete$$
CREATE TRIGGER tr_patron_after_delete
AFTER DELETE ON patrons
FOR EACH ROW 
BEGIN 
	INSERT INTO patron_audit(
		patron_id				
		, checked_out_book_id	
		, hold_id     			
		, first_name      					
		, last_name       					
		, email						       
		, library_card_number	
		, fine_amount			
	)
    VALUES (
		OLD.patron_id				
		, OLD.checked_out_book_id	
		, OLD.hold_id     			
		, OLD.first_name      					
		, OLD.last_name       					
		, OLD.email						       
		, OLD.library_card_number	
		, OLD.fine_amount			
		)
    ;
END $$
DELIMITER ;


DELETE FROM checked_out_books
WHERE patron_id IN (SELECT patron_id FROM patrons WHERE first_name = 'Lyndell');

DELETE FROM books_on_hold
WHERE patron_id IN (SELECT patron_id FROM patrons WHERE first_name = 'Lyndell');

DELETE FROM patrons
WHERE first_name = 'Lyndell';
;

SELECT *
FROM patrons;









