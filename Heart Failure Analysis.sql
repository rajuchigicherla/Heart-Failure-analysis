---- Exploratory Data Analysis------

--Selecting top 10 for inspection

SELECT TOP 10 *
FROM Heartfailure;

--The data is certified clean, so I will start with counts to get an idea of distributions across common diabetes indicators

-- patient count

SELECT
    COUNT(Patient_ID) AS patient_count
FROM Heartfailure;

--Counting gender distribution

SELECT 
    sex,
    COUNT(sex) as gender_count
FROM Heartfailure
GROUP BY sex;

--Counting anaemia distribution

SELECT
    sex,
    COUNT(anaemia) as anaemia_count
FROM Heartfailure
WHERE anaemia = 1
GROUP BY sex;

--Counting high blood pressure

SELECT
    sex,
    COUNT(high_blood_pressure) as high_bp_count
FROM Heartfailure
WHERE high_blood_pressure = 1
GROUP BY sex;

--Counting smokers per gender

SELECT
    sex,
    COUNT(smoking) AS smoker
FROM Heartfailure
WHERE smoking = 1
GROUP BY sex;

--Counting diabetes per gender

SELECT
    sex,
    COUNT(diabetes) AS diabetic
FROM Heartfailure
WHERE diabetes = 1
GROUP BY sex;

--Counting deaths per gender

SELECT
    sex,
    COUNT(DEATH_EVENT) as deaths
FROM Heartfailure
WHERE DEATH_EVENT = 1
GROUP BY sex;


-- Initial Inspection Results

/*Early results indicate that nearly twice as many men are expected to experience heart failure than women as would be expected.
Very few women were smokers, so this is likely not an indicator of heart failure for women.
Smoking seems to account for almost half of men's heart attacks within this dataset.
*/



--Using window functions and an aggregate count to find age trends

SELECT
    age,
    COUNT(*) AS age_count,
    ROUND(AVG(platelets),2) AS avg_platelet_count,
    ROUND(AVG(serum_creatinine),2) AS avg_creatine,
    ROUND(AVG(serum_sodium),2) AS avg_sodium,
    ROUND(AVG(ejection_fraction),2) AS avg_ejec_frac,
    ROUND(AVG(age) OVER(),2) AS avg_age,
    MIN(age) OVER() AS min_age,
    MAX(age) OVER() AS max_age
FROM Heartfailure
GROUP BY age
ORDER BY age_count DESC, age DESC;


-- Creating Bin Segmentation for More Targeted Analysis

--Use a CTE to create bins of ages

WITH age_bin AS (
    SELECT
        Patient_ID,
        CASE
            WHEN age >= 40 AND age < 46 THEN '40-45'
            WHEN age >= 46 AND age < 51 THEN '46-50'
            WHEN age >= 51 AND age < 56 THEN '51-55'
            WHEN age >= 56 AND age < 61 THEN '56-60'
            WHEN age >= 61 AND age < 66 THEN '61-65'
            WHEN age >= 66 AND age < 71 THEN '66-70'
            WHEN age >= 71 AND age < 76 THEN '71-75'
            WHEN age >= 76 AND age < 81 THEN '76-80'
            WHEN age >= 81 AND age < 86 THEN '81-85'
            WHEN age >= 86 AND age < 91 THEN '86-90'
            WHEN age >= 91 AND age < 96 THEN '91-95'
        END AS age_bin
FROM Heartfailure
)

--Selecting averages and sums of all applicable attributes across each bin

SELECT
 age_bin,
    COUNT(*) AS age_count,
    ROUND(AVG(platelets),2) AS avg_platelet_count,
    ROUND(AVG(serum_creatinine),2) AS avg_serum_creatine,
    ROUND(AVG(serum_sodium),2) AS avg_serum_sodium,
    ROUND(AVG(ejection_fraction),2) AS avg_ejec_frac,
    ROUND(AVG(creatinine_phosphokinase),2) AS avg_creatine_phos,
    SUM(smoking) AS smoking_count,
    SUM(diabetes) AS diabetic_count,
    SUM(anaemia) AS anaemia_count,
    SUM(high_blood_pressure) AS high_bp_count,
    SUM(DEATH_EVENT) AS deaths
FROM Heartfailure
JOIN
    age_bin ON Heartfailure.Patient_ID = age_bin.Patient_ID
GROUP BY age_bin
ORDER BY age_bin;
/*
This query turned out some very valuable insights by aggregating into bins with intervals of 5.
1. If we only consider an n>10 a sufficient bin size, we can see that the 51-55 age range has the best ejection fraction.

2. The average serum creatine for the 76-80 age range is far higher than the other bins.

3. The average creatine phosphokinase for the 81-85 age range is far higher than the other bins.

4. The majority of heart attacks occur within the 56-60 age range, which also has the highest rate of diabetes, anaemia, smoker, deaths, and among the highest high blood pressure occurences.

5. Younger individuals tend to have lower serum creatine levels, but they are on the higher end of creatine phosphokinase.

Moving to Power BI
After achieving valuable initial insights on the data set with SQL, moving to a BI tool will help find more targeted trends and insights by conducting more advanced analysis.
*/