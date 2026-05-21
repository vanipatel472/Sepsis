# Identification of Sepsis Phenotypes in ICU Patients
### A Precision Medicine & Biostatistical Approach Using MIMIC-IV 

[![R-Project](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Shiny-17a2b8?style=flat&logo=rstudio&logoColor=white)](https://shiny.posit.co/)

## Project Overview
Sepsis remains a leading cause of intensive care unit (ICU) mortality worldwide. A primary challenge in clinical treatment is its extreme **heterogeneity**—the condition manifests uniquely across patient populations, meaning uniform treatment protocols often fail. 

This project implements a **data-driven precision medicine workflow** to uncover distinct physiological sepsis sub-types (phenotypes) based on high-resolution longitudinal vital signs. By extracting, cleaning, and modeling real-world Electronic Health Record (EHR) data from the **MIMIC-IV database**, this framework transitions clinical tracking away from static ICD diagnostic codes and toward dynamic, data-driven physiological trajectories.

---

## Core Analytical & Data Science Competencies Demonstrated

### 1. Advanced Statistical Modeling & Unsupervised Learning
* **Dimensionality Reduction & Clustering:** Implemented **K-Means clustering** scaled via robust normalization to group multi-dimensional physiological signals.
* **Mathematical Optimization:** Utilized the **Elbow Method** (with `factoextra` and `cluster`) to algorithmically discover the optimal number of distinct phenotypes ($k=3$), minimizing total intra-cluster variation.
* **Longitudinal Feature Engineering:** Aggregated high-frequency time-series heart rate data into robust statistical markers representing **Intensity** (Mean Heart Rate) and **Stability/Autonomic Volatility** (Standard Deviation of Heart Rate).

### 2. Large-Scale EHR Data Engineering (SQL & BigQuery)
* **Cloud Data Warehousing:** Built direct connection pipelines to Google BigQuery via `bigrquery` and `DBI` to query massive relational schemas within MIMIC-IV.
* **Cohesive Cohort Selection:** Wrote complex analytical SQL queries joining patient tracking logs (`icu.icustays`), core vitals (`icu.chartevents`), and diagnostic registries (`hosp.diagnoses_icd`) to isolate verified ICU sepsis encounters while controlling for confounders.

### 3. Interactive Clinical Decision Support (R Shiny)
* **Reactive Engine:** Developed a full-stack R Shiny architecture (`ui.R` and `server.R` paradigm) built with a responsive reactive engine to handle dynamically adjusted cluster boundaries instantly.
* **Translational UI/UX:** Crafted a professional dashboard layout using the `cosmo` theme, mapping abstract multi-dimensional statistical models into intuitive clinical visuals (Cluster Maps, Ridge Plots, and Infection Source Proportions).

---

## Discovered Sepsis Phenotypes

Through the clustering architecture, the cohort was mathematically segmented into three distinct clinical signatures:

| Phenotype | Core Visual Signature | Clinical Interpretation & Medical Insights |
| :--- | :--- | :--- |
| **Phenotype 1: Hyper-Adrenergic** | **High Intensity / High Stability** | High heart rate stress response but stable autonomic rhythm. Indicates high physiological stress that may benefit from targeted sedation or beta-blockade strategies. |
| **Phenotype 2: Dysregulated** | **High Volatility / Chaotic Rhythm** | Extreme standard deviation in heart rate. Represents autonomic instability; statistically the highest risk group for rapid cardiovascular collapse and decompensation. |
| **Phenotype 3: Compensated** | **Low Intensity / Stable Baseline** | Lower acuity or recovering state. These patients show strong systemic compensation and are the primary candidates for the safe de-escalation of aggressive ICU care. |

> **Key Healthcare Analytical Finding:** Mapping these phenotypes against standard primary diagnoses revealed that the *infection sources* (e.g., Pneumonia vs. UTI) were evenly distributed across all clusters. This proves that **physiological rhythm tracking is a significantly more granular indicator of a patient's true ICU state than traditional static ICD diagnostic codes.**

---

## Repository File Architecture

* `Final_Project_MIMIC_IV.Rmd` — The complete end-to-end reproducible research script containing data pipeline setups, database fetching layers, clustering optimization mathematics, and statistical visualizations.
* `Final_Project_MIMIC_IV.html` — The compiled, production-ready document containing interactive tables, code-folding blocks, and fully rendered clinical data narratives.
* `Final_Project_ShinyApp_Script.R` — Clean, production-ready codebase powering the interactive **MIMIC-IV Sepsis Phenotype Explorer** web application.

---

## Interactive Deployment: How to Run the App

The accompanying interactive dashboard is designed to let clinicians and investigators dynamically explore shifts in cohort distributions by tuning cluster parameters in real-time.

You can launch the app directly on your local machine from GitHub by executing this single command inside your RStudio console:

```R
# Ensure required packages are present
required_pkgs <- c("shiny", "shinythemes", "tidyverse", "factoextra", "cluster", "ggridges")
new_pkgs <- required_pkgs[!(required_pkgs %in% installed.packages()[,"Package"])]
if(length(new_pkgs)) install.packages(new_pkgs)

# Run the app directly from this repository
shiny::runGitHub(repo = "YOUR-REPOSITORY-NAME", username = "YOUR-GITHUB-USERNAME")
```

---

## 👩‍💻 About the Author

**Vani Patel** is a Master’s student in **Biostatistics**, specializing in the intersection of data science, machine learning applications, and medical technology solutions. 

With an academic foundation combining **Bioinformatics and Economics** from the University of Waterloo alongside prior professional experience in **tech consulting**, her work focuses on leveraging large-scale health informatics, EHR analytics, and consumer wearable streams to remove processing latency from patient monitoring pipelines. 

