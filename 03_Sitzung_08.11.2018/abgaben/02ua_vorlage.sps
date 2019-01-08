* Encoding: UTF-8.
*Datenaufbereitung aus vorheriger Woche'.

*Alter.
compute alter= v84.
compute alter0= v84-18.
variable labels alter0 "Alter mit 18 als Nullpunkt".
FREQUENCIES VARIABLES=alter0
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Bildung.
Recode v86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS) into bildung_rec.
variable labels bildung_rec "Abschluss umkodiert".
value labels bildung_rec 0"Kein Schulabschluss" 1"Hauptschule" 2"Realschule" 3"Fachhochschulreife" 4"Abi".
FREQUENCIES VARIABLES=bildung_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Geschlecht.
Recode v81 (2=0) (1=1) (else=copy) into geschl_rec.
variable labels geschl_rec "Geschlecht mit w=0".
value labels geschl_rec 0"weiblich" 1"männlich".
FREQUENCIES VARIABLES=geschl_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Einkommen.
COMPUTE einkommen = v420.
FREQUENCIES VARIABLES=einkommen 
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.


*Aufgabe 2**.

*Führen Sie eine z-Standardisierung für die Originalaltersvariable (alter_z) 
und die auf Null gesetzte Altersvariable (alter_0z) sowie für „unsere“ 
Bildungsvariable (0 bis 4). [Daten: ALLBUS 2014].
DESCRIPTIVES VAR = alter alter0
/SAVE.
RENAME VARIABLES (Zalter Zalter0 = alter_z alter0_z).

*Aufgabe 2a**.

*Vergleichen Sie die Zahlenwerte, Mean und die Standardabweichung 
von alter_z und alter_0z und erklären Sie Ihre „Beobachtung“.
FREQUENCIES alter_z alter0_z
 /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Aufgabe 2b**.

*Führen Sie eine Regression von Einkommen auf Alter_0 und Bildung (Modell 1)
und eine Regression von Einkommen auf alter_0z und bildung_z (Modell 2) 
durch und vergleichen Sie die b-Koeffizienten.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER alter0 bildung_rec.

*z-Transformation Bildung.
DESCRIPTIVES VAR = bildung_rec
/SAVE.
RENAME VARIABLES (Zbildung_rec = bildung_rec_z).

*z-Transformation Einkommen.
DESCRIPTIVES VAR = einkommen
/SAVE.
RENAME VARIABLES (Zeinkommen = einkommen_z).

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen_z
  /METHOD=ENTER alter0_z bildung_rec_z.

*Aufgabe 2c**.

*Wie erklären Sie die Werte b und b* in Modell 2?
*TIPP: Verwenden Sie bei Modell 2 das z-transformierte 
Einkommen als abhängige Variable.


*Aufgabe 3**.

*Erstellen Sie ein multivariates Regressionsmodell mit Y=Einkommen. 
*Versuchen Sie dabei den R²-Wert so groß wie nur irgendwie möglich 
zu bekommen. Jeder schmutzige Trick der Sozialforschung ist erlaubt 
(und in diesem Fall erwünscht). Fügen Sie die entsprechenden Teile des 
SPSS-Outputs in Ihre Abgabe ein.

*- Einzige Einschränkung: Keine Regression von Y auf Y.
CORRELATIONS
/VARIABLES = V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12
/PRINT=TWOTAIL NOSIG
/MISSING=PAIRWISE.

*Schichtzugehörigkeit.
Missing values v172 (6 to 9).
fre v172.

*Model abc.
DATASET ACTIVATE DataSet1.
REGRESSION
/DESCRIPTIVES MEAN STDDEV CORR SIG N  
/MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT v420
  /METHOD=ENTER alter0 bildung_rec geschl_rec v425 v70 v71 v727 v730 v521 v96 v95 v128 v172 v729 v38 v417 v491 v8 v9.

*v128 wieder rein.
*Output rauskopieren und Mechanismen zum Hochtreiben 2/3 Sätze.
