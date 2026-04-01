#checking for null values
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN ROI IS NULL THEN 1 ELSE 0 END)               AS null_roi,
    SUM(CASE WHEN Acquisition_Cost IS NULL THEN 1 ELSE 0 END)  AS null_acquisition_cost,
    SUM(CASE WHEN Campaign_Type IS NULL THEN 1 ELSE 0 END)     AS null_campaign_type,
    SUM(CASE WHEN Channel_Used IS NULL THEN 1 ELSE 0 END)      AS null_channel,
    SUM(CASE WHEN Clicks IS NULL THEN 1 ELSE 0 END)            AS null_clicks,
    SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END)       AS null_impressions,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END)              AS null_date
FROM marketing_campaign_dataset mcd ;

#Obtaining Ranges for ChatGPT prompt
SELECT
    MIN(ROI) AS min_roi,
    MAX(ROI) AS max_roi,
    ROUND(AVG(ROI), 4) AS avg_roi,
    MIN(Acquisition_Cost) AS min_cost,
    MAX(Acquisition_Cost) AS max_cost,
    ROUND(AVG(Acquisition_Cost), 2) AS avg_cost,
    MIN(Clicks)  AS min_clicks,
    MAX(Clicks)  AS max_clicks,
    MIN(Impressions) AS min_impressions,
    MAX(Impressions) AS max_impressions
FROM marketing_campaign_dataset;

#cleaning data
CREATE TABLE campaigns_clean AS
SELECT
    Campaign_ID,
    TRIM(Company) AS Company,
    TRIM(Campaign_Type) AS Campaign_Type,
    TRIM(Target_Audience)   AS Target_Audience,
    CAST(Duration AS INTEGER) AS Duration,
    TRIM(Channel_Used) AS Channel_Used,
    CAST(Conversion_Rate AS REAL) AS Conversion_Rate,
    CAST(Acquisition_Cost AS REAL) AS Acquisition_Cost,
    CAST(ROI AS REAL) AS ROI,
    TRIM(Location) AS Location,
    TRIM(Language) AS Language,
    CAST(Clicks AS INTEGER) AS Clicks,
    CAST(Impressions AS INTEGER) AS Impressions,
    CAST(Engagement_Score AS INTEGER) AS Engagement_Score,
    TRIM(Customer_Segment)  AS Customer_Segment,
    Date
FROM marketing_campaign_dataset
WHERE ROI IS NOT NULL
  AND ROI > 0
  AND Acquisition_Cost IS NOT NULL
  AND Acquisition_Cost > 0
  AND Campaign_Type IS NOT NULL
  AND Channel_Used IS NOT NULL
  AND Duration >= 1
  AND Clicks <= Impressions;
