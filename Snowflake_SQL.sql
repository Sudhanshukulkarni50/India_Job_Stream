/* ============================================================
   1. DATABASE & SCHEMA SETUP
   ============================================================ */

CREATE OR REPLACE DATABASE employee_monitor;
CREATE OR REPLACE SCHEMA employee;


/* ============================================================
   2. FILE FORMAT (JSON)
   ============================================================ */

CREATE OR REPLACE FILE FORMAT file_format_1
    TYPE = JSON;


/* ============================================================
   3. STORAGE INTEGRATION FOR AZURE
   ============================================================ */

CREATE OR REPLACE STORAGE INTEGRATION emp_azure_connect
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = AZURE
    ENABLED = TRUE
    AZURE_TENANT_ID = '7552f1b3-7399-4cab-a75d-f0b20622e8bf'
    STORAGE_ALLOWED_LOCATIONS = (
        'azure://employeedata12113.blob.core.windows.net/jobdata'
    );

DESC STORAGE INTEGRATION emp_azure_connect;


/* ============================================================
   4. RAW TABLE (VARIANT)
   ============================================================ */

CREATE OR REPLACE TABLE emp_data (
    data VARIANT
);


/* ============================================================
   5. STAGE CREATION (AZURE BLOB → SNOWFLAKE)
   ============================================================ */

CREATE OR REPLACE STAGE emp_stage
    STORAGE_INTEGRATION = emp_azure_connect
    URL = 'azure://employeedata12113.blob.core.windows.net/jobdata'
    FILE_FORMAT = file_format_1;


/* ============================================================
   6. NOTIFICATION INTEGRATION FOR AUTO-INGEST
   ============================================================ */

CREATE OR REPLACE NOTIFICATION INTEGRATION emp_notify
    ENABLED = TRUE
    TYPE = QUEUE
    NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
    AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://employeedata12113.queue.core.windows.net/empqueue'
    AZURE_TENANT_ID = '7552f1b3-7399-4cab-a75d-f0b20622e8bf';

DESC NOTIFICATION INTEGRATION emp_notify;


/* ============================================================
   7. SNOWPIPE (AUTO INGEST FROM AZURE BLOB)
   ============================================================ */

CREATE OR REPLACE PIPE emp_pipe
    AUTO_INGEST = TRUE
    INTEGRATION = emp_notify
AS
    COPY INTO emp_data
    FROM @emp_stage;


/* Debug check */
SELECT * FROM emp_data;
-- TRUNCATE emp_data;  -- optional


/* ============================================================
   8. STREAM FOR CHANGE CAPTURE
   ============================================================ */

CREATE OR REPLACE STREAM job_stream 
    ON TABLE emp_data;

SELECT * FROM job_stream;


/* ============================================================
   9. FINAL CLEAN TABLE STRUCTURE
   ============================================================ */

CREATE OR REPLACE TABLE emp_data_1 (
    job_id               STRING,
    title                STRING,
    company              STRING,
    location             STRING,
    salary_min           FLOAT,
    salary_max           FLOAT,
    contract_type        STRING,
    category             STRING,
    description_snippet  STRING,
    created_at           TIMESTAMP,
    redirect_url         STRING,
    skills               ARRAY,
    source               STRING,
    ingested_at          TIMESTAMP
);


/* ============================================================
   10. TASK FOR AUTOMATED ETL (STREAM → CLEAN TABLE)
   ============================================================ */

CREATE OR REPLACE TASK emp_task
    WAREHOUSE = compute_wh
    SCHEDULE = '1 minute'
AS
MERGE INTO emp_data_1 t
USING (
    SELECT
        data:job_id::string AS job_id,
        data:title::string AS title,
        data:company::string AS company,
        data:location::string AS location,
        data:salary_min::float AS salary_min,
        data:salary_max::float AS salary_max,
        data:contract_type::string AS contract_type,
        data:category::string AS category,
        data:description_snippet::string AS description_snippet,
        TRY_TO_TIMESTAMP_NTZ(data:created::string) AS created_at,
        data:redirect_url::string AS redirect_url,
        data:skills AS skills,
        data:source::string AS source,
        data:ingested_at::timestamp AS ingested_at
    FROM job_stream
) s
ON t.job_id = s.job_id

WHEN MATCHED THEN UPDATE SET
    title               = s.title,
    company             = s.company,
    location            = s.location,
    salary_min          = s.salary_min,
    salary_max          = s.salary_max,
    contract_type       = s.contract_type,
    category            = s.category,
    description_snippet = s.description_snippet,
    created_at          = s.created_at,
    redirect_url        = s.redirect_url,
    skills              = s.skills,
    source              = s.source,
    ingested_at         = s.ingested_at

WHEN NOT MATCHED THEN INSERT VALUES (
    s.job_id, s.title, s.company, s.location, s.salary_min, s.salary_max,
    s.contract_type, s.category, s.description_snippet,
    s.created_at, s.redirect_url, s.skills, s.source, s.ingested_at
);


/* ============================================================
   11. START TASK
   ============================================================ */

ALTER TASK emp_task RESUME;


/* ============================================================
   12. FINAL TABLE CHECK
   ============================================================ */

SELECT * FROM emp_data_1;
