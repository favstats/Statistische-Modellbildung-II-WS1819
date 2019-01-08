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
Berechnen und interpretieren Sie die AMEs fuer beide unabhängige Variablen.

LOGISTIC REGRESSION VARIABLES [Y-Variable]
/METHOD=ENTER [X1-Variable] [X2-Variable].

COMPUTE b0= [Intercept des Regressionsmodells].
COMPUTE b1= [Koeffizient der X1-Variablen].
COMPUTE b2= [Koeffizient der X2-Variablen].
COMPUTE z0= (b0) + (b1*0) + (b2*[X2-Variable]).
COMPUTE exp0= exp(z0).
COMPUTE p0= exp0/(1+exp0).
COMPUTE z1=(b0) + (b1*1) + (b2*[X2-Variable]).
COMPUTE exp1=exp(z1).
COMPUTE p1=exp1/(1+exp1).
COMPUTE me=(p1-p0). 
*Bem.: Ermittlung der marginalen Effekte von X1.
FRE me / STATISTICS=MEAN. 
*Bem.: der Mean entspricht dem AME von X.

**Aufgabe 1c
*Berechnen Sie ein weiteres (nested) log. Regression 
mit zwei weiteren (frei wählbaren) unabhängigen Variablen (Modell 2)

*Aufgabe 2
*Berechnen Sie einen Likelihood Ratio-$\chi^2$-Test mit Modell 2 und Modell 1.



**Aufgabe 3b
*Können Sie Verzerrungen mit Blick auf die Y-Werteverteilung, 
die Vollständigkeit der Information und die (vollständige) 
Separation identifizieren?*


