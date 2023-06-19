-- Query - b
SELECT week_number AS "Week Number", COUNT(DISTINCT(msisdn)) AS "Number of customers", COUNT(CASE WHEN system_status = 'ACTIVE' THEN 1 END) AS "Active customers" FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE system_status != 'NA'
GROUP BY week_number
ORDER BY week_number;

SELECT COUNT(DISTINCT(msisdn)) AS "Number of customers", COUNT(Distinct CASE WHEN system_status = 'ACTIVE' THEN MSISDN END) AS "Active customers" FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE system_status != 'NA';

-- Query - c
SELECT week_number AS "WEEK NUMBER",
       gender,
       SUM(revenue_usd) AS "TOTAL REVENUE"
FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP) OR week_number = 35)
  AND gender IN ('MALE', 'FEMALE')
GROUP BY week_number, gender
ORDER BY week_number,gender;

SELECT gender,
       SUM(revenue_usd) AS "TOTAL REVENUE"
FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE gender IN ('MALE', 'FEMALE')
GROUP BY gender
ORDER BY gender;

-- Quey - d
SELECT
  week_number,
    CAST((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) AS VARCHAR) AS age,
  SUM(revenue_usd) AS revenue_usd
FROM
  MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE
  (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP) OR week_number = 35) and year_of_birth!='NA'
GROUP BY
  week_number, age
ORDER BY
  week_number,CAST(age AS INT);

SELECT
    CAST((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) AS VARCHAR) AS age,
    SUM(revenue_usd) AS revenue_usd
FROM
MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where year_of_birth!='NA'
GROUP BY
age
ORDER BY CAST(age AS INT);

-- Query - e

SELECT week_number, value_segment,CAST((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) AS VARCHAR) AS age,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP) OR week_number = 35) and year_of_birth!='NA' group by week_number,value_segment,age order by week_number,value_segment,CAST(age AS INT);

SELECT value_segment,sum(revenue_usd),CAST((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) AS VARCHAR) AS age from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where year_of_birth!='NA' group by value_segment,age order by value_segment,CAST(age AS INT);


-- Query - f

SELECT week_number, mobile_type, SUM(revenue_usd)
FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)
        OR week_number = 35)
  AND mobile_type != 'NA'
GROUP BY week_number, mobile_type
ORDER BY week_number, mobile_type;


SELECT mobile_type,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE mobile_type != 'NA' group by mobile_type order by mobile_type;

-- Query - g

SELECT week_number, brand_name,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)
        OR week_number = 35)
  AND brand_name != 'NA'
 group by week_number,brand_name order by week_number,brand_name;

SELECT brand_name,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where brand_name != 'NA' group by brand_name order by brand_name;

-- Query - h
SELECT week_number, os_name,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)
        OR week_number = 35) and os_name!='NA'
group by week_number,os_name order by week_number,os_name;

SELECT os_name,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where os_name!='NA' group by os_name order by os_name;

-- Query - i 
SELECT week_number, os_vendor,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and os_vendor!='NA' group by week_number,os_vendor order by week_number,os_vendor;

SELECT os_vendor,sum(revenue_usd) from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where os_vendor!='NA' group by os_vendor order by os_vendor;

-- Query - j

SELECT week_number,os_name, count(distinct msisdn) as no_of_customers from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and os_name!='NA' group by week_number,os_name order by week_number,os_name;

SELECT os_name, count(distinct msisdn) as no_of_customers from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where os_name!='NA' group by os_name order by os_name;

-- Query - k

SELECT week_number, count(distinct msisdn) as no_of_customers,brand_name from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and brand_name
!='NA' group by week_number,brand_name order by week_number,brand_name;

SELECT brand_name,count(distinct msisdn) as no_of_customers from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where brand_name!='NA' group by brand_name order by brand_name;

-- Query - l

SELECT week_number,mobile_type, count( distinct msisdn) as no_of_customers from mock_db.my_schema.final_data_table WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and mobile_type
!='NA' group by week_number,mobile_type order by week_number,mobile_type;

SELECT count(distinct msisdn) as no_of_customers,mobile_type from MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP where mobile_type!='NA' group by mobile_type order by mobile_type;

-- Query - m

SELECT
  week_number,
  brand_name,
  MAX(revenue_usd) AS highest_revenue,
  MIN(revenue_usd) AS lowest_revenue
FROM
  MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and brand_name
!='NA' 
GROUP BY
  week_number,
  brand_name
ORDER BY
  week_number, brand_name;

  -- Query - n
SELECT
  week_number,
  os_name,
  MAX(revenue_usd) AS highest_revenue,
  MIN(revenue_usd) AS lowest_revenue
FROM
  MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and os_name
!='NA' 
GROUP BY
  week_number,
  os_name
ORDER BY
  week_number, os_name;

-- Query - o

SELECT
    CONCAT(FLOOR((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth) - 1) / 10) * 10, ' - ', CEIL((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) / 10) * 10) AS age_segment,
  brand_name,
  COUNT(*) AS count
FROM
MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and brand_name
!='NA' and year_of_birth!='NA'
GROUP BY
  age_segment,
  brand_name
ORDER BY
  age_segment;


-- Query - p

SELECT
    CONCAT(FLOOR((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth) - 1) / 10) * 10, ' - ', CEIL((YEAR(CURRENT_DATE()) - TO_NUMBER(year_of_birth)) / 10) * 10)
  AS age_segment,
  os_name,
  COUNT(*) AS count
FROM
MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP
WHERE (week_number < (SELECT MAX(week_number) FROM MOCK_DB.MY_SCHEMA.MASTER_TABLE_BACKUP)OR week_number = 35) and os_name
!='NA' and year_of_birth!='NA'
GROUP BY
  age_segment,
  os_name
ORDER BY
  age_segment,
  os_name;
