/*Herzlich Willkommen zu Ihrem persönlichen Jahreskalender.
Bitte das Jahr und das gewünschte Bundesland in der Makrovariabel anpassen. bei "all" werden die gesetzlichen Feiertage
von allen Bundesländern gewählt.
Viel Spaß!*/
%macro setDefaults;
%if %symexist(year) %then %put Using created year macro variable: &year;
%else %do;
	%global year;
	%let year = 2016;
	%end;
%if %symexist(district) %then  %put Using created district macro variable: &district;
%else %do;
	%global district;
	%let district = all;
	%end;
%if %symexist(easter) %then %put Using created easter macro variable: &easter;
%else %do;
	%global easter;
	%let easter = holiday('easter',&year.);
	%end;
%if %symexist(backgroundtop) %then %put Using created backgroundtop macro variable: &backgroundtop;
%else %do;
	%global backgroundtop;
	%let backgroundtop=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\Leuchtturm.jpg;
	%end;
%if %symexist(backgroundbody) %then %put Using created year backgroundbody variable: &backgroundbody;
%else %do;
	%global backgroundbody;
	%let backgroundbody=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\239880.jpg;
	%end;
%if %symexist(Logo) %then %put Using created Logo macro variable: &Logo;
%else %do;
	%global Logo;
	%let Logo=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\Kybeidos_Logo.jpg;
	%end;
%if %symexist(Logozusatz) %then %put Using created Logozusatz macro variable: &Logozusatz;
%else %do;
	%global Logozusatz;
	%let Logozusatz=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\SASSilverPartnerLogogross.bmp;
	%end;
%if %symexist(Partner) %then %put Using created Partner macro variable: &Partner;
%else %do;
	%global Partner;
	%let Partner=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\C-COMMONS-Siegel-quer_03.jpg;
	%end;
%if %symexist(Schulferien) %then %put Using created Schulferien macro variable: &Schulferien;
%else %do;
	%global Schulferien;
	%let Schulferien=C:\Users\kybeidos\Documents\sastraining\Kalender\Images\schulferien-2014.jpg;
	%end;
%mend setDefaults;

