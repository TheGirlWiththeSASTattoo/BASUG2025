/* cap input rows for the captured run */
options obs=100;

/* --- from BASUG2025_ODSOutput_Exercises.sas STEP2-3 (Louise Hadden): --- */
/* --- formats + the "Enhanced version of SASHELP.HEART" data set,     --- */
/* --- with the original C:\...\SASOutput libname retargeted to WORK.  --- */
options ps=55 ls=175 validvarname=v7 nodate nonumber;
ods noproctitle;

proc format library=work fmtlib;
	value bmi_catf	1 = 'Underweight (<18.5)'
			2 = 'Healthy Weight (<18.5-<25)'
			3 = 'Overweight (<25-<30)'
			4 = 'Obesity (30+)';

	value obesityf	1 = 'Not Obese'
			2 = 'Class 1 Obesity'
			3 = 'Class 2 Obesity'
			4 = 'Class 3 Obesity (Severe)';
run;
quit;

data work.heart (label="Enhanced version of SASHELP.HEART");
    set sashelp.heart;

    label 	status="Status"
	      	sex="Sex"
		height="Height"
		weight="Weight"
		Diastolic="Diastolic Blood Pressure"
		Systolic="Systolic Blood Pressure"
		Smoking="Smoking Status"
		Cholesterol="Cholesterol Status";

	HeartID=modz(_n_,4);
	SeqNum=_n_;
	SampleWeight = 1 + (mod(_n_,10)*.1);

    bmi= weight / height**2 * 703;
	select;
		when (1 le bmi lt 18.5) bmi_cat = 1;
		when (18.5 le bmi lt 25) bmi_cat = 2;
		when (25 le bmi lt 30) bmi_cat = 3;
		when (30 le bmi) bmi_cat = 4;
		otherwise  bmi_cat = .;
	end;
	select;
		when (1 le bmi lt 30) obesity_cat = 1;
		when (30 le bmi lt 35) obesity_cat = 2;
		when (35 le bmi lt 40) obesity_cat = 3;
		when (40 le bmi) obesity_cat = 4;
		otherwise  obesity_cat = .;
	end;
	select;
	    when (sex='Female') female = 1;
		otherwise  female = 0;
	end;
	select;
	    when (sex='Male') male = 1;
		otherwise male = 0;
	end;

	label 	HeartID="Heart Group Variable"
	      	SeqNum="Sequence Number"
	      	bmi="BMI"
		bmi_cat="BMI Category"
		obesity_cat="Obesity Category"
		SampleWeight="Sample Weight"
		male="Binary: Male"
		female="Binary: Female";
run;

title1 "BASUG 2025: ODS Output";
