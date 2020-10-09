# DATA-WAREHOUSING-ASSIGNMENT
In this project, you will work on datasets that are related with direct marketing campaigns (phone calls) of a Portuguese banking institution. 
The classification goal is to predict if the client will subscribe a term deposit. The bank did marketing campaigns based on phone calls. 
Often, more than one contact to the same client was required, in order to assess if bank term deposit would be ('yes') or not ('no') subscribed. 
This assignment is an individual assignment.

I. Datasets: 
There are three datasets: demographics. csv, campaign.csv and deposit.csv. You need to merge these three datasets to create a “big table” which will be the training dataset. The dependent variable is the variable “deposit” contained in deposit.csv 
Source of the data:
[Moro et al., 2014] S. Moro, P. Cortez and P. Rita. A Data-Driven Approach to Predict the Success of Bank Telemarketing. Decision Support Systems, Elsevier, 62:22-31, June 2014
  Variable Information:
-Independent variables:
-cid: customer ID (nominal) exits in all three tables.
-Other independent variables include:
 # Table: demographics:
1 age (numeric)
2 job : type of job (categorical)
3 marital : marital status (categorical)
4 education (categorical)
5 default: has credit in default? (categorical)
6 balance: account balance (numeric)
7 housing: has housing loan? (categorical)
8 loan: has personal loan? (categorical)
# Table: campaign: related with the last contact of the current campaign:
9 duration: last contact duration, in seconds (numeric). Important note: this attribute highly affects the output target (e.g.,   if duration=0 then y='no'). Yet, the duration is not known before a call is performed. Also, after the end of the call y is     obviously known. Thus, this input should only be included for benchmark purposes and should be discarded if the intention is   to have a realistic predictive model.
10 campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
11 pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric; -1 means client    was not previously contacted)
12 previous: number of contacts performed before this campaign and for this client (numeric)
13 poutcome: outcome of the previous marketing campaign (categorical)
  # Table: Deposite:
deposit (Categorical: ‘yes’, ‘no’);
