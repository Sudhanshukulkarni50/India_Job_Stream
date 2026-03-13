# 📊 India Job Market Real-Time Analytics Pipeline

A complete **end-to-end Data Engineering + Analytics project** that collects live job listings from across India and processes them using a fully automated cloud data pipeline.

Built using:

**Python • Azure Blob Storage • Snowflake • Power BI • Adzuna API**

---

# 🚀 Project Overview

This project collects **live job listings from 100+ Indian cities** using the **Adzuna Job Search API** and processes them through a real-time cloud pipeline.

The data pipeline automatically ingests, transforms, and analyzes job market data to generate insights such as:

- Top hiring cities
- Most active companies
- Trending job roles
- Industry hiring patterns
- Salary transparency
- Fresher vs experienced demand

The final insights are visualized through an **interactive Power BI dashboard**.

---

# 🏗️ Architecture
Adzuna API
│
▼
Python Script
(API Fetch + JSON Creation + Azure Upload)
│
▼
Azure Blob Storage
│
▼
Snowpipe (Auto Ingestion)
│
▼
Snowflake RAW Table
│
▼
Stream (Change Data Capture)
│
▼
Task (Scheduled ETL - Every 1 min)
│
▼
Clean Table (EMP_DATA_1)
│
▼
Power BI Dashboard


This architecture enables **near real-time analytics of the Indian job market.**

---

# 🧰 Technologies Used

## 🔹 Programming

**Python**

Used for:

- Fetching data from Adzuna API
- Converting API response to JSON
- Uploading files to Azure Blob Storage

**SQL Transformations**

Used inside Snowflake for:

- Data cleaning
- Data transformation
- Incremental data processing

---

## ☁️ Cloud Storage

**Azure Blob Storage**

- Stores raw job data as JSON files
- Acts as staging storage for Snowflake ingestion

**Storage Integration**

- Secure connection between Azure Blob Storage and Snowflake

---

## ❄️ Snowflake (Cloud Data Warehouse)

Snowflake manages ingestion, transformation, and storage of job market data.

Components used:

**Snowpipe**

- Automatically loads new JSON files from Azure Blob Storage
- Enables real-time ingestion

**Streams**

- Tracks new or changed data
- Implements Change Data Capture (CDC)

**Tasks**

- Scheduled SQL jobs running every **1 minute**
- Processes new data and merges into clean tables

**Stages**

- External storage reference pointing to Azure Blob Storage

---

## 📊 Analytics & Visualization

**Power BI**

Creates an interactive dashboard showing:

- Hiring trends
- Top job roles
- Hiring companies
- Salary patterns
- Industry demand
- Geographic hiring distribution

---

## 🌐 External API

**Adzuna Job Search API**

Provides live job data including:

- Job title
- Company name
- Location
- Salary range
- Job category
- Experience level

The pipeline collects job listings from **100+ cities across India.**

---

# ⚙️ How the Data Pipeline Works

## 1️⃣ Data Collection (Python)

A Python script performs the following steps:

- Calls the Adzuna Job API
- Fetches job listings from multiple Indian cities
- Converts data into JSON format
- Uploads JSON files to Azure Blob Storage

---

## 2️⃣ Snowflake Data Ingestion

Snowpipe automatically detects new JSON files in Azure Blob Storage and loads them into a **RAW table**:
emp_data


Data is stored using the **VARIANT data type** for flexible schema handling.

---

## 3️⃣ Stream + Task Automation

### Stream

Tracks newly inserted records from the RAW table.

### Task

Runs every **1 minute** and performs:

- Data cleaning
- Data transformation
- Deduplication
- Incremental merge

The final processed data is stored in:
emp_data_1


This table serves as the **analytics-ready dataset**.

---

# 📊 Power BI Dashboard Insights

The dashboard provides real-time insights into India's hiring market.

### Key Metrics

✔ Total Job Listings

✔ Top Hiring Cities

✔ Top Hiring Companies

✔ Trending Job Roles

✔ Industry-wise Hiring

✔ Salary Disclosed vs Not Disclosed

✔ Fresher vs Experienced Demand

✔ Daily Hiring Trends

✔ India Geographic Hiring Map

---

# 📈 Example Insights Generated

The dashboard can answer questions such as:

- Which cities are hiring the most?
- Which companies are actively recruiting?
- Which roles are trending in the job market?
- How many companies disclose salary information?
- What is the demand for freshers vs experienced professionals?

---

# 📊 Data Pipeline Features

- Automated ingestion
- Near real-time updates
- Scalable cloud architecture
- Incremental data processing
- Interactive business intelligence dashboard

---

# 🎯 Project Outcome

This project demonstrates how a **modern cloud data pipeline** can transform raw API data into actionable business insights.

Key capabilities shown:

- Data Engineering
- Cloud Storage Integration
- Real-time Data Ingestion
- Incremental Data Processing
- Data Warehousing
- Business Intelligence & Visualization

---

# 📌 Future Improvements

Possible enhancements include:

- Airflow orchestration
- Data quality checks
- Machine learning for job trend prediction
- Salary prediction models
- Real-time streaming pipeline

---

⭐ This project showcases practical skills in **Data Engineering, Cloud Data Pipelines, and Analytics Visualization**.
