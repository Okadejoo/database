USE my_guitar_shop;
-- Query 1

DELIMITER //
CREATE PROCEDURE test()
BEGIN
DECLARE delete_entry TINYINT DEFAULT False;
DECLARE CONTINUE HANDLER FOR sqlexception SET delete_entry = True;

START transaction;
DELETE FROM Addresses WHERE  customer_id = 1;
DELETE FROM customers WHERE customer_id = 1;

IF delete_entry = TRUE THEN
ROLLBACK;
SELECT 'Could not delete rows due to foriegn key constraint';
ELSE 
COMMIT;
SELECT 'Row was deleted successfully ';
END IF;

END//


-- Query 2

DELIMITER //
CREATE PROCEDURE test2()
BEGIN
DECLARE order_id INT;
DECLARE duplicate_entry TINYINT DEFAULT False;
DECLARE CONTINUE HANDLER FOR sqlexception SET duplicate_entry = True;

START transaction;

INSERT INTO orders VALUES (DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,  
'American Express', '378282246310005', '04/2016', 4); 
SELECT LAST_INSERT_ID() INTO order_id; 
INSERT INTO order_items VALUES (DEFAULT, order_id, 6, '415.00', '161.85', 1); 
INSERT INTO order_items VALUES (DEFAULT, order_id, 1, '699.00', '209.70', 1);

IF duplicate_entry = TRUE THEN
ROLLBACK;
SELECT 'Could not insert rows due to foriegn key constraint';
ELSE 
COMMIT;
SELECT 'Row was inserted successfully ';
END IF;


END//