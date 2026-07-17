/* From BASUG2025_ODSOutput_Exercises.sas (Louise Hadden), STEP7-8:       */
/* ODS TRACE to discover the output-object names, then an ODS OUTPUT      */
/* "code sandwich" that harvests the Variables table from PROC CONTENTS   */
/* into a work data set, closes ODS OUTPUT, then examines it.             */
/* out1.heart -> work.heart.                                              */

*** Use ODS TRACE to list the output objects PROC CONTENTS emits;
ods trace on / listing;

proc contents data=work.heart order=collate;
title2 "Contents of Heart - Order=Collate - ODS TRACE";
run;

ods trace off;

*** Harvest the Variables output object into a work data set;
ods output variables=variables1;

proc contents data=work.heart order=collate;
title2 "Collate contents with ODS OUTPUT objects";
run;

ods output close;

*** Examine the harvested ODS OUTPUT data set;
proc contents data=variables1;
title2 "Contents of Variables ODS Output (Collate)";
run;

proc print data=variables1 (obs=5) noobs;
title2 "Test Print Variables ODS Output (Collate)";
run;

title2;
run;
