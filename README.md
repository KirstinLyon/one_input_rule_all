# One Input to Rule Them All

A hands-on tutorial project showing how to build **one input control** that dynamically drives **multiple calculations** in **Tableau** and **Power BI**, using real-world PEPFAR data from Mozambique.

---

## Project Overview

This project is designed for data visualization developers who want to create smarter, more flexible dashboards. It uses **PEPFAR's Enhanced Geographical Analysis (EGA)** dataset and focuses on:

- Creating **a single user input** that controls multiple metric or indicator calculations
- Implementing this behavior in both **Tableau** and **Power BI**
- Providing an **interactive, scalable** experience for end users
- Structuring data in R for consistent use across both platforms

---

##  Data Source

- **Source**: [PEPFAR Enhanced Geographical Analysis](https://data.pepfar.gov/ - downloaded on January 2025. Website no longer available.)
- **Focus Country**: SADC Countries (when available)
- **Raw Format**: TXT from PEPFAR portal
- **Processed in**: R (using `tidyverse`, `janitor`, etc.)

---

##  Data Processing (R)

All data prep is handled in R, ensuring a clean and consistent format for input into either visualization tool.

**Steps:**
1. Filter SADC Country data
2. Clean and standardize indicator names (TB_STAT, TB_STAT_POS, TX_NEW, HTS_TST, HTS_TST_POS)
3. Pivot or reshape data for parameter compatibility
4. Export a unified CSV for use in both Tableau and Power BI



---

## What You'll Learn

- How to create **dynamic calculations** based on user selection
- How to build **parameter-driven dashboards**
- How to handle **multi-indicator logic** from a single dropdown or slicer
- How to structure and process raw data for maximum flexibility

---

## Visualization Tutorials

### Tableau

- Set up **parameters** and **calculated fields**
- Use one dropdown to switch between multiple indicators (e.g., HTS_TST, TX_CURR, etc.)
- Drive charts, maps, and KPIs with this single input

 Tutorial: `tutorials/tableau_tutorial.md`  COMING

---

### Power BI

- Use a single **slicer** or **what-if parameter**
- Create **measure switching logic** with DAX
- Link visuals (maps, bar charts, cards) to this unified control

 Tutorial: `tutorials/powerbi_tutorial.md` COMING




