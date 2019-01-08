* Encoding: UTF-8.

**Aufgabe 1a**
*Berechnen Sie ein Cross-lagged-Design mit zwei Regressionen bzgl. 
*der Variablen Subjektive Gesundheit und Lebenszufriedenheit (Jahre 2003 und 2004).

*Subjektive Gesundheit
- gesund_org.2003
- gesund_org.2004.

*Lebenszufriedenheit
- lebensz_org.2003
- lebensz_org.2004.





**Aufgabe 1b**

*Welche Aussage lässt sich bzgl. der Stabilität der Variablen Lebenszufriedenheit 
und Subj. Gesundheit machen?*


**Aufgabe 1c**

*Wie bewerten Sie die kausale Reihenfolge bzgl. der Effekte Subj. 
*Gesundheit <-> Lebenszufriedenheit anhand der „Kreuzkoeffizienten“. 
*Vergleichen Sie hierzu die Kreuzladungen.*

**Aufgabe 2**

*Allbus2014 Datensatz.

*Alter.
compute alter0= v84-18.
variable labels alter0 "Alter mit 18 als Nullpunkt".
*frequencies alter0.
FREQUENCIES VARIABLES=alter0
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Bildung.
Recode v86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS) into bildung_rec.
variable labels bildung_rec "Abschluss umkodiert".
value labels bildung_rec 0"Kein Schulabschluss" 1"Hauptschule" 2"Realschule" 3"Fachhochschulreife" 4"Abi".
*frequencies bildung_rec.
FREQUENCIES VARIABLES=bildung_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Geschlecht.
Recode v81 (2=0) (1=1) (else=copy) into geschl_rec.
variable labels geschl_rec "Geschlecht mit w=0".
value labels geschl_rec 0"weiblich" 1"männlich".
*frequencies geschl_rec.
FREQUENCIES VARIABLES=geschl_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Einkommen.
COMPUTE einkommen = v420.
*frequencies einkommen.
FREQUENCIES VARIABLES=einkommen 
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.


*Erstellen Sie eine Interaktionsvariable zwischen Geschlecht und Alter und reduzieren 
Sie vor den folgenden Regressionsanalysen den Datensatz, 
um die Fälle, bei denen die Geburtenentscheidungen keine besondere 
Bedeutung mehr für die Gehaltsentwicklung haben sollten 
(Alter unter 46 Jahren, alter0 < 28). 
*Modell 1 enthält dann Alter und Geschlecht, 
in Modell 2 kommt die Interaktionsvariable hinzu.*







**Aufgabe 2a**

*Berechnen	Sie	anhand	von	Modell 1	und	Modell 2	jeweils das prognostizierte	Einkommen	
eines	Mannes und	einer	Frau im	Alter	von	jeweils	30 Jahren.



**Aufgabe 2b**

*Was ist dabei der Interaktionseffekt	und	wie	lässt	er	sich inhaltlich	begründen?*

