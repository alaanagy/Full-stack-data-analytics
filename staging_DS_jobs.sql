{{ config(materialized='table') }}

WITH CTE AS 
(
SELECT
    Job_title,
    Job_Description,
    CAST(REGEXP_EXTRACT (SPLIT(Salary_estimate_range , '-')[OFFSET(0)], r"[0-9]+") As INT) as job_min_salary ,
    CAST(REGEXP_EXTRACT (SPLIT(Salary_estimate_range , '-')[OFFSET(1)], r"[0-9]+") AS INT) as job_max_salary ,
    CAST(REGEXP_EXTRACT (SPLIT(Salary_estimate_range , '-')[OFFSET(0)], r"[0-9]+") As INT) || '-' 
    || CAST(REGEXP_EXTRACT (SPLIT(Salary_estimate_range , '-')[OFFSET(1)], r"[0-9]+") AS INT) as salary_range,
    
    CASE 
        WHEN Job_post_rating =-1    THEN  Company_Name 
        ELSE LEFT(Company_Name, LENGTH(Company_Name) - 3) 
    END as Company_Name,

    CASE 
        WHEN Job_post_rating =-1    THEN  0.0 
        ELSE Job_post_rating
    END as Job_post_rating,

        Job_Location,
    CASE 
        WHEN Job_Location LIKE '%,%'      THEN RIGHT(Job_Location, 2) 
        ELSE Job_Location
    END as job_location_state,

    CASE 
        WHEN Company_Headquarters = '-1'      THEN 'Unknown'
        ELSE Company_Headquarters
    END as Company_Headquarters,

    CASE    
        WHEN  Company_size = '-1' or Company_size = 'Unknown'     THEN 'Unknown' 
        ELSE  Company_size
    END as Company_size,

    CASE 
        WHEN Company_size = '-1' or Company_size = 'Unknown'     THEN 'Unknown'
        WHEN Company_size = '1 to 50 employees' THEN 'Small Enterprise'
        WHEN Company_size = '51 to 200 employees' or Company_size = '201 to 500 employees' THEN 'Medium Enterprise'
        ELSE 'Large Enterprise'
    END as Company_size_Categories,

    CASE    
        WHEN  CAST(Company_founded_at AS STRING) = '-1'    THEN 'Unknown' 
        ELSE  CAST(Company_founded_at AS STRING)
    END as Company_founded_at,

    CASE 
        WHEN CAST(Company_founded_at AS STRING) = '-1' THEN 'Unkown'
        ELSE cast((2022 - Company_founded_at) AS STRING)  
    END AS company_age, 

    CASE    
        WHEN  Company_ownership = '-1'     THEN 'Unknown' 
        ELSE  Company_ownership
    END as Company_ownership,

    CASE    
        WHEN  Company_industry = '-1'     THEN 'Unknown' 
        ELSE  Company_industry
    END as 	Company_industry,

    CASE    
        WHEN  	Company_Sector = '-1'     THEN 'Unknown' 
        ELSE  	Company_Sector
    END as 	Company_Sector,

    CASE    
        WHEN  Comapny_Revenue_range = '-1' or Comapny_Revenue_range ='Unknown / Non-Applicable'    THEN 'Unknown' 
        ELSE  Comapny_Revenue_range
    END as 	Comapny_Revenue_range,
    
    CASE    
        WHEN  	Job_title LIKE '%Senior%' or Job_title LIKE '%Sr%' or Job_title LIKE '%senior%'    THEN 'senior' 
        WHEN  	Job_title LIKE '%Lead%' or Job_title LIKE '%lead%'     THEN 'Lead'
        ELSE  	'Junior'
    END as 	Job_Seniority,

    CASE 
        WHEN Job_Description LIKE '%python%' or Job_Description LIKE '%Python%'   THEN 1
        ELSE 0
    END as has_python,

    CASE 
        WHEN Job_Description LIKE '%Spark%' or Job_Description LIKE '%spark%'   THEN 1
        ELSE 0
    END as has_spark,
    CASE 
        WHEN Job_Description LIKE '%Excel%' or Job_Description LIKE '%excel%'   THEN 1
        ELSE 0
    END as has_excel,
    CASE 
        WHEN Job_Description LIKE '%Amazon Web Services%' or Job_Description LIKE '%AWS%'  or Job_Description LIKE '%aws%' THEN 1
        ELSE 0
     END as has_AWS, 
    CASE 
        WHEN Job_Description LIKE '%Machine Learning%' or Job_Description LIKE '%machine learning%' or Job_Description LIKE '%Machine learning%'    THEN 1
        ELSE 0
    END as has_machine_learning,

    CASE 
        WHEN Job_Description LIKE '%Big Data%' or Job_Description LIKE '%Big data%' or Job_Description LIKE '%big data%'    THEN 1
        ELSE 0
    END as has_big_data,

    CASE 
        WHEN Job_Description LIKE '%Tableau%' or Job_Description LIKE '%tableau%'    THEN 1
        ELSE 0
    END as has_tableau,

    CASE 
        WHEN Job_Description LIKE '%Data Visualization%' or Job_Description LIKE '%data visualization%' 
             or Job_Description LIKE '% Visualization%' or Job_Description LIKE '% visualization%'   THEN 1
        ELSE 0
    END as has_data_visualization,

    CASE 
        WHEN Job_Description LIKE '%SQL%' or Job_Description LIKE '%sql%'   THEN 1       
        ELSE 0
    END as has_SQL,

        CASE 
            WHEN Job_Description LIKE '%NoSQL%'    THEN 1
            ELSE 0
        END as has_NoSQL,

    CASE 
        WHEN Job_Description LIKE '%Hadoop%'    THEN 1
        ELSE 0
    END as has_Hadoop,

    CASE 
        WHEN Job_Description LIKE '%Power BI%'   THEN 1
         ELSE 0
    END as has_Power_BI,

    CASE 
        WHEN Job_Description LIKE '%cloud%' or  Job_Description LIKE '%Cloud%'  THEN 1
        ELSE 0
    END as has_cloud,

    CASE 
        WHEN Job_Description LIKE '%Business Intelligence%' or  Job_Description LIKE '%business intelligence%' 
             or Job_Description LIKE '%BI%' THEN 1
        ELSE 0
    END as has_business_intelligence,

     ROW_NUMBER() OVER ( PARTITION BY Job_Description ) as row_num
FROM 
    --jobs.raw_ds_unclean_jobs 
    {{ source ('jobs', 'raw_ds_unclean_jobs')}}
)
Select *
FROM  CTE
WHERE row_num = 1 