%setDefaults;
%macro delAllMacroVars;
%symdel Schulferien Partner Logo Logozusatz backgroundbody backgroundtop district year Theme colmth colsdy;
%mend;
/* Definition vom Papierformat ausrichtung (muss im ODS Layout entsprechend angepasst werden */
options orientation = landscape
papersize = (85.6cm 60.6cm)
nodate
nonumber
topmargin = .001cm
bottommargin= .001cm
leftmargin = .001cm
rightmargin = .001cm;
/*Dataset mit den gesetzlichen Feiertagen*/
Proc format;
value $Feiertag
"-" = "kein Feiertag"
"+" = "Feiertag"
"k" = "Feiertag in Gemeinden mit überwiegend katholischer Bevölkerung"
"f" = "Feiertag in Augsburg"
"#" = "Feiertag in bestimmten Gemeinden im Kreis Bautzen und im Westlausitzkreis"
"/" = "kein gesetzlicher Feiertag"
;
value Feiertag
0 = "-"
1 = "+"
2 = "k"
3 = "f"
4 = "#"
;
run;
Data Feiertage;
Format Feiertag $40. date mmddyy8. BW BY BN BB HB HH HE MV NI NW RP SL SN SA SH TH all Feiertag.;
Label
Feiertag = "gesetzlicher Feiertag"
BW = "Baden-Württemberg"
BY = "Bayern"
BN = "Berlin"
BB = "Brandenburg"
HB = "Hansestadt Bremen"
HH = "Hansestadt Hamburg"
HE = "Hessen"
MV = "Mecklenburg-Vorpommern"
NI = "Niedersachsen"
NW = "Nordrhein-Westfalen"
RP = "Rheinland-Pfalz"
SL = "Saarland"
SN = "Sachsen"
SA = "Sachsen-Anhalt"
SH = "Schleswig-Holstein"
TH = "Thüringen"
;
array bl BW--all;
dummy = holiday('easter',&year.);
do over bl; bl=1;end;
Feiertag = "Neujahr "; date = "01JAN&YEAR."d; output;
Feiertag = "Karfreitag "; date = dummy - 2 ; output;
Feiertag = "Ostersonntag "; date = dummy ; output;
Feiertag = "Ostermontag "; date = dummy + 1 ; output;
Feiertag = "Tag der Arbeit "; date = "01MAY&YEAR."d; output;
Feiertag = "Christi Himmelfahrt "; date = dummy + 39 ; output;
Feiertag = "Pfingstsonntag "; date = dummy + 49 ; output;
Feiertag = "Pfingstmontag "; date = dummy + 50 ; output;
Feiertag = "Tag d. Dt. Einheit "; date = "03OCT&YEAR."d; output;
Feiertag = "Nikolaus "; date = "6DEC&YEAR."d; output;
Feiertag = "1. Weihnachten "; date = "25DEC&YEAR."d; output;
Feiertag = "2. Weihnachten "; date = "26DEC&YEAR."d; output;
do over bl; bl = 0; end;
Feiertag = "Fronleichnam "; date = dummy + 60; BW = 1 ; BY = 1; HE = 1; NW = 1; RP = 1; SL = 1; SN = 4; TH = 2; all= 1; output;
do over bl; bl = 0; end;
Feiertag = "Hl. Drei Könige"; date = "06JAN&YEAR."d; BY = 1; BW = 1; all = 1; output;
do over bl; bl = 0; end;
Feiertag = "Maria Himmelfahrt "; date = "15AUG&YEAR."d; BY = 2; SL = 1; all = 1; output;
do over bl; bl = 0; end;
Feiertag = "Reformationstag "; date = "31OCT&YEAR."d; BB = 1; MV = 1; SN = 1; SA = 1; TH = 1; all = 1; output;
do over bl; bl = 0; end;
Feiertag = "Allerheiligen "; date = "01NOV&YEAR."d; BY = 1; BW = 1; NW = 1; RP = 1; SL = 1; all= 1; output;
do over bl; bl = 0; end;
drop dummy;
run;
Proc sort Data= Feiertage;
by date;
run;
/*Dataset mit den Wochentagennamen*/
Data Wochentage;
Format date mmddyy8. Wochentag $40.;
date = holiday('easter',&year);
do while (date <= mdy(1,31,&year+1));
Wochentag = "So"; output;
date + 7;
end;
date = holiday('easter',&year)+1;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Mo"; output;
date+7;
end;
date = holiday('easter',&year)+2;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Di"; output;
date+7;
end;
date = holiday('easter',&year)+3;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Mi"; output;
date+7;
end;
date = holiday('easter',&year)+4;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Do"; output;
date+7;
end;
date = holiday('easter',&year)+5;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Fr"; output;
date+7;
end;
date = holiday('easter',&year)+6;
do while (date <= mdy(1,31,&year+1));
Wochentag = "Sa"; output;
date+7;
end;
date=holiday('easter',&year)-7;
do while (date >= mdy(12,1,&year-1));
Wochentag = "So"; output;
date=date-7;
end;
date=holiday('easter',&year)-6;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Mo"; output;
date=date-7;
end;
date=holiday('easter',&year)-5;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Di"; output;
date=date-7;
end;
date=holiday('easter',&year)-4;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Mi"; output;
date=date-7;
end;
date=holiday('easter',&year)-3;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Do"; output;
date=date-7;
end;
date=holiday('easter',&year)-2;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Fr"; output;
date=date-7;
end;
date=holiday('easter',&year)-1;
do while (date >= mdy(12,1,&year-1));
Wochentag = "Sa"; output;
date=date-7;
end;
run;
Proc Sort;
by date;
run;
/************* Dataset mit den Monaten und Tagen. Eine Observation für jeden Tag wird erstellt *************/
data calendar_&year(drop=fdoy);
format date mmddyy8. /*dow dow.*/;
do date=mdy(12,1,&year-1) to mdy(1,31,&year+1);
year = year(date);
monthnum = month(date);
dom = input(put(date,day2.), 2.);
kw= week(date,'v');
/* Get holidays */
fdoy=mdy(1,1,&year);
/*length note $100;
note = ' ';*/
output;
end;
run;
/* Hier können individuelle Notizen eingetragen werden Ein Beispiel ist auskommentiert */
data mydates;
length note $100;
date = &easter - 3; note = "Gründonnerstag"; output;
date = "6Dec2015"d; note = "Nikolaus";  output;
date = "13DEC2015"d; note = "3. Advent";  output;
date = "20DEC2015"d; note = "4. Advent";  output;
date = "24DEC2015"d; note = "Heiligabend";  output;
date = "25DEC2015"d; note = "1. Weihnachtstag";  output;
date = "26DEC2015"d; note = "2. Weihnachtstag";  output;
date = "31DEC2015"d; note = "Silvester";  output;
date = "8Feb2016"d; note = "Rosenmontag";  output;
date = "10May2016"d; note = "Muttertag";  output;
date = "18Nov2016"d; note = "Buß- und Bettag";  output;
date = "27Nov2016"d; note = "1. Advent";  output;
date = "4Dec2016"d; note = "2. Advent";  output;
date = "11Dec2016"d; note = "3. Advent";  output;
date = "18Dec2016"d; note = "4. Advent";  output;
date = "24Dec2016"d; note = "Heiligabend";  output;
date = "31Dec2016"d; note = "Silvester";  output;
date = "1Jan2017"d; note = "Neujahr";  output;
date = "6Jan2017"d; note = "Hl. Drei Könige";  output;

