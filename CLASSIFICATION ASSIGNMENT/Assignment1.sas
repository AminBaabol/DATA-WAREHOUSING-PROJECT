/*** Step:1 ***/
/*** Step2: sorting imported files one by one and saving them to work library***/
/*Demographics*/
FILENAME REFFILE '/home/u49129236/Amin_Baabol_Homework/demographics.csv';

proc import datafile=REFFILE
	DBMS=CSV
	OUT=WORK.demographics;
	GETNAMES=YES;
run;
proc contents data=WORK.demographics;
run;
proc sort data=work.demographics;
by cid;
run;

/*Campaign*/
FILENAME REFFILE '/home/u49129236/Amin_Baabol_Homework/campaign.csv';

proc import datafile=REFFILE
	DBMS=CSV
	OUT=WORK.campaign;
	GETNAMES=YES;

proc contents data=WORK.campaign;

proc sort data=work.campaign;
by cid;
run;

/*Deposit*/
FILENAME REFFILE '/home/u49129236/Amin_Baabol_Homework/deposit.csv';

proc import datafile=REFFILE
	DBMS=CSV
	OUT=WORK.deposit;
	GETNAMES=YES;
run;
proc contents DATA=WORK.deposit;
run;
proc sort data=work.deposit;
by cid;
run;
/** Step 3 **/

data work.training;
merge work.deposit(IN=A) work.demographics(IN=B);
by cid; 
if A;
run;

data work.training;
merge work.training(IN=A) work.campaign(IN=B);
by cid; 
if A;
run;

/** Step 4 **/
proc print data=work.training(obs=20);
run;

/** Step 5 **/
proc contents data=work.training;
run;

/** Step 6 **/
data work.training2;
	set work.training (drop = cid duration);
run;
 
proc print data=work.training2;
	title 'work.training2';
run;

/** Step 7 Categorical**/
proc freq data= work.training2;
	tables education marital housing loan default job deposit poutcome;
run;

/** Step 8 Numeric**/
proc means data= work.training2
	mean min max p1 p5 p10 p25 p50 p75 p90 p95 p99;
	var age balance campaign pdays previous;
run;
/** Step 9 **/
/*checking for binary categorical variables with no missing values */
proc freq data = work.training2;
  tables deposit default housing loan;
run;/*deposit,default,loan have no missing values*/;

proc freq data = work.training2;
  tables deposit default housing loan;
run;/*deposit,default,loan have no missing values*/;
proc freq data = work.training2;
  tables job marital education poutcome;
run;/*job,marital,education poutcome */;
data work.training3;
	set work.training2;
	if deposit = 'yes' then deposit3 = 1;
		else deposit3 = 0;
	if default = 'ye' then default3 = 1;
		else default3 = 0;
	if loan = 'yes' then loan3 = 1;
		else loan3 = 0;
	drop deposit;
	drop default;
	drop loan;
run;

data work.training4;
	set work.training3;
	rename deposit3=deposit;
	rename default3=default;
	rename loan3=loan;
run;
proc freq data=work.training4;
	tables deposit default loan;
run;
data work.training5;
	set work.training4;
	if education=' ' then education3='unknown';
		else education3=education;
	if job=' ' then job3='unknown';
		else job3=job;
	if housing=' ' then housing3="missing";
		else housing3=housing;
	drop education;
	drop job;
	drop housing;
run;
data work.training6;
	set work.training5;
	rename education3=education;
	rename job3=job;
	rename housing3=housing;
run;

data work.training7;
	set work.training6;
	if poutcome ='success' then poutcome_success =1;
		else poutcome_success=0;
	if poutcome = 'failure' then poutcome_failure=1;
		else poutcome_failure=0;
	if poutcome='other' then poutcome_other=1;
		else poutcome_other=0;
	if poutcome='unknown' then poutcome_unknown=1;
		else poutcome_unknown=0;
	drop poutcome;
	drop poutcome_failure;
run;
proc print data=work.training7(obs=20);
run;
/* Step 10 */
/* checking for missing values */
proc means data=work.training7 nmiss n; run;
proc freq data=work.training7;
	tables job education marital housing;
run;

proc stdize data=work.training7 out=work.training8
      reponly               
      method=MEAN;           
   var balance;              
run;

/* double checking to make sure there are no more missing values */
proc contents data=work.training8;
run;
proc means data=work.training8 nmiss n; run;

/* Step 11: Logistic Regression */
/** checking for variables with more than two category*/

proc logistic data=work.training8;
	class marital education job housing;
	model deposit=age marital balance campaign pdays previous default loan education job housing poutcome_success poutcome_other poutcome_unknown/expb;
run;