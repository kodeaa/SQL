-- SQL Project - One Beautiful Morning
-- Medium post: https://medium.com/@aadata/sql-project-one-beautiful-morning-edb23d78563d

-- Situation
-- One day, it’s a beautiful morning for me as a Data Analyst Intern at Company Y. My mentor, Taylor, just got a task to analyze some client’s needs and offer me some part of it to hone my SQL skills. I’m ready.

-- Data Source: https://medium.com/@aadata/sql-project-one-beautiful-morning-edb23d78563d

-- Task & Action
-- 1. From data source, run a query to show a summary below:
-- https://miro.medium.com/max/1014/1*QhEjvQUVohbSqNKFw35yMg.png
-- Query:
SELECT me.Brand AS 'Brand',
 SUM(CASE WHEN MONTH(t.DateTRX) = 5 THEN 1 ELSE 0 END) AS 'Mei',
 SUM(CASE WHEN MONTH(t.DateTRX) = 6 THEN 1 ELSE 0 END) AS 'Juni',
 SUM(CASE WHEN MONTH(t.DateTRX) = 7 THEN 1 ELSE 0 END) AS 'Juli',
 SUM(CASE WHEN MONTH(t.DateTRX) = 8 THEN 1 ELSE 0 END) AS 'Agustus'
FROM transactions AS t
 INNER JOIN
 master_enroll AS me
 ON t.LocationTrx = me.ID
GROUP BY me.Brand
ORDER BY me.Brand DESC

-- 2. From data source, run a query to show a summary below:
-- https://miro.medium.com/max/1400/1*m1JTpI3pojX-si2Lnm3VQA.png
-- Query:
SELECT me.Brand_Level AS 'Brand Level',
 COUNT(t.ID) AS 'Total Transactions',
 COUNT(DISTINCT(t.MemberID)) AS 'Uniq Customer',
 SUM(CAST(REPLACE(REPLACE(t.PointEarn, ',', ''), '-', '0') AS INT)) AS 'PointEarn',
 SUM(CAST(REPLACE(REPLACE(t.PointBurn, ',', ''), '-', '0') AS INT)) AS 'PointBurn',
 SUM(CAST(REPLACE(REPLACE(t.ValueBeforeTax, ',', ''), '-', '0') AS INT)) AS 'ValueBeforeTax',
 SUM(CAST(REPLACE(REPLACE(t.ValueAfterTax, ',', ''), '-', '0') AS INT)) AS 'ValueAfterTax'
FROM transactions AS t
 INNER JOIN
 master_enroll AS me
 ON t.LocationTrx = me.ID
GROUP BY me.Brand_Level
ORDER BY me.Brand_Level DESC

-- 3. Create a graph for summary no. 1
-- I create dot plot using Tableau. Since there are no customer from May & June, I decide to plot the July & August data only and my mentor will give a footnote in the analysis deck.
-- https://miro.medium.com/max/1400/1*is9rOTmRjjvEBkl8IistpQ.jpeg

-- Results
-- My mentor use my queries results and graph for the analysis deck. We were happy with our work and so the clients and our company. It’s a good day!