run;
proc sort;
by date;
run;
data cFeiertag (keep= date Feiertag);
set Feiertage;
where &district in(1,5);
run;
/* Merge the two date data sets together. */
data calendar1_&year;
merge calendar_&year mydates cFeiertag(keep=date Feiertag) Wochentage;
by date;
length dom_notes $150;

/* Append note text to the day of month value */
If Feiertag ="Reformationstag" then dom_notes= "^{style [fontsize=26pt]" || put(dom,2.)||"} " || trim(Wochentag)||" " || "^{style [fontsize=8pt]" ||trim(note)|| trim(Feiertag) ||"}";
else If Wochentag ="Mo" and Feiertag ^= "Reformationstag" then dom_notes= "^{style [fontsize=26pt]" || put(dom,2.)||"} " || trim(Wochentag)||" " || "^{style [fontsize=8pt]" ||trim(note)|| trim(Feiertag) ||"}" ||"                "||"^{style [fontsize=15pt]" ||put(kw,2.)||"}";
else if Wochentag in ("Sa") then dom_notes = "^{style [foreground=#de1f28]" ||  "^{style [fontsize=26pt]" || put(dom,2.)||"} " || trim(Wochentag) ||"}"||" "||"^{style [fontsize=8pt]" ||trim(note)|| trim(Feiertag) ||"}";
else if Wochentag in ("So") then dom_notes = "^{style [Background=RGBA5984adC8]^{style [foreground=#de1f28]" ||  "^{style [fontsize=26pt]" || put(dom,2.)||"} " || trim(Wochentag) ||"}"||"  "||"^{style [fontsize=8pt]"||trim(note)|| trim(Feiertag) || '}';
else do dom_notes = "^{style [fontsize=26pt]" || put(dom,2.)||"} " || trim(Wochentag) ||" "|| "^{style [fontsize=8pt]" ||trim(note)|| trim(Feiertag) ||"}";
end;


/*dom_notes=tranwrd(dom_notes,"                         ","");
dom_notes=tranwrd(dom_notes,"            ","");*/
run;
data calendar2_&year.;
set calendar1_&year.;
if year=&year then
monthname = put (monthnum, nlstrmon.);
else if year=&year-1 then do;
monthname = "Dez"||put(year,4.);
monthname1="Dez"||" "||put(year,4.);
call symput ('vj_dez', monthname);
call symput ('vjlabel', monthname1);
end;
else do;
monthname = "Jan"||put(year,4.);
call symput ('fj_jan', monthname);
monthname2 = "Jan"||" "||put(year,4.);
call symput ('fjlabel', monthname2);
end;
run;
proc sort;
by dom year;
run;
/* Transponieren: Eine Notes-Variable pro Monat */
proc transpose data=calendar2_&year out=notes_calendar_&year;
by dom;
id monthname;
var dom_notes;
run;
Data Ferien;
	infile "C:\Users\kybeidos\Documents\sastraining\Kalender\Ferien\Ferien2016.txt" dlm=',';
	input Ferienzeit :$18. Winter :$14. Ostern :$14. Pfingsten :$14. Sommer :$15. 
			Herbst :$14. Weihnachten :$14.;
run;

proc transpose data=Ferien out=Ferien;
var Winter Ostern Pfingsten Sommer Herbst Weihnachten;
id Ferienzeit;
run;

Data Ferienfinal;
	set Ferien (rename=(_Name_=Ferien));
	label Ferien=Ferien;
