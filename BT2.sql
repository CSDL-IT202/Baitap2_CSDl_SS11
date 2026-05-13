CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT,
    Address VARCHAR(255)
);

DELIMITER //

CREATE PROCEDURE SeedPatients()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 500000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address)
        VALUES (
            CONCAT('Patient ', i),
            CONCAT('090', LPAD(i,7,'0')),
            FLOOR(RAND()*100),
            'Ho Chi Minh City'
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL SeedPatients();

EXPLAIN
SELECT *
FROM Patients
WHERE Phone = '0900000100';

CREATE INDEX idx_phone
ON Patients(Phone);

EXPLAIN
SELECT *
FROM Patients
WHERE Phone = '0900000100';

DROP INDEX idx_phone ON Patients;

SET @start_no_index = NOW(6);

INSERT INTO Patients (Full_Name, Phone, Age, Address)
VALUES
('Test 1','0991111111',25,'HCM'),
('Test 2','0991111112',26,'HCM'),
('Test 3','0991111113',27,'HCM'),
('Test 4','0991111114',28,'HCM'),
('Test 5','0991111115',29,'HCM');

SELECT TIMESTAMPDIFF(MICROSECOND,@start_no_index,NOW(6)) AS Time_No_Index;

CREATE INDEX idx_phone
ON Patients(Phone);

SET @start_with_index = NOW(6);

INSERT INTO Patients (Full_Name, Phone, Age, Address)
VALUES
('Test 6','0991111116',25,'HCM'),
('Test 7','0991111117',26,'HCM'),
('Test 8','0991111118',27,'HCM'),
('Test 9','0991111119',28,'HCM'),
('Test 10','0991111120',29,'HCM');

SELECT TIMESTAMPDIFF(MICROSECOND,@start_with_index,NOW(6)) AS Time_With_Index;