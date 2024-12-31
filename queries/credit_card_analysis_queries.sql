-- Remove rows with null values in essential columns
DELETE FROM credit_card_transactions 
WHERE city IS NULL OR amount IS NULL OR transaction_date IS NULL OR card_type IS NULL;

-- Remove negative amounts
DELETE FROM credit_card_transactions 
WHERE amount < 0;



--2. Top 5 Cities with Highest Spends and Their Percentage Contribution
--Objective:
--Identify the top 5 cities where the most credit card spending occurs and
--calculate each city's contribution as a percentage of the total spending.


SELECT  TOP 5 city, 
       SUM(amount) AS total_spent, 
       (SUM(amount) / (SELECT SUM(amount) FROM credit_card_transactions)) * 100 AS percentage_contribution
FROM credit_card_transactions
GROUP BY city
ORDER BY total_spent DESC;




--3. Highest Spend Month and Amount Spent for Each Card Type
--Objective:
--For each card type, determine which month had the highest total spend and
--calculate the total amount spent during that month.

SELECT card_type, 
       MONTH(transaction_date) AS month, 
       SUM(amount) AS total_spent
FROM credit_card_transactions
GROUP BY card_type, MONTH(transaction_date)
ORDER BY total_spent DESC;



--3. Transaction Details When Cumulative Spend Reaches 1,000,000 for Each Card Type
--Objective: 
--Retrieve transactions when the cumulative spend for a card type reaches 1,000,000.


WITH CTE AS (
    SELECT card_type, 
           SUM(amount) OVER (PARTITION BY card_type ORDER BY transaction_date) AS cumulative_spent, 
           transaction_id, city, amount, transaction_date, expense_type
    FROM credit_card_transactions
)
SELECT * 
FROM CTE
WHERE cumulative_spent >= 1000000
ORDER BY card_type, transaction_date;





--4. City with Lowest Percentage Spend for Gold Card Type
-- City with lowest percentage spend for Gold card type

SELECT TOP 1, 
       (SUM(amount) / (SELECT SUM(amount) FROM credit_card_transactions WHERE card_type = 'Gold')) * 100 AS spend_percentage
FROM credit_card_transactions
WHERE card_type = 'Gold'
GROUP BY city
ORDER BY spend_percentage ASC;


--5. City, Highest, and Lowest Expense Type
--Objective: For each city, identify the highest and lowest spending expense types.

SELECT city, 
       (SELECT expense_type FROM credit_card_transactions WHERE city = C.city GROUP BY expense_type ORDER BY SUM(amount) DESC LIMIT 1) AS highest_expense_type,
       (SELECT expense_type FROM credit_card_transactions WHERE city = C.city GROUP BY expense_type ORDER BY SUM(amount) ASC LIMIT 1) AS lowest_expense_type
FROM credit_card_transactions C
GROUP BY city;


--6. Percentage Contribution of Female Spends for Each Expense Type
--Objective: Calculate the percentage of total spend by females for each expense type.


SELECT expense_type, 
       (SUM(CASE WHEN gender = 'F' THEN amount ELSE 0 END) / SUM(amount)) * 100 AS female_percentage
FROM credit_card_transactions
GROUP BY expense_type;



--7. Card and Expense Type Combination with Highest Month-Over-Month Growth in January 2014
--Objective: Identify the card and expense type with the highest growth in January 2014.


SELECT card_type, expense_type, 
       ((SUM(amount) - LAG(SUM(amount)) OVER (PARTITION BY card_type, expense_type ORDER BY transaction_date)) / 
        LAG(SUM(amount)) OVER (PARTITION BY card_type, expense_type ORDER BY transaction_date)) * 100 AS growth_percentage
FROM credit_card_transactions
WHERE transaction_date BETWEEN '2014-01-01' AND '2014-01-31'
GROUP BY card_type, expense_type;


--8. City with Highest Spend-to-Transaction Ratio on Weekends

--Objective: Identify the city with the highest spend-to-transaction ratio on weekends.


-- City with highest spend-to-transaction ratio on weekends
SELECT TOP 1 city, 
       SUM(amount) / COUNT(transaction_id) AS spend_per_transaction
FROM credit_card_transactions
WHERE DATENAME(WEEKDAY, transaction_date) IN ('Saturday', 'Sunday')
GROUP BY city
ORDER BY spend_per_transaction DESC;


--9. City to Reach Its 500th Transaction the Quickest
--Objective: Determine which city reached its 500th transaction the quickest after the first transaction.


WITH CTE AS (
    SELECT city, transaction_date,
           ROW_NUMBER() OVER (PARTITION BY city ORDER BY transaction_date) AS transaction_rank
    FROM credit_card_transactions
)
SELECT TOP 1 city, MIN(transaction_date) AS first_500th_transaction_date
FROM CTE
WHERE transaction_rank = 500
GROUP BY city
ORDER BY first_500th_transaction_date ASC;


