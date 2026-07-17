/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP17-18:     */
/* PROC UNIVARIATE on BMI, harvesting the Moments, BasicMeasures and      */
/* Quantiles output objects with an ODS OUTPUT sandwich, then examining   */
/* each harvested data set. out1.heart -> work.heart.                     */

ods trace on;

proc univariate data=work.heart;
    var bmi;
title2 "Univariate on BMI";
run;

ods trace off;

*** ODS OUTPUT sandwich: harvest UNIVARIATE output objects to work files;
ods output moments=moments1 basicmeasures=basicmeasures1 quantiles=quantiles1;

proc univariate data=work.heart;
    var bmi;
title2 "Univariate on BMI";
run;

ods output close;

*** PROC CONTENTS + test prints on each harvested ODS OUTPUT data set;
proc contents data=moments1 varnum;
title2 "PROC CONTENTS on UNIVARIATE MOMENTS1 ODS OUTPUT object";
run;

proc print data=moments1 (obs=10) noobs;
title2 "Test print on UNIVARIATE MOMENTS1 ODS OUTPUT object";
run;

proc print data=basicmeasures1 noobs;
title2 "Test print on UNIVARIATE BASIC MEASURES 1 ODS OUTPUT object";
run;

proc print data=quantiles1 (obs=10) noobs;
title2 "Test print on UNIVARIATE QUANTILES1 ODS OUTPUT object";
run;

title2;
run;
