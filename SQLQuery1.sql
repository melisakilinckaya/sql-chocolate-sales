 
SELECT
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH,
IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
TABLE_NAME='chocolate_sales'; -- Exploratory Data Analysis-EDA  -- Sutun Bilgileri

-- Sutun Adlarini Duzenleme
EXEC sp_rename 'chocolate_sales.Product', 'Product_', 'COLUMN';
EXEC sp_rename 'chocolate_sales.Date', 'Date_', 'COLUMN';

-- 'Amount' Donusturmesi ve 'Amount_' Sutununu Veri Setine Ekleme
ALTER TABLE chocolate_sales
ADD Amount_ FLOAT;

UPDATE chocolate_sales
SET Amount_ = CAST(Replace(Amount, ',','.') AS FLOAT);

SELECT Amount_ FROM chocolate_sales;

-- 'Amount' Sutununu Silme 
ALTER TABLE chocolate_sales
DROP COLUMN Amount;

-- Toplam Kayit
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

-- Tarih Araliklari (Min, Max) 
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

-- Zaman Bazinda Toplu Satis Analizi 
SELECT 
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
SUM(Amount_) AS Total_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY YEAR(Date_), MONTH(Date_)
ORDER BY YEAR(Date_), MONTH(Date_) 

-- '0' Kutulu Gonderim Sayisi (Unit Price Hesaplarken '0' degeri bolme islemi sirasinda yanlis sonuca goturebilirdi)
SELECT COUNT(*) AS Zero_Boxes_Count
FROM chocolate_sales
WHERE Boxes_Shipped = 0;

-- Unit_Price(Kutu Basýna Dusen Birim Fiyat) Hesaplamasi 
SELECT
Amount_ / Boxes_Shipped AS Unit_Price
FROM chocolate_sales;

ALTER TABLE chocolate_sales
ADD Unit_Price FLOAT;

UPDATE chocolate_sales
SET Unit_Price = Amount_ / Boxes_Shipped;


