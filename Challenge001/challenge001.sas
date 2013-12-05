/*==============================================================================
CODING CHALLENGE #1: OLS

From: John McConnell 
Sent: Tuesday, December 03, 2013 9:18 AM
To: Aaron Mendelson; Benjamin Chan; Hyunjee Kim; Jonah Todd-Geddes; Lorie Jacob; Margaret Sarna-Wojcicki; Peter Graven; Ruth Rowland; Stephanie Renfro
Subject: Developing programming examples for R, Stata, SAS

Group
                                                                                                       
Following up on our discussion last week, I propose the following exercise. I have tried to keep this very simple. We can get more involved if we think that would help. This is a baby step.

Let’s have these people take the lead:

Stata – Peter
R – Stephanie
SAS – Ben

Let’s work off this directory
X:\OHSU Shared\Restricted\OCHSER\PROJECTS\Code_Sharing
Using the file “Inpatient_Claims_Sample_1.” (I have SAS, Stata, and R versions there).

Please create a word document and a statistical code file (e.g., a Stata “do” file or analog in SAS or R). The word document should describe, briefly
a.	How you start the program
b.	How you locate the file Inpatient_Claims_Sample_1 within your program (or perhaps reference this in the code file).
c.	How you run your code 
d.	How you view your results

It is ok if the word file is only 4 sentences! I prefer to err on the side of keeping it simple at this point. We can always go back and add more detail later. This is not a manual.

The code file should be commented and describe how to do the following
a.	Load the dataset
b.	Describe the variables that exist in the data set (i.e., print out the names of the variables)
c.	Take the mean of CLM_PMT_AMT
d.	Run an OLS regression of CM_PMT_AMT  on CLM_UTLZTN_DAY_CNT and CLM_PASS_THRU_PER_DIEM_AMT (coefficient on  CLM_UTLZTN_DAY_CNT  should be about 489 and R-squared should be about 0.11)
e.	Save the output (the coefficient estimates, standard errors, p-values) in a text file or other file that can be opened up easily in Word or Notepad or a browser. 

When you’re ready, send your Word doc and Code file to the group

WHEN?

By January 3, 2014

Ben, Peter, Stephanie: let me know by the end of the week if you’d like to change this plan (I.e., if it seems confusing, useless, or you’re too busy).

Also, Ben made the following observations, which I agree with – but I thought they might add to the complexity and so I thought we could revisit these at some point in the future, and for now just keep it very very simple.

COMMENTS FROM BEN

I think it might actually be instructive to see how to get the data from CSV to a native format for analysis (how easy/hard it is, how much can be automated, how much needs to be programmed). That might be a big enough task just to make it the first “project”.

We’ll want to put data on the X-drive. Probably a subfolder in the PROJECTS folder called “CodeSharing” or something like that and further organized with the following folders
1.	Data
2.	Task01ImportingData
3.	Task02ComputingUnivariateStats
4.	Task03ModelingOLS
5.	Etc
==============================================================================*/
title1 "Coding Challenge #1";


/*==============================================================================
Set pointer to library where the data is located.
Note: SAS refers to a folder or directory as a "library".
==============================================================================*/
libname lib "\\ohsum01.ohsu.edu\OHSU\OHSU Shared\Restricted\OCHSER\PROJECTS\Code_Sharing" access=readonly;


/*==============================================================================
Open an HTML file to pipe all output to
Use the HTMLBLUE style instead of the default; it's prettier
==============================================================================*/
filename fOut "H:\CHSE\ActiveProjects\Sandbox\CodingChallenges\Challenge001\challenge001SAS.html";
ods html file=fOut style=HTMLBLUE;


/*==============================================================================
Show the variables in the dataset Inpatient_Claims_Sample_1.sas7bdat.
The "order=varnum" option prints the variable list in the order they appear in the dataset.
Otherwise, the default is to list them alphabetically, which is sometimes less useful.
==============================================================================*/
title2 "Data dictionary";
proc contents data=lib.Inpatient_Claims_Sample_1 order=varnum;
run;


/*==============================================================================
Compute the mean of the clm_pmt_amt variable.
==============================================================================*/
title2 "Summary statsitics for clm_pmt_amt variable";
proc means data=lib.Inpatient_Claims_Sample_1;
	var clm_pmt_amt;
run;


/*==============================================================================
Fit a least squares regression model with clm_pmt_amt as the dependent variable.
clm_utlztn_day_cnt and clm_pass_thru_per_diem_amt are the independent variables.
Output the model estimates to a dataset.
Use the ods statement to produce an ODS dataset of the parameter estimates
==============================================================================*/
title2 "Linear regression model";
proc reg data=lib.Inpatient_Claims_Sample_1;
	model clm_pmt_amt = clm_utlztn_day_cnt clm_pass_thru_per_diem_amt;
run;


/*==============================================================================
Close the HTML file
==============================================================================*/
ods html close;
