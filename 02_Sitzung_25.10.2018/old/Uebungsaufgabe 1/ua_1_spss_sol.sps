* Encoding: UTF-8.
***** Aufgabe 2 *****

*1. Schritt: Variablen auswählen.

*Alter.
frequencies v84 
  /STATISTICS= MIN MAX MEAN.

*Schulabschluss.
frequencies v86 
  /STATISTICS= MIN MAX MEAN.

*Geschlecht.
frequencies v81
  /STATISTICS= MIN MAX MEAN. 

*Einkommen.
frequencies V420
  /STATISTICS= MIN MAX MEAN.

*2. Schritt: Rekodieren.

*Alter.
compute alter0= v84-18.
variable labels alter0 "Alter mit 18 als Nullpunkt".
*frequencies alter0.
FREQUENCIES VARIABLES=alter0
  /STATISTICS= MIN MAX MEAN.

*Schulabschluss.
Recode v86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS) into bildung_rec.
variable labels bildung_rec "Abschluss umkodiert".
value labels bildung_rec 0"Kein Schulabschluss" 1"Hauptschule" 2"Realschule" 3"Fachhochschulreife" 4"Abi".
*frequencies bildung_rec.
FREQUENCIES VARIABLES=bildung_rec
  /STATISTICS= MIN MAX MEAN.

*Geschlecht.
Recode v81 (2=0) (1=1) (else=copy) into geschl_rec.
variable labels geschl_rec "Geschlecht mit w=0".
value labels geschl_rec 0"weiblich" 1"männlich".
*frequencies geschl_rec.
FREQUENCIES VARIABLES=geschl_rec
  /STATISTICS= MIN MAX MEAN.

*Einkommen.
COMPUTE einkommen = v420.
*frequencies einkommen.
FREQUENCIES VARIABLES=einkommen 
  /STATISTICS= MIN MAX MEAN.


**Aufgabe 3**

*Model a.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT einkommen
  /METHOD=ENTER alter0.

*Model b.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT einkommen
  /METHOD=ENTER bildung_rec.

*Model c.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT einkommen
  /METHOD=ENTER geschl_rec.

*Model ab.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT einkommen
  /METHOD=ENTER alter0 bildung_rec.

*Model abc.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /NOORIGIN
  /DEPENDENT einkommen
  /METHOD=ENTER alter0 bildung_rec geschl_rec.





