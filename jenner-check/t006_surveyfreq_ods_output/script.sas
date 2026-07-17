/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP22:        */
/* Weighted PROC SURVEYFREQ (SampleWeight) crosstabulating Sex by BMI      */
/* category, with and without the ROW option, harvesting the CrossTabs,   */
/* Summary and ChiSq output objects. The %SYSFUNC(EXIST(...)) guard from   */
/* the author's %odssf macro is preserved to show the missing-ChiSq path.  */
/* out1.heart -> work.heart; bmi_catf. format supplied in the autoexec.   */

ods trace on;

title2 "PROC SURVEYFREQ No Row Option";

ods output crosstabs=crosstabs_norow;
proc surveyfreq data=work.heart;
    tables sex*bmi_cat / cv deff chisq;
    weight sampleweight;
	format bmi_cat bmi_catf.;
run;
ods output close;

proc contents data=crosstabs_norow;
run;

title2 "PROC SURVEYFREQ Row Option";

ods output crosstabs=crosstabs_row summary=summary1 chisq=chisq1;
proc surveyfreq data=work.heart;
    tables sex*bmi_cat / row cv deff chisq;
    weight sampleweight;
	format bmi_cat bmi_catf.;
run;
ods output close;

ods trace off;

*** Note the %SYSFUNC(EXIST) routine to address a possibly-missing ChiSq object;
%IF %SYSFUNC(EXIST(chisq1)) %then %do; /* if it exists, go ahead and make our day */
data rchisq1 (keep=rowcat chisqp);
    length chisqp $ 8.;
    set chisq1 (where=(name1 = "P_RSCHI"));
	chisqp = cvalue1;
	rowcat=1;
run;
%END;
%ELSE %DO; /* so it doesn't exist, we make it */
DATA rchisq1 (keep=rowcat chisqp);
    length chisqp $ 8.;
	chisqp = "N/A";
	rowcat=1;
run;
%END;

proc print data=crosstabs_row (obs=10) noobs;
title2 "CrossTabs (Row) ODS Output Object";
run;

proc print data=rchisq1 noobs;
title2 "Rao-Scott Chi-Square P value (harvested)";
run;

title2;
run;
