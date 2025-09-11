-- THIS SCRIPT PERFORMS A DATA CLEANING AND ANALYSIS ON TECH COMPANIES LAYOFFS (2020 - 2024)

-- DATA CLEANING
-- 1. Finding and Removing any duplicates
-- 2. Cleaning up and Standardising the data
-- 3. Tackling any empty or null values
-- 4. Exploratory Data analysis

-- Start of data exploration
SELECT *
FROM Tech_Layoffs.layoffs;

-- Creating a working copy to preserve the original data
CREATE TABLE Tech_layoffs.layoffs_staging
LIKE Tech_layoffs.layoffs;

-- Copying all the data over to a working table
INSERT INTO Tech_layoffs.layoffs_staging
SELECT *
FROM Tech_layoffs.layoffs;

-- A quick check to make sure it looks right
SELECT *
FROM Tech_layoffs.layoffs_staging;

-- 1. DUPLICATES REMOVAL
-- Creating a new table with identical structure
CREATE TABLE Tech_layoffs.layoffs_staging2
LIKE Tech_layoffs.layoffs_staging;

-- Inserted only unique records using temporary row_num() filtering
INSERT INTO Tech_layoffs.layoffs_staging2
SELECT 
    Company, Location_HQ, Industry, Laid_off_count, Percentage, `Date`, Stage, Country, Funds_Raised
FROM (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY Company, Location_HQ, Industry, Laid_off_count, Percentage, `Date`, Stage, Country, Funds_Raised
ORDER BY Company) AS row_num
FROM Tech_layoffs.layoffs_staging
) AS ranked
WHERE row_num = 1;

-- Verifying that no duplicates exist in the new table
WITH duplicate_check AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY Company, Location_HQ, Industry, Laid_off_count, Percentage, `Date`, Stage, Country, Funds_Raised) AS row_num
FROM Tech_layoffs.layoffs_staging2
)
SELECT COUNT(*) AS duplicate_count
FROM duplicate_check
WHERE row_num > 1;

-- 2. DATA STANDARDISATION 
-- Cleaning up company names by removing extra spaces
SELECT company, TRIM(company) 
FROM Tech_layoffs.layoffs_staging2;

UPDATE Tech_layoffs.layoffs_staging2
SET company = TRIM(company);

-- Reviewing distinct values to spot any inconsistencies with the header columns 
SELECT DISTINCT Location_HQ
FROM Tech_layoffs.layoffs_staging2
ORDER BY 1;

-- Converting date text to proper DATE type for better querying
ALTER TABLE Tech_layoffs.layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. HANDLING NULL VALUES
-- Removing specific records with critical missing values
DELETE
FROM Tech_layoffs.layoffs_staging2
WHERE Laid_off_count IS NULL
AND Percentage IS NULL
AND Funds_Raised IS NULL;

-- Confirming the deletion of null values
SELECT *
FROM Tech_layoffs.layoffs_staging2;

-- 4. EXPLORATORY DATA ANALYSIS
-- Cleaned Dataset viewing
SELECT *
FROM Tech_layoffs.layoffs_staging2;

-- Checking the current data types
DESCRIBE Tech_layoffs.layoffs_staging2;

-- Converting the Laid off column to proper INTEGER type
ALTER TABLE Tech_layoffs.layoffs_staging2 
MODIFY COLUMN Laid_off_count INT;

-- Checking the max values of laid off count and percentage
SELECT MAX(Laid_off_count), MAX(Percentage)
FROM Tech_layoffs.layoffs_staging2
WHERE Percentage IS NOT NULL;

-- Top 5 Companies with the biggest single layoffs
SELECT Company, Laid_off_count
FROM Tech_layoffs.layoffs_staging2
ORDER BY 2 DESC
LIMIT 5;

-- 2. Companies that laid off 100% of their workforce
SELECT DISTINCT Company, Location_HQ, Industry, Laid_off_count, Percentage, `Date`, Stage, Country, Funds_Raised
FROM Tech_layoffs.layoffs_staging2
WHERE Percentage = 1;

-- Total count of of 100% lay offs
SELECT COUNT(*) AS Total_1_percent_layoffs
FROM Tech_layoffs.layoffs_staging2
WHERE Percentage = 1;

-- 3. Companies with the most total layoffs 
SELECT Company, SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Company
ORDER BY 2 DESC
LIMIT 10;

-- 4. Funds raised in companies with 100% layoffs and ordering by funds raised
SELECT DISTINCT Company, Location_HQ, Industry, Laid_off_count, Percentage, `Date`, Stage, Country, Funds_Raised
FROM Tech_layoffs.layoffs_staging2
WHERE Percentage = 1
ORDER BY Funds_raised DESC;

-- 5. Countries with the most total layoffs
SELECT Country, SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Country
ORDER BY 2 DESC
LIMIT 10;

-- Locations with the most total layoffs  (Optional)
SELECT Location_HQ, SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Location_HQ
ORDER BY 2 DESC
LIMIT 10;

-- 6. Industries with the most lay offs
SELECT Industry, SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Industry
ORDER BY 2 DESC
-- LIMIT 10 (Optional)
;

-- Layoffs by company Stage
SELECT Stage, SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Stage
ORDER BY 2 DESC
-- LIMIT 10 (Optional)
;

-- 7. Yearly layoff trends
SELECT Year(Date), SUM(Laid_off_count)
FROM Tech_layoffs.layoffs_staging2
GROUP BY Year(Date)
ORDER BY 2 ASC
-- LIMIT 10 (Optional)
;

-- Monthly layoff trends
SELECT SUBSTRING(Date,1,7) AS Dates, SUM(Laid_off_count) AS Total_laid_off
FROM Tech_layoffs.layoffs_staging2
GROUP BY Dates
ORDER BY Dates ASC;

-- Cumulative total Layoffs over time
WITH DATE_CTE AS (
SELECT SUBSTRING(Date, 1, 7) as Dates, SUM(Laid_off_count) AS Total_laid_off
FROM Tech_layoffs.layoffs_staging2
GROUP BY SUBSTRING(Date, 1, 7)
)
SELECT Dates, SUM(Total_laid_off) OVER (ORDER BY Dates ASC) as Rolling_total_layoffs
FROM DATE_CTE
ORDER BY Dates ASC;

-- 8. Top 3 Companies with most layoffs each year
WITH Company_Year AS (
SELECT Company, Year(Date) AS years, SUM(Laid_off_count) AS Total_laid_off
FROM Tech_layoffs.layoffs_staging2
GROUP BY Company, Year(Date)
), Company_Year_Rank AS (
SELECT Company, Years, Total_laid_off, 
  DENSE_RANK() OVER (
    PARTITION BY Years
    ORDER BY Total_laid_off DESC) AS Ranking
FROM Company_Year
)
SELECT Company, Years, Total_laid_off, Ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- END