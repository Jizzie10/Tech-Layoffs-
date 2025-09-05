# Data Analysis of Tech Company Layoffs (2020 - 2024)

## 📖 Project Overview
This project analysis trends in technology company layoffs over recent years. The goal is to identify which industries, countries, and company stages were mostly impacted and to uncover any temporal patterns through a comprehensive data cleaning and analysis.

## 🔧 Tools Used
- **Microsoft Excel:** For initial data cleaning
- **SQL (MySQL):** For advanced data cleaning, transformation, and analysis
- **Power BI:** For data visualisation and dashboard creation (Future enhancement)

## 📊 Dataset
The dataset contains information about tech company layoffs with the following columns:
- `Company`: Company name
- `Location_HQ`: Company headquarters location
- `Industry`: Industry sector
- `Laid_Off_Count`: Number of employees laid off
- `Percentage`: Percentage of workforce laid off (when available)
- `Date`: Date of layoff announcement
- `Stage`: Company development stage (Series A, B, C, IPO, etc.)
- `Country`: Company's home country
- `Funds_Raised`: Total funds raised by company (when available)

## 🗂️ Project Structure
```
Tech-Layoffs/
├── README.md
├── Tech Layoffs Scripts.sql
├── data/
│   └── (dataset would be here)
└── results/
    └── (analysis results would be here)
```

## 🧹 Data Preparation
The dataset underwent a two stage cleaning process:

1.  **Initial Exploration & Cleaning in Excel:**
    - Performed an initial review of the dataset to understand its structure and identify obvious issues.
    - Used Excel filters to quickly identify and remove some duplicate entries, inconsistent formatting, and removed source links.
    - Replaced empty gaps with NULL values to standardise the missing data before converting to CSV for SQL-based analysis.
    - This step was crucial for getting a high-level understanding of the data before writing complex SQL queries.

2.  **Comprehensive Cleaning in SQL:** The core cleaning was done mainly in SQL to ensure the process was clear and consistent.
    - **Duplicate Removal:** Created staging tables and used `ROW_NUMBER()` with `PARTITION BY` to systematically identify and remove exact duplicate records across all columns.
    - **Standardisation:**  
      - Trimmed extra spaces from company names using `TRIM()`
      - Converted date text to proper `DATE` type for accurate analysis
      - Standardised formatting across all text columns
    - **Handling NULLs:** Identified and removed records where critical fields (`Laid_off_count`, `Percentage`, `Funds_Raised`) were all NULL while preserving records with partial data.
    - The detailed, step by step SQL code for this process is available in the [`Tech Layoffs Script.sql`](Tech%20Layoffs%20Script.sql) file.

## 🔍 Key Questions Explored

1. What was the largest single layoff event (headcount and %)?
2. Which companies laid off their entire workforce (100%), and how many companies were there?
3. Which company had the highest total layoffs?
4. Among the 100% layoff companies, which had raised the most funding?
5. Which countries experienced the most layoffs?
6. Which industries and company stages were most affected?
7. How did layoffs trend over time (yearly, monthly, and cumulative rolling totals)?
8. What were the top 3 companies with the most layoffs each year?

## 📈 Key Findings

### 1. Largest Single Layoff Event (Headcount and %)
The Largest single layoff event (headcount) involved **14,000 employees**.  
The Maximum layoff percentage recorded is **100%**, (represented as 1.0 in the dataset). This indicates that the most significant layoff event involved 14,000 employees, while the highest layoffs percentage represents companies that shut down entirely.

### 2. Companies with 100% Layoffs
A total of **258 companies** experienced a 100% layoff, meaning they laid off their entire worforce. However, the number of employees affected in these 100% layoffs is generally smaller compared to the top 5 largest layoffs **(Tesla, SAP, Dell, Cisco, and Toshiba)**.

### 3. Company with the Highest Total Layoffs
The company with the largest single layoff event was **Tesla**, with 14,000 employees laid off.

**Note:** This number reflects the largest single layoff headcount in the dataset and not Tesla’s total workforce.

### 4. 100% Layoff Companies with Highest Funding
The company that raised the most funds before laying off 100% of it's employees was **Convoy**, a USA-based logistics company, raised **$1.1 billion** prior to the lay off.

### 5. Countries with Most Layoffs
The country with the most layoffs is the **United States** with a count of 271,689, followed by:  
- **Germany**: 27,147  
- **United Kingdom**: 26,028  
- **India**: 25,122  
- **Japan**: 12,000  
- **Israel**: 6,270  

### 6. Industries and Company Stages Most Affected
The layoffs were not distributed evenly across the tech sector, with specific industries and stages of company maturity bearing the consequences of the workforce reductions
  
**Most Affected Industries:**  
The Transportation industry was the most severely impacted by a signficant margin of 58,137 employees  
- Other: 50,493 employees  
- Hardware: 36,177 employees  
- Retail: 34,920 employees  
- Consumer: 32,760 employees  

**Most Affected Company Stages:**  
A clear majority of all layoffs occurred at mature, publicy traded companies
- Post-IPO: 237,000 employees  
- Acquired: 50,196 employees  
- Unknown: 39,912 employees
  
The layoffs at **Post-IPO** companies alone accounted for over a quarter of a million job cuts, reducing the totals from all other stages combined.

**Key Takeaway:** The data shows that the layoffs affected large, established companies with Post-IPO stage (237,000) and specific industries like Transportation, Hardware, and Retail. This suggests the cuts were a strategic response towards market corrections, investor pressure, and operational restructuring within this mature sectors, rather than early stage startups largely affected.

### 7. Layoff Trends Over Time
The analysis reveals a significant and accelerating trend in tech industry layoffs over the observed period.

**Yearly Trend:**  
There was a massive **123% year over year** increase in layoffs.  
- 2023: 121,920 employees  
- 2024: 272,748 employees (as of data capture)  

**Monthly Trend:**  
Layoffs were not evenly distributed. The beginning of 2024 saw an unexpected surge.
The single worst month was January 2024, with **102,321 layoffs** (over 37% of the entire year's total).
Other high volume months include November 2023 (25119), April 2024 (67,206), February 2024 (46,917) and May 2024 (29865). 

**Cumulative (Rolling) Total:**  
The cumulative total shows a dramatic inflection point which started in early 2024, indicating a rapid increase in workforce reduction across the tech sector.
The cumulative total grew steadily from **6,851 in July 2023 to 121,920 by the end of December 2023**.
In just the first six months of 2024, the cumulative total tripled, thereby skyrocketing to 394,668 by June 2024. 

**Key Takeaway:** The tech industry experienced a major wave of layoffs that began in the second half of 2023 and increased dramatically in the first half of 2024, particularly in January.

### 8. Top 3 Companies with Most Layoffs Each Year
The top three companies by layoff count varied between 2023 and 2024, with an obvious increase in the scale of layoffs at the top

**2023:** 
- VMware: 8,511 employees  
- Getir: 7,500 employees  
- Spotify: 4,500 employees  

**2024:**  
- Tesla: 43,500 employees  
- SAP: 24,000 employees  
- Dell: 18,000 employees  

**Key Takeaway:** The magnitude of layoffs at the top companies increased dramatically year over year. The leading company in 2024 (Tesla) conducted layoffs that were over five times larger than the leading company in 2023 (VMware). This reveals the overall market trend of accelerated workforce reductions in the tech sector.

## 🚀 How to Use This Project

### Prerequisites
- MySQL database system
- The tech layoffs dataset loaded into a database named `Tech_Layoffs`

### Setup Instructions
1. Clone this repository
2. Ensure your MySQL database is running
3. Load your dataset into the `Tech_Layoffs.layoffs` table
4. Execute the SQL script in your MySQL client

### Running the Analysis
Execute the entire SQL script to:
1. Clean and prepare the data
2. Perform all analytical queries
3. Generate insights about tech layoff trends

## 💡 Business Implications
This analysis provides valuable insights for:
- **Investors**: Understanding which sectors and company stages are most vulnerable to downsizing
- **Job Seekers**: Identifying potentially volatile sectors and companies
- **Policy Makers**: Recognising geographic regions most affected by tech industry changes
- **Company Executives**: Benchmarking against industry layoff trends

## 📝 Conclusion
This project demonstrates a complete data analysis workflow from raw data cleaning to actionable insights. The tech layoffs dataset offers a glimpse into how the technology sector has evolved and responded to economic pressures in recent years. Additionally, the analysis reveals patterns in how different company stages, industries, and geographic regions were affected by workforce reductions, providing valuable intelligence for various stakeholders in the tech ecosystem.

## 🎯 Acknowledgments
The dataset used in this analysis was sourced from:

- **Title:** Layoffs Dataset 2024 (2020 - 2024)
- **Creator:** Roger Lee
- **Original Publisher:** https://layoffs.fyi/
- **Source:** https://www.kaggle.com/datasets/theakhilb/layoffs-data-2022/data
- **Date Accessed:** August 22, 2025

**Note:** The specific dataset was downloaded on the above date. The source website may update layoff information continuously.*

- Inspired by the need to understand tech industry workforce trends and love for Data analyst❤️

## 🔮 Future Enhancement
1. Integration with Power BI for visualisation
