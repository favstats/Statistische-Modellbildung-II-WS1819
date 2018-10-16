* Encoding: UTF-8.
*Ziel: EU Zugehörigkeitsgefühl erklären.

*1. Schritt: Variablen auswählen.

*Alter.
frequencies d11. 

*Soziale Klasse.
frequencies d63. 

*Links - Rechts Platzierung.
frequencies d1. 

*2. Schritt Rekodieren.

compute geburtsjahr= 2017-d11.
variable labels geburtsjahr "Geburtsjahr".
frequencies geburtsjahr.

Recode d63 (1=0) (2=0) (3=0) (4=1) (5=1) (else=SYSMIS) into class.
variable labels class "Soziale Klasse".
value labels class 0"Untere Schicht" 1"Oberschicht".
frequencies class.

Recode d1 (1=1) (2=1) (3=2) (4=2) (5=3) (6=3) (7=4) (8=4) (9=5) (10=5) into linksrechts.
variable labels linksrechts "Links Rechts Einstufung".
value labels linksrechts 1"Sehr Links" 2"Links" 3"Mitte" 4"Rechts" 5"Sehr Rechts".
*execute.
frequencies linksrechts.



compute feel_eu = 5 - qd2_1.

frequencies feel_eu.
variable labels feel_eu "EU Identifkation".
frequencies feel_eu.

*3. Schritt Regressionen.

*Modell.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT feel_eu
  /METHOD=ENTER geburtsjahr class linksrechts.
