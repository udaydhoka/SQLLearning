--/* mod 29 mathematical funcitons

--ABS(num_exp)
SELECT ABS(-101);

SELECT ABS(-101.5);

-----------------------------------------------------------------

--CEILING(num_exp)
SELECT CEILING(15.6);
SELECT CEILING(15.1);
SELECT CEILING(15);

SELECT CEILING(-15.6);
SELECT CEILING(-15.1);

-----------------------------------------------------------------

--FLOOR(num_exp)
SELECT FLOOR(15.9);
SELECT FLOOR(15.1);
SELECT FLOOR(15);

SELECT FLOOR(-15.9);
SELECT FLOOR(-15.1);

-----------------------------------------------------------------

--POWER(exp,pow)
SELECT POWER(2,2);
SELECT POWER(2,3);
SELECT POWER(2.3,4);

-----------------------------------------------------------------

--SQUARE(num)
SELECT SQUARE(2);
SELECT SQUARE(3);
SELECT SQUARE(2.2);

-----------------------------------------------------------------

--SQRT(num)
SELECT SQRT(81);
SELECT SQRT(625);
SELECT SQRT(4);
SELECT SQRT(81.9);

-----------------------------------------------------------------

--RAND([seed_value])
SELECT RAND(1);  --always returns same value

SELECT RAND();  --returns different value for each run between 0 & 1

SELECT FLOOR(RAND()*100); --return random val between 1 & 100 for each run

--prints 10 random number between 1 & 100
DECLARE @Counter int
SET @Counter = 1 
WHILE(@Counter <=10)
BEGIN 
	PRINT FLOOR(RAND()*100)
	SET @Counter += 1
END

-----------------------------------------------------------------

--ROUND( numeric_expression , length [ ,function ] )

-- Round to 2 places after (to the right) the decimal point
SELECT ROUND(9.66666,2);  --returns 9.67000

-- Truncate anything after 2 places, after (to the right) the decimal point 
SELECT ROUND(9.66666,2,1);  --returns 9.66000

-- Round to 1 place after (to the right) the decimal point
Select ROUND(850.556, 1) -- Returns 850.600

-- Truncate anything after 1 place, after (to the right) the decimal point
Select ROUND(850.556, 1, 1) -- Returns 850.500

-- Round the last 2 places before (to the left) the decimal point
Select ROUND(850.556, -2) -- 900.000

-- Round the last 1 place before (to the left) the decimal point
Select ROUND(850.556, -1) -- 850.000

-----------------------------------------------------------------

--*/