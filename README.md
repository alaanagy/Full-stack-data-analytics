# Full-stack-data-analytics
Building the data layer from scratch (pipeline) which include ETL process then performing analysis for getting insights,


![data-original](https://assets-global.website-files.com/5a1eb87c9afe1000014a4c7d/5ef5f253bc9342776b454244_6%20(1).jpeg)

- The first step in this project is to extract the dataset which will be used in the comming sections, Data extraction is done by different and a lot of methods, that depends on the source of the data which can be (CSV files, Database files, Web Scraping, JSON file and others).
Here, in our project, I will use dataset in the form of CSV file which is scrapped from Glassdoor website.

## Dataset Download
This data set includes information data science job posts on glassdoor website (CSV file). I attached dataset link for more details and for downloading option.
[Dataset link](https://www.kaggle.com/datasets/rashikrahmanpritom/data-science-job-posting-on-glassdoor)

- The second step after extracting data is to transform ,clean, and explore it using different methods.

- The third step after extracting data, making transforamtions is to load data into our datawarehouse, Datawarehouse is a special database design for the purpose of     collecting our all data files together in the smae place in order to make analysis and provide insights about our data.

- The final step is to use our cleaned data which is stored in DWH for making visualization, derive insights and build reports to help us developping our business and   making decisions.



## Project Sections and Files

- First of all, we must upload the data into Bigquery, there are many ways to do that, here I used python to upload data to avoid data inconsistence and modify schema.

  The data was scrapped from glassdoor's website. There are two versions of the data one is uncleaned and another one is cleaned.
  
  I will upload the 2 files into BigQuery but we will focus on the Uncleaned one to perform our transformations and dealing with different cases.
  
  I used Google Colab to run python script, also you can use jupyter notebook locally or any other IDE.
  [Uploading data into BigQuery](https://colab.research.google.com/drive/1qjFpXa7QWliEyJYVk_EDORcv86Nf0YoV?usp=sharing)
  
- I used dbt cloud to perform transformation and cleaning on data, so you have to connect bigquery and dbt first to be able to do that, this article will help you to     make the connection [connect BigQuery to dbt Cloud](https://docs.getdbt.com/guides/getting-started/getting-set-up/setting-up-bigquery).

  dbt is a data transformation tool that enables data analysts and engineers to transform, test and document data in the cloud data warehouse, I made transformations     using SQL but it is not the only way to do that as you can make it using python which is easier.

  After performing transformations, we run our model to create our new clean table in bigquery DWH to use it for analysis.

- Analysis process can be done also by different ways such as any visualization tool (Power BI, Tableau, Metabase, and Google Data studio) or it can be done using        python libraries such as matplotlib and seaborn.

  Here, I use Google Data Studio to making analysis and visualization as it is a google product and it it an available option direct to Google Bigqury.
  
  You will find the dashboard on Google Data studio [here](https://datastudio.google.com/reporting/e22983d1-4e79-467b-817c-f2a160bfd4b8)


## Software and Progrms

- Google Colab for uploading data to DWH using python
- Google Bigquery as our datawarehouse
- dbt cloud to perform transformations and calculations
- Google Data Studio for Analysis and Visualization

The below image is screenshot from dbt cloud contains necessary files i created for the project on dbt


![2](https://user-images.githubusercontent.com/49722916/192397556-1aae6c77-129c-446e-82d7-9e1189a0cece.PNG)


## Files

- Google Colab [Uploading data into BigQuery](https://colab.research.google.com/drive/1qjFpXa7QWliEyJYVk_EDORcv86Nf0YoV?usp=sharing)
- staging_DS_jobs.sql    contains Transformations and cleaning process in SQL
- Sources.yml            contains dataset and tables names which we use in our project
- schema.yml             contains your model and description about it and all the columns name and their description and tests

I provide below a screenshot for the dashboard, [for a total view and filteration process](https://datastudio.google.com/reporting/e22983d1-4e79-467b-817c-f2a160bfd4b8)

![1](https://user-images.githubusercontent.com/49722916/192584807-54e442ac-5026-4e86-9ff1-0658abfecdd7.PNG)

