/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP4-6:      */
/* the three PROC CONTENTS views of the enhanced HEART data set --        */
/* default (collate), VARNUM, and OUT= -- built in the autoexec.          */
/* out1.heart -> work.heart (original libname pointed at a local path).   */

*** Default PROC CONTENTS (variables in alphabetic / COLLATE order);
proc contents data=work.heart;
title2 "Contents of Heart - Collate";
run;

*** PROC CONTENTS VARNUM (variables in PDV / position order);
proc contents data=work.heart varnum;
title2 "Contents of Heart - Varnum";
run;

*** PROC CONTENTS with OUTPUT data set;
proc contents data=work.heart out=contents_out1_heart noprint;
title2 "Contents with OUT= data set";
run;

proc print data=contents_out1_heart (obs=5) noobs;
title2 "Test Print of OUT= data set";
run;

proc contents data=contents_out1_heart;
title2 "Contents of OUT= data set";
run;

title2;
run;
