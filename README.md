# Heart-Failure-Analysis

## An Analysis of Heart Attack Causes and Trends

## The Dataset

This data was gathered in `real time` from a nearby hospital in our locality from january to december 2022
## Methodology

As there were no Patient ID keys for any of the records before, the original dataset was cleaned in `Excel`using `power query editor` by assigning `Patient ID` keys to each record and replacing the `1/0` values in the `sex` column to `M/F` and finally rounded the `age` values. The heart failure dataset will be subjected to exploratory analysis in this notebook to look for trends and summary tables. Upon the completion of the exploratory analysis, I will load the data to `Power BI `for in-depth visualisation.

*Note*: The most important piece of this dataset is the hardest part to understand. The "time" attribute denotes the last status of the patient observed by the doctors, who collected the data, until the patient either died or they lost contact. Losing contact will be considered a "survival" by me and denoted as a "0" as a data point. Any 1's in this attribute are officially counted as deaths at the follow-up point by the doctors. This is a small inconsistency in the data set from this longitudinal study for my analysis, but will still offer enough accuracy for insights.

## Recommended Analysis
##### The following questions are recommended by hospital management.
1. Which age groups are at the highest risk of heart disease?
2. Which attribute contained in the dataset is the highest indicator of heart disease?
3. Are certain attributes in the dataset more likely to affect men more than women, or vise versa?
4. Are there any key indicators that deceased patients show that might help us learn how to decrease the mortality rate?

## Using SQL

The SQL notebook, "Heart Failure Analysis.sql," contained within the repository, outlines my use of SQL to find exporatory trends before moving into Power BI for more complex analysis.

### Notebook Steps

1. The early part of the notebook I queried simple breakdowns to get an idea of how attributes distributed across each sex.

2. I aggregated a histogram of ages to find distributions of age groups most likely to have a heart attack, and generate averages for each age group in key attributes.

3. I further segmented ages into 10 bins to increase the n for outlier ages. This allowed for more trustworthy results across most age bins.


## Analyzing in Power BI

PDF Export of my Power BI pages is contained in the Heart Failure Analysis dashboard

### PAGES:
 
1. Dashboard
2. Metrics
3. Time Trends
4. Level Comparisons by Gender
5. Mortality Rates
6. Age Bin Analysis
7. Time Quadrant Analysis

### Building the Dashboard

1. I imported the data into Power BI.
2. No PowerQuery transformations were needed due to the editing of the raw data in Excel.
3. Used DAX to write a Mortality Rate metric
  - Mortality Rate = SUM(heart_failure_clinical_records_dataset[DEATH_EVENT]) / COUNT(heart_failure_clinical_records_dataset[DEATH_EVENT])
4. Created a series of pages with exploratory visuals in order to discover the most insightful trends.
5. Finished with the "Dashboard" page to compile the most compelling visuals generated throughout each page.

![Dashboard Screenshot](https://user-images.githubusercontent.com/118670053/222217101-1340c798-338e-488a-9c3c-523b889281f2.png)

## Results

### Analysis Key Findings
- Men are more likely to experience heart failure. This is already known but important to establish it once again.
- People in their 60s are most likely to experience heart failure.
- Mortality rate increases as age increases.
- The majority of deaths occurred within 75 days or fewer days of the final follow-up time by the doctors. The majority of patients would "survive" the heart attack if they stayed alive for at least 75 days after the heart attack.
- Hypertension and Anemia are higher risk factors for death than smoking and diabetes.
- The first quadrant of follow-up times, which also had the highest deaths, had far higher average serum creatine levels than the other three.
- CPK levels are much more likely to spike high for men than they are for women when serum sodium levels are 130 or higher.
- Hypertension is more likely for men when serum sodium reaches 130 or higher.
- Almost 1/3 of heart attacks resulted in death. (The data set does not have a high enough sample size or give a demographic/location to make further statements on this statistic.)

### Recommendations
##### The following recommendations were given to the hospital management
- Monitoring serum sodium levels and keeping them under 130 will greatly decrease the risk of heart failure.
- Patients with the highest serum creatine levels should be monitored the closest during the first 3 months following a heart attack.
- Patients with anemia or hypertension, and especially those with both, should be treated with priority; there is almost a 40% mortality rate for these patients.
- According to the [National Nutrition Council](https://www.nnc.gov.ph/regional-offices/mindanao/region-xi-davao-region/8185-anemia-and-hypertension-are-they-the-same), hypertension is shown to be caused by severe anemia due to the body trying desperately to get oxygen to the body.

### Data Requests

- A larger sample size.
- Race/ethnicity demographic data.
- Patient geographical location.

##### Collecting data on the above three criteria would greatly improve the effectiveness and accuracy of the analysis.
