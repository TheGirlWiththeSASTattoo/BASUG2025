/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP21:        */
/* PROC REG demonstrating ODS SHOW / SELECT / EXCLUDE, and harvesting the */
/* Anova and FitStatistics output objects via an ODS OUTPUT sandwich.     */
/* out1.heart -> work.heart. PLOTS(MAXPOINTS=NONE) kept as authored.      */

ods graphics on;
run;

ods trace on;

*** No selections or exclusions;
ods select all;
run;

ods show;
proc reg data=work.heart PLOTS(MAXPOINTS=NONE);
  model bmi = weight ageatstart height;
title2 "PROC REG: no selections or exclusions";
run;
quit;

ods select none;
run;

*** ODS SELECT plus an ODS OUTPUT sandwich for Anova + FitStatistics;
ods select FitStatistics Anova;
ods show;
ods output anova=anova1 fitstatistics=fitstatistics;
proc reg data=work.heart PLOTS(MAXPOINTS=NONE);
  model bmi = weight ageatstart height;
title2 "PROC REG: SELECT Fit and Anova";
run;
ods output close;
quit;

ods select all;
run;

*** ODS EXCLUDE the ParameterEstimates table;
ods exclude ParameterEstimates;
ods show;

proc reg data=work.heart PLOTS(MAXPOINTS=NONE);
  model bmi = weight ageatstart height;
  title2 "PROC REG: EXCLUDE parameters";
run;
quit;

ods trace off;

proc print data=anova1 noobs;
title2 "Anova ODS Output Object";
run;

proc print data=fitstatistics noobs;
title2 "FitStatistics ODS Output Object";
run;

title2;
run;