run;
/* Ausgabe des Kalenders. PDF File wird generiert. */
ods html close;
ods pdf file = "kalender&year..pdf" dpi=300;
ods noproctitle;
ods escapechar = "^";
title;
footnote;
/* Mit ODS Layout wird ein Bereich definiert in dem dann mit Definitionen von sog. Regions und Koordinatenangaben
beliebig angeordnet werden kann*/
ods layout start
width=85.5cm height=60.5cm
;
ods region x=0cm
y=0cm
;
ods pdf text="^{style [cellwidth=85.6cm cellheight=12.3cm backgroundimage='&backgroundtop']}";
run;
ods region x=0cm
y=12.3cm
;
ods pdf text="^{style [cellwidth=85.6cm cellheight=40.84cm backgroundimage='&backgroundbody']}";
run;
ods region x=67.3cm
y=2.8cm
;
ods pdf text="^{Style [cellwidth=16.2cm cellheight=4.2cm backgroundimage='&Logo'}";
run;
ods region x=75.7cm
y=7.24cm
;
ods pdf text="^{Style [cellwidth=6cm cellheight=1.2cm backgroundimage='&Logozusatz'}";
run;
ods region x=22.3cm
y=1.3cm
;
ods pdf text="^S={font_weight=bold font_size=150pt font_face=Arial color=#005193}&year";
run;
ods region x=5.3cm
y=2.3cm
;
ods pdf text="^{Style [cellwidth=12cm cellheight=4cm backgroundimage='&Partner'}";
run;

ods region x=5.3cm
y=6.5cm
;
ods pdf text="^S={font_weight=bold font_size=16pt font_face=Arial color=#005193}www.c-commons.de";
run;

ods region x=0.3cm
y=12.3cm
;
/* Der Kalender wird als Report generiert */
proc report data=notes_calendar_&year center nowd
style(report)=[font=(Arial, 16pt) background=RGBAc1eaf2c8]
style(column)=[font=(Arial, 16pt) cellheight=1.246cm cellwidth=5.5cm]
style(header)=[font=(Arial, 16pt) font_weight=bold]
split='*';
label M_rz = 'März' &vj_dez="&vjlabel" &fj_jan="&fjlabel";
columns dom &vj_dez. Januar Februar M_rz April Mai Juni Juli August
September Oktober November Dezember &fj_jan.;
define dom / order=internal noprint;
define &vj_dez. / style=[background=RGBA5984adC8]width=5;
define Januar / width=5;
define Februar / width=5;
define M_rz / width=5;
define April / width=5;
define Mai / width=5;
define Juni / width=5;
define Juli / width=5;
define August / width=5;
define September / width=5;
define Oktober / width=5;
define November / width=5;
define Dezember / width=5;
define &fj_jan. / style=[background=RGBA5984adC8] width=5;
compute &vj_dez.;
If substr(&vj_dez., 4, 7) ="Sonntag" then call Define("&vj_dez.", "Style", "Style=[foreground=#de1f28]");
Endcomp;
compute &fj_jan.;
If substr(&fj_jan., 4, 7) ="Sonntag" then call Define("&fj_jan.", "Style", "Style=[foreground=#de1f28]");
Endcomp;
run;

ods region x=1.1cm y=53.34cm
			width=45cm;
proc report data=Ferienfinal
style(report)=[font=(Arial, 10pt)]
style(column)=[font=(Arial, 10pt)]
style(header)=[font=(Arial, 10pt)]
split='*';
label BW= 'Baden-Wtb' Mecklenburg_Vorp_= 'Mecklenburg-V.' Rheinland_Pfalz='Rheinland-P.' Sachsen_Anhalt='Sachsen-Anhalt' Schleswig_Holstein='Schleswig-H.' Th_ringen = 'Thüringen' ;
columns Ferien BW Bayern Berlin Brandenburg Bremen Hamburg Hessen Mecklenburg_Vorp_ Niedersachsen NRW Rheinland_Pfalz Saarland Sachsen
Sachsen_Anhalt Schleswig_Holstein Th_ringen;
run;

ods region x=47cm y=53.34cm;
ods pdf text="^S={font_weight=bold font_size=20pt font_face=Arial color=#80e232}/******************************************************
*******************************************************************************/^{newline}/*^{nbspace 184}*/^{newline}/*
^{nbspace 24}Dieser Kalender wurde ausschließlich mit Hilfe der SAS/Base Programmiersprache ^{nbspace 17}*/^{newline}/*
^{nbspace 23} erstellt. Der Programmcode ist frei verfügbar auf: www.kybeidos.de/SAS-Kalender^{nbspace 19}*/^{newline}/*^{nbspace 184}*/
^{newline}/***********************************************************************************************************************
**************/";
run;
ods layout end;
ods pdf close;
%delAllMacroVars;
