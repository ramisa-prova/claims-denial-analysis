# Healthcare Claims Denial Analysis

I built this project to simulate the kind of analysis a revenue cycle team does: finding out which payers, procedures and denial reasons cost a hospital the most, and how much of that loss the hospital could have avoided.

The question 

Which payers, procedures and denial reasons account for the most denied revenue, and how much of it was avoidable? 

The data 

Real claim-level denial data isn't public, so I generated 10,000 synthetic claims for 2024 in Python. Denial rates differ by payer and procedure, and the denial reasons use real Claim Adjustment Reason Codes (CARC). I left some billed amounts blank and capitalized payer names inconsistently, so the cleaning step had actual problems to fix. I chose the underlying rates myself, so the findings below show what the analysis can surface. They say nothing about how real payers behave. 

How the pieces fit

Python in Google Colab generates the claims. In Excel I built two reference sheets: one lists denial categories with a flag for whether the hospital can fix that kind of denial, and the other holds payer contract details. In PostgreSQL I cleaned the claims, joined them to those sheets, and wrote the CTE and window-function queries. Tableau Public shows the results.


Tool
What it did
Python (Colab)
Generated the claims, including the messy rows
Excel
Denial categories with a fixable flag, and payer contract terms
PostgreSQL
Cleaning, joins and analysis
Tableau Public
Dashboard built from the query results


What I found 

- 19.6% of claims (1,956 of 10,000) were denied or written off, about $14.1M in billed charges. 
- Medicaid (24.2%) and Cigna (24.1%) had the highest denial rates, and together they make up about 38% of denied dollars. Medicare had the lowest rate at 14.1%. 
- About 65% of denied dollars came from reasons the hospital can act on: missing documentation, missing authorization, coding mismatches, missed filing deadlines and medical necessity. The rest was bundling and patient-responsibility adjustments.  
- Monthly denial rates stayed between 18.7% and 21.2% except for October, which dipped to 15.9%. Since the data is synthetic, I read that as chance. 
- Denied dollars by individual code ranged from about $1.5M to $2.1M. The generator picks codes at random, so I don't read anything into which one came out on top. 

What I'd recommend 

Start with the fixable reasons, since they hold most of the lost dollars. Put pre-submission checks on Cigna and Medicaid claims first, because those two payers deny the most. I wouldn't spend time on seasonality in this data, because there isn't any. 

Limitations 

- The data is synthetic, so the patterns reflect the rates I set. 
- Denied dollars use billed amounts, not expected reimbursement.  
- Written-off claims are counted together with denied ones.  
- Patient-responsibility codes (PR-1 and PR-2) are counted as unpaid. A real billing team would track them separately from true denials.  
- Appeals and resubmissions aren't modeled, so there is no recovery estimate. 

Files

- ‘generate_data.ipynb’ creates the claims CSV  
- ‘Billing_Reference_Data.xlsx’ has the two reference sheets 
- ‘schema.sql’ creates the tables  
- ‘analysis_queries.sql’ has the cleaning view and every query behind the dashboard 

Links
 
- Colab notebook: [generate_data.ipynb](https://colab.research.google.com/drive/1dLU_uaf8By_3WaV7FX3LtnL8kmEgE12_?usp=sharing)
- Tableau Public dashboard: [https://public.tableau.com/views/ClaimsDenialAnalysisDashboard/ClaimsDenialAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link](https://public.tableau.com/views/ClaimsDenialAnalysisDashboard/ClaimsDenialAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
