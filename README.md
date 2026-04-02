# Marketing Campaign ROI Prediction

Predicting ROI from 200,000 marketing campaigns using linear regression and random forest. The goal was to compare a simple interpretable model against a more powerful one, and to test whether GPT's intuition about channel performance holds up against real data.

---

## The Question

Given a campaign's spend, channel, type, audience, duration, and engagement, can you predict its ROI before it runs? And which factors matter most when deciding where to put budget?

---

## Dataset

**Marketing Campaign Performance Dataset** from Kaggle. 200,000 rows, two years of campaign data across five channels and five campaign types.

---
## Workflow

### 1. SQL — Clean and Explore

Before touching Python, I ran the full dataset through SQLite to clean it and answer business questions with aggregations.

**SQL analysis queries:**
- Average ROI by channel and month
- Channel ranking by historical ROI
- Campaign type performance comparison
- Customer segment ROI breakdown
- Monthly trend across both years

### 2. ChatGPT Baseline

Before running any model, I pasted the dataset ranges profile into ChatGPT and asked it to predict which features would correlate most strongly with ROI, and rank the campaign types by expected performance.

GPT's predictions:

Predicted highest ROI Campaign Types (ranked)
	1.	Search
Captures high intent users actively looking for solutions, leading to the highest conversion efficiency and ROI.
	2.	Email
Targets warm audiences with near zero marginal distribution cost, producing strong returns when lists are qualified.
	3.	Influencer
Delivers trust driven conversions and strong engagement, especially within niche segments.
	4.	Social Media
Balances scale and targeting but suffers from lower intent compared to search and email.
	5.	Display
Drives awareness at scale but produces weak conversion efficiency, making ROI the lowest.

### 3. Python — Feature Engineering

- Label encoded all categorical columns
- Added click through rate (CTR) as a derived feature: Clicks / Impressions

### 4. Linear Regression

Trained first to establish an interpretable baseline. A linear model assumes that each feature contributes a fixed amount to ROI regardless of what the other features are doing. That assumption works well when relationships are straightforward.

**Results:**
- R²: -0.0002
- RMSE: 1.7356

The coefficients are readable. Every additional unit of CTR adds ~0.0178 to predicted ROI. That makes it easy to explain to a non-technical stakeholder.

### 8. GPT Baseline vs. Actual Results

**Where GPT was right: Conversion efficiency is the strongest driver of ROI. GPT predicted that conversion rate related metrics would dominate, and the model confirms this through CTR being one of the most influential variables

---

## Key Findings

ROI does not follow simple linear relationships, as shown by the near zero R² score, indicating that campaign performance depends on more complex interactions between variables.
Conversion efficiency (CTR) is a stronger predictor of ROI than scale based metrics like clicks and impressions, confirming that quality of engagement matters more than volume.
Channel selection and audience targeting significantly influence ROI, suggesting that platform dynamics and targeting strategy play a larger role than expected.

---


## Tools Used

- **SQLite + DB Browser** for data cleaning and exploratory aggregations
- **Python 3** with scikit-learn, pandas, matplotlib
- **ChatGPT** as a pre-modeling baseline to compare intuition against evidence

---

## What This Project Demonstrates

- Regression modeling: when a simple model is good enough vs. when it is not
- The tradeoff between interpretability and accuracy, and how to use both
- SQL as a first pass before modeling, not an afterthought
- Using AI generated predictions as a testable hypothesis, then validating or overriding with data
