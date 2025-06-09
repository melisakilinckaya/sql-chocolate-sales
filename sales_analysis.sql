SELECT 
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
SUM(Amount_) AS Total_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY 
YEAR(Date_),
MONTH(Date_)
ORDER BY 
YEAR(Date_),
MONTH(Date_); -- Market Trend Identification -- Aylik Satis 

-- Sezon (Ceyrek) Bazinda Toplam Satis 
SELECT 
YEAR(Date_) AS Sales_Year,
DATEPART(QUARTER, Date_) AS Sales_Quarter,
SUM(Amount_) AS Total_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY 
YEAR(Date_),
DATEPART(QUARTER, Date_)
ORDER BY 
YEAR(Date_),
DATEPART(QUARTER, Date_);

-- En Cok Satilan Urunler (Toplam Satis Tutari Bazinda)
SELECT 
Product_,
SUM(Amount_) AS Total_Sales_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY Product_
ORDER BY Total_Sales_Amount DESC;

-- Ilk 10 En Cok Satilan Urun (Toplam Satis Bazinda) 
SELECT TOP 10
Product_,
SUM(Amount_) AS Total_Sales_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY Product_
ORDER BY Total_Sales_Amount DESC;

-- TOP 10 Urunun Ulke Bazinda Toplam Satislari
WITH Top10Products AS (
SELECT TOP 10 
Product_,
SUM(Amount_) AS Total_Sales_Amount
FROM chocolate_sales
GROUP BY Product_
ORDER BY Total_Sales_Amount DESC 
)
SELECT 
C.Product_,
C.Country,
SUM(C.Amount_) AS Country_Sales_Amount,
SUM(C.Boxes_Shipped) AS Country_Boxes_Shipped
FROM chocolate_sales C
INNER JOIN Top10Products T
ON C.Product_ = T.Product_
GROUP BY C.Product_,C.Country
ORDER BY C.Product_,Country_Sales_Amount DESC;

-- Hangi Ulkeler En Cok Kazanc Getiriyor
SELECT
Country,
SUM(Amount_) AS Total_Sales_Amount,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped
FROM chocolate_sales
GROUP BY Country
ORDER BY Total_Sales_Amount DESC;

-- Ulkelerin Ay Bazinda Satislari 
SELECT 
Country,
YEAR(Date_) AS Sales_Year,
MONTH (Date_) AS Sales_Month,
SUM(Amount_) AS Monthly_Boxes_Shipped,
SUM(Boxes_Shipped) AS Monthly_Boxes_Shipped
FROM chocolate_sales
GROUP BY Country, YEAR(Date_), MONTH(Date_)
ORDER BY Country, Sales_Year, Sales_Month;

-- Ulkelerin Sezon (Ceyrek) Bazinda Satislari
SELECT 
Country,
YEAR(Date_) AS Sales_Year,
DATEPART(QUARTER, Date_) AS Sales_Quarter,
SUM(Amount_) AS Quarterly_Sales_Amount,
SUM(Boxes_Shipped) AS Quarterly_Boxes_Shipped
FROM chocolate_sales
GROUP BY Country, YEAR(Date_), DATEPART(QUARTER, Date_)
ORDER BY Country, Sales_Year, Sales_Quarter;

-- Yillik Ortalama Birim Fiyat
SELECT 
YEAR(Date_) AS Sales_Year,
ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM chocolate_sales
GROUP BY YEAR(Date_)
ORDER BY Sales_Year;

-- Aylik Ortalama Birim Fiyat 
SELECT
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM chocolate_sales
GROUP BY YEAR(Date_), MONTH(Date_)
ORDER BY Sales_Year, Sales_Month;

-- Urun Bazinda Her Kutu Basina Dusen Birim Fiyat (Aylik)
SELECT 
Product_,
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM chocolate_sales
GROUP BY Product_, YEAR(Date_), MONTH(Date_)
ORDER BY Product_, Sales_Year, Sales_Month;

-- Ulkelere Gore Ortalama Birim Fiyat(Kutu Basina Dusen Fiyat)
SELECT 
Country,
ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM chocolate_sales
GROUP BY Country
ORDER BY Avg_Unit_Price DESC;

-- Zaman Icinde Ulkelere Gore Ortalama Birim Fiyat(Kutu Basina Dusen Fiyat)
SELECT 
Country,
YEAR(Date_) AS Sales_Year,
MONTH(Date_) AS Sales_Month,
ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM chocolate_sales
GROUP BY Country, YEAR(Date_), MONTH(Date_)
ORDER BY Country, Sales_Year, Sales_Month;

-- Kutu Sayisi ve Satis Tutari Iliskisi
SELECT 
Product_,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped,
SUM(Amount_) AS Total_Amount
FROM chocolate_sales
GROUP BY Product_
ORDER BY Total_Boxes_Shipped DESC;

-- Kutu Sayisi-Satis Tutari Iliskisi 
SELECT
Product_,
SUM(Boxes_Shipped) AS Total_Boxes_Shipped,
SUM(Amount_) AS Total_Amount
FROM chocolate_sales
GROUP BY Product_;

