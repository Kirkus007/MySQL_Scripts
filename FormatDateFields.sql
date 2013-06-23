delimiter $$

CREATE DEFINER=`root`@`%` PROCEDURE `FormatDateFields`(IN pTableName varchar(50), in pFieldName varchar(50))
BEGIN
# Convert date format variants to the MySQL standard. 
# Use to clean up data during data import. 

-- reformat mm/dd/yyyy
SET @myvar =  CONCAT('UPDATE ', pTableName ,' SET ', pFieldName , ' = STR_TO_DATE(TRIM(', pFieldName, '), \'%m/%d/%Y\') WHERE TRIM(', pFieldName, ') REGEXP(\'^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$\')'); 
 SELECT @myvar;
PREPARE stmt1 FROM @myvar; 
EXECUTE stmt1; 
Deallocate prepare stmt1; 

-- reformat yyyymmdd
SET @myvar =  CONCAT('UPDATE ', pTableName ,' SET ', pFieldName , ' = STR_TO_DATE(TRIM(', pFieldName, '), \'%Y%m%d\') WHERE TRIM(', pFieldName, ') REGEXP(\'^[0-9]{4}[0-9]{1,2}[0-9]{1,2}$\')'); 
-- SELECT @myvar;
PREPARE stmt1 FROM @myvar; 
EXECUTE stmt1; 
Deallocate prepare stmt1; 

-- reformat yyyymmdd
SET @myvar =  CONCAT('UPDATE ', pTableName ,' SET ', pFieldName , ' = NULL WHERE ', pFieldName, ' = \'\''); 
-- SELECT @myvar;
PREPARE stmt1 FROM @myvar; 
EXECUTE stmt1; 
Deallocate prepare stmt1; 

END$$

