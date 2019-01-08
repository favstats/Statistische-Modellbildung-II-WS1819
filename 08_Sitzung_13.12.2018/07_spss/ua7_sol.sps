* Encoding: UTF-8.
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


*Wahlabsicht : V810.
fre V810.
recode V810 (2 = 1) (1 = 0) (3 thru 90 = 0) (else = 99) into spd.
mis val spd (99).
fre spd.

*Gewerkschaft: v606.
fre v606.
recode v606 (1 = 1) (2 = 0) (else = 99) into gewerkschaft.
mis val gewerkschaft (99).
fre gewerkschaft.

*Konfession: V601.
fre V601.
recode V601 (1 = 1) (2 = 1) (3 thru 6 = 0) into evangelisch.
mis val evangelisch (99).
fre evangelisch.

**Aufgabe 1a
*Berechnen Sie eine log. Regression (Modell 1) 
AV: SPD-Wahl und UV: die Gewerkschaftsmitgliedschaft 
und die ev. Konfessionszugehörigkeit.

**Aufgabe 1b
*Berechnen Sie ein weiteres (nested) log. Regression 
mit zwei weiteren (frei wählbaren) unabhängigen Variablen (Modell 2)

*Aufgabe 2
*Berechnen Sie einen Likelihood Ratio-$\chi^2$-Test mit Modell 2 und Modell 1.

LOGISTIC REGRESSION VARIABLES spd
  /METHOD=ENTER gewerkschaft evangelisch 
  /METHOD=ENTER bildung_rec geschl_rec.

**Aufgabe 3b
*Können Sie Verzerrungen mit Blick auf die Y-Werteverteilung, 
die Vollständigkeit der Information und die (vollständige) 
Separation identifizieren?*

fre spd.

CROSSTABS
  /TABLES=spd BY bildung_rec geschl_rec gewerkschaft evangelisch
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.
