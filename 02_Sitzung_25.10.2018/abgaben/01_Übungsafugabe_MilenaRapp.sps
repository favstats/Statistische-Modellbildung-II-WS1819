* Encoding: UTF-8.
***** Aufgabe 1 *****

*1. Schritt: Variablen auswählen.

*Alter.
FREQUENCIES v84
/statistics=MIN MAX MEAN.
*Schulabschluss.
FREQUENCIES v86
/statistics=MIN MAX MEAN.

*Geschlecht.
fre v81
/statistics=MIN MAX MEAN.

*Einkommen.
fre v420
/statistics=MIN MAX MEAN.
*2. Schritt: Rekodieren.
*Alter.
compute alter0 = v84 -18.
variable labels alter0 "Alter mit 18 als Nullpunkt".
FREQUENCIES alter0.

*Schulabschluss.
recode v86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS) into bildung_rec.
variable labels bildung_rec "Abschluss umkodiert".
value labels bildung_rec 0"Kein Schulabschluss" 1"Hauptschule" 2"Realschule" 3"Fachhochschulreife" 4"anderer Abschluss".
frequencies bildung_rec.

*Geschlecht.
Recode v81 (2=0) (else=copy) into geschl_rec.
variable labels "Geschlecht umkodiert".
value labels geschl_rec 0"weiblich" 1"männlich".
FREQUENCIES geschl_rec.

*Einkommen.
compute einkommen = v420.
FREQUENCIES einkommen.

**Aufgabe 3**

*Model a.
DATASET ACTIVATE DataSet1.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER alter0.

*Model b.
DATASET ACTIVATE DataSet1.
REGRESSION
/DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER bildung_rec.

*Model c.
DATASET ACTIVATE DataSet1.
REGRESSION
/DESCRIPTIVES MEAN STDDEV CORR SIG N  
/MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER geschl_rec.

*Model ab.
DATASET ACTIVATE DataSet1.
REGRESSION
/DESCRIPTIVES MEAN STDDEV CORR SIG N  
/MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER alter0 bildung_rec.

*Model abc.
DATASET ACTIVATE DataSet1.
REGRESSION
/DESCRIPTIVES MEAN STDDEV CORR SIG N  
/MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT einkommen
  /METHOD=ENTER alter0 bildung_rec geschl_rec.



