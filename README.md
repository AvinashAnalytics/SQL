# SQL Portfolio Project: Credit Card Transaction Analysis

## Overview
This project involves analyzing credit card transaction data to derive business insights and answer various business questions using SQL. The dataset contains information about transactions, including transaction amount, card type, city, gender, and expense type.

The goal of this project is to demonstrate SQL skills by solving business-related questions and generating insights from the data.

## Dataset
The dataset is available on [Kaggle: Analyzing Credit Card Spending Habits in India](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india).

### Data Import
The data was imported into SQL Server with the table name `credit_card_transactions`. The following transformations were applied:
- Column names were converted to lowercase and spaces were replaced with underscores.
- Data types were adjusted based on the data characteristics.

## SQL Queries
Below are the SQL queries created to answer specific business questions:

1. **Top 5 cities with highest spends**: Identifies the top cities with the highest total spend and their percentage contribution.
2. **Highest spend month by card type**: Determines the month with the highest spend for each card type.
3. **Transaction details for cumulative spend of 1,000,000**: Finds transaction details when cumulative spends reach 1,000,000 for each card type.
4. **City with the lowest percentage spend for gold card type**: Identifies the city with the lowest spend percentage for the gold card type.
5. **Highest and lowest expense types in each city**: Determines the highest and lowest expense types in each city.
6. **Percentage contribution of female spend for each expense type**: Calculates the percentage of spend by females for each expense type.
7. **Highest growth card and expense type combination**: Identifies the combination with the highest growth in spend during Jan-2014.
8. **Weekend spend to transaction ratio by city**: Finds the city with the highest spend to transaction ratio during weekends.
9. **City with the fastest reach to 500th transaction**: Identifies the city that reached its 500th transaction in the shortest time.

## How to Use
1. Clone this repository:  
   `git clone https://github.com/AvinashAnalytics/sql-credit-card-analysis.git`

2. Import the dataset into your SQL environment and run the queries above to explore the data.

## Technologies Used
- SQL Server
- SQL (Advanced Queries)
- Kaggle Dataset

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
