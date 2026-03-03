# eniac-ecommerce-sql-analysis
## Project Overview
Eniac is a Spain‑based online marketplace known for premium Apple products, curated high‑end accessories, and warm, human‑centered tech support. After going public, the company set its sights on rapid international expansion, with Brazil identified as a major growth opportunity. Lacking local logistics partners and market knowledge, Eniac is evaluating a temporary partnership with Magist. A Brazilian SaaS platform that provides order management, warehousing, shipping, and customer‑service infrastructure for small and medium sellers. While Magist could accelerate Eniac’s entry into Brazil, concerns remain about whether its ecosystem is suitable for high‑end tech products and whether its Post Office-based delivery network can meet Eniac’s fast‑delivery standards. To support this decision, Magist has shared a snapshot of its database, and this project analyzes that data using SQL to assess product fit, delivery performance, and overall viability of the partnership.

## Dataset
Source: provided by WBS coding School  
Size: around 99k transactions   
Timeframe: September 2016 – October 2018 (25 months)  

<img width="1535" height="1567" alt="image" src="https://github.com/user-attachments/assets/4de9623d-ab6b-44fe-998a-a36af61376cb" />

## Answering business questions
 
#### 1. Are orders actually delivered? What is the status of them?
delivered	      96478  
unavailable	    609  
shipped 	      1107  
canceled	      625  
invoiced	      314  
processing	    301  
approved	      2  
created 	      5  

 #### 2. Is Magist having user growth?
Yes. Magist shows clear user growth — from 324 customers in October 2016 to 7,538 customers in November 2017. 
Overall, the dataset contains 98,666 unique customers, each appearing only once, which reflects a limitation of the snapshot rather than real customer behavior.

#### 3. What is the percentage of tech product sales? 14,02%
#### 4. What is the average price of all sold products? 120,65
#### 5. What is the average price of sold tech products? 106,25
#### 6. How are sold tech products distributed across price ranges? 
11361	    Cheap (<100)  
4263	    Mid-range (<1000 & >100)  
174	      Expensive (>1000)  

#### 7. What is the percentage of tech sellers? 14,67%
#### 8. What is the total revenue earned by all sellers? 13494400,74
#### 9. What is the average monthly income per seller? 174,4
#### 10. What is the total revenue earned by all tech sellers? 1666211,29
#### 11. What is the average monthly income per tech seller? 149,1
#### 12. How long does it take on average for an order to be delivered? 13 days
#### 13. How can orders be classified as on-time or delayed?
Delayed	           6665  
On time	           89805  

#### 14. Do heavier products tend to fall into longer delay buckets?
<img width="594" height="175" alt="image" src="https://github.com/user-attachments/assets/39efc783-d244-4840-b131-151c2e9f3ad3" />  


### It is still ongoing ! 
##### This project is still in progress. I am continuing to refine the SQL analysis and will extend the work with an interactive Tableau dashboard to visualize key insights on sales, delivery performance, and product behavior.








