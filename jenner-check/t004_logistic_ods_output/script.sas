/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP20:        */
/* PROC LOGISTIC modelling vital Status, harvesting the ParameterEstimates */
/* and OddsRatios output objects, then examining each harvested data set.  */
/* out1.heart -> work.heart.                                              */

title2 "Logistics";
run;

ods trace on;
ods output parameterestimates=parameterestimates oddsratios=oddsratios;

proc logistic data=work.heart;
    class sex;
    model status = AgeAtStart
	               sex
                   mrw
                   smoking
				   bmi_cat
                   ;
run;

ods output close;
ods trace off;

proc print data=parameterestimates (obs=20) noobs;
title2 "Logistics Parameter Estimates";
run;

proc contents data=parameterestimates varnum;
run;

proc print data=oddsratios (obs=20) noobs;
title2 "Logistics Odds Ratios";
run;

proc contents data=oddsratios varnum;
run;

title2;
run;
