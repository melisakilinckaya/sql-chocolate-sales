-- Exploratory Data Analysis-EDA 

-- Sutun B�lg�ler�
SELECT
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH,
IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
TABLE_NAME='chocolate_sales'; 

-- Sutun Adlar�n� Duzenleme
EXEC sp_rename 'chocolate_sales.Product', 'Product_', 'COLUMN';
EXEC sp_rename 'chocolate_sales.Date', 'Date_', 'COLUMN';

-- 'Amount' Donusturmes� ve 'Amount_' Sutununu Veri Setine Ekleme
ALTER TABLE chocolate_sales
ADD Amount_ FLOAT;

UPDATE chocolate_sales
SET Amount_ = CAST(Replace(Amount, ',','.') AS FLOAT);

SELECT Amount_ FROM chocolate_sales;

-- 'Amount' Sutununu Silme 
ALTER TABLE chocolate_sales
DROP COLUMN Amount;

-- Toplam Kay�t 
SELECT COUNT(*) AS Total_Records From chocolate_sales; 

-- NULL Kontrolleri 
SELECT
SUM(CASE WHEN Sales_Person IS NULL THEN 1 ELSE 0 END) AS Null_Sales_Person,
SUM( CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Null_Country,
SUM(CASE WHEN Product_ IS NULL THEN 1 ELSE 0 END) AS Null_Product,
SUM(CASE WHEN Date_ IS NULL THEN 1 ELSE 0 END) AS Null_Date,
SUM(CASE WHEN Amount_ IS NULL THEN 1 ELSE 0 END) AS Null_Amount_,
SUM(CASE WHEN Boxes_Shipped IS NULL THEN 1 ELSE 0 END) AS Null_Boxes_Shipped
FROM chocolate_sales; 

-- Tarih Aral�klar� (Min, Max) 
SELECT 
MIN(Date_) AS Min_Date,
MAX(Date_) AS Max_Date
FROM chocolate_sales;

-- 'Unique' Deger 
SELECT
COUNT(DISTINCT Sales_Person) AS Unique_Persons,
COUNT( DISTINCT Country) AS Unique_Countries,
COUNT(DISTINCT Product_) AS Unique_Products
FROM chocolate_sales; 

-- Temel istatistikler 
SELECT
MIN(Amount_) AS Min_Amount,
MAX(Amount_) AS Max_Amount,
AVG(Amount_) AS Avg_Amount,
MIN(Boxes_Shipped) AS Min_Amount,
MAX(Boxes_Shipped) AS Max_Amount,
AVG(Boxes_Shipped) AS Avg_Amount
FROM chocolate_sales; 

-- Zaman Baz�nda Toplu Sat�s Analizi 
SELECT 
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
SUM(Amount_) AS Total_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY YEAR(Date_), MONTH(Date_)
ORDER BY YEAR(Date_), MONTH(Date_) 

-- '0' Kutulu Gonder�m Say�s� (Unit Price Hesaplarken '0' deger� bolme islem� s�ras�nda yanl�s sonuca gotureb�l�rd�)
SELECT COUNT(*) AS Zero_Boxes_Count
FROM chocolate_sales
WHERE Boxes_Shipped = 0;

-- Unit_Price(Kutu Bas�na Dusen B�r�m F�yat) Hesaplamas� 
SELECT
Amount_ / Boxes_Shipped AS Unit_Price
FROM chocolate_sales;

ALTER TABLE chocolate_sales
ADD Unit_Price FLOAT;

UPDATE chocolate_sales
SET Unit_Price = Amount_ / Boxes_Shipped;


