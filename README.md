India Job Market Real-Time Analytics Pipeline

A complete end-to-end Data Engineering + Analytics project built using:
Python • Azure Blob Storage • Snowflake • Power BI • Adzuna API

🚀 Project Overview

This project collects live job listings from 100+ Indian cities using Adzuna API and processes them using a fully automated cloud pipeline.
Data passes through Azure Blob Storage → Snowflake (Snowpipe, Stream, Task) → Power BI dashboard.

This system delivers real-time hiring insights, including top cities, top companies, trending roles, salary transparency, industries hiring, and fresher vs experienced demand.

Architecture Flow:

Adzuna API 
    ↓
Python Script (JSON creation + Azure upload)
    ↓
Azure Blob Storage
    ↓
Snowpipe (Auto-Ingest)
    ↓
Snowflake RAW Table
    ↓
Stream (Change Data Capture)
    ↓
Task (Scheduled ETL every 1 min)
    ↓
Clean Table (EMP_DATA_1)
    ↓
Power BI Dashboard

🧰 Technologies Used
🔹 Programming & Scripting

Python – API calls, JSON creation, Azure upload automation

SQL Transformations – Data cleaning, formatting, and modeling inside Snowflake

🔹 Cloud Storage

Azure Blob Storage – Raw job data storage (JSON files)

Storage Integration – Secure connection between Azure and Snowflake

🔹 Snowflake (Data Warehouse)

Snowpipe – Real-time auto-ingestion from Azure

Streams – Change Data Capture (CDC) for incremental data

Tasks – Scheduled ETL running every 1 minute

Stages – External storage reference for loading data

🔹 Analytics & Visualization

Power BI – Interactive dashboard for job market insights

🔹 External API

Adzuna Job Search API – Live job data from 100+ Indian cities

📊 Dashboard Highlights

✔ Total Job Listings

✔ Top Hiring Cities

✔ Top Hiring Companies

✔ Top Job Roles

✔ Industry-wise Hiring

✔ Salary Disclosed vs Not Disclosed

✔ Fresher vs Experienced Demand

✔ Daily Hiring Trend

✔ India Map View

⚙️ How the Pipeline Works
1️⃣ Data Collection (Python)

Fetches job data using Adzuna API

Converts to JSON

Uploads to Azure Blob Storage

2️⃣ Snowflake Ingestion

Snowpipe auto-loads every new JSON file

Stored in emp_data (VARIANT)

3️⃣ Stream + Task Automation

Stream tracks new job records

Task runs every 1 minute

Merges + transforms clean data into emp_data_1

4️⃣ Power BI

Connects to Snowflake

Visualizes all hiring insights dynamically
