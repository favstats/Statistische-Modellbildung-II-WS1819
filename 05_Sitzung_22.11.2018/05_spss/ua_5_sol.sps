* Encoding: UTF-8.
*Datenaufbereitung aus vorheriger Woche'.

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

**Aufgabe 1**
*Erstellen Sie eine Regression von Einkommen auf Bildung, 
Geschlecht und Alter sowie der Dummyvariablen Zugang zu 
tertiärer Bildung (bild_tert), die null kodiert ist, wenn der 
betreffende Befragte einen niedrigeren Schulabschluss als 
Fachhochschulreife hat und eins, wenn Umgekehrtes der Fall ist. 
*Hinzu kommen die Interaktionsvariablen zwischen Geschlecht 
und Alter (gesch_alter) sowie zwischen Alter und Zugang zu 
tertiärer Bildung (alt_tert).*

*- 0   OHNE ABSCHLUSS
- 1   VOLKS-,HAUPTSCHULE
- 2   MITTLERE REIFE
- 3   FACHHOCHSCHULREIFE
- 4   HOCHSCHULREIFE

*Bildung Tertiär dummy.
COMPUTE bild_tert = bildung_rec > 2.
*Alter und Geschlecht Interaktion.
COMPUTE gesch_alter = alter0 * geschl_rec .
*Alter und tertiäre Bildung Interaktion.
COMPUTE alt_tert = alter0 * bild_tert .


REGRESSION
  /DEPENDENT einkommen
  /METHOD=ENTER bildung_rec geschl_rec alter0 bild_tert gesch_alter alt_tert
  /SCATTERPLOT=(*ZRESID , *ZPRED)
  /PARTIALPLOT ALL .

   
 **Aufgabe 1b**
*Testen Sie das Gesamtmodell auf Linearität.

REGRESSION
  /DEPENDENT einkommen
  /METHOD=ENTER bildung_rec geschl_rec alter0 bild_tert gesch_alter alt_tert
  /SCATTERPLOT=(*ZRESID , *ZPRED).

 **Aufgabe 2b**
*Wie ausgeprägt ist die Multikollinearität im Regressionsmodell von Aufgabe 1? 
Welche Gründe (inhaltliche) lassen sich für die Multikollinearität identifizieren?

REGRESSION
  /STATISTICS BCOV TOL
  /DEPENDENT einkommen
  /METHOD=ENTER bildung_rec geschl_rec alter0 bild_tert gesch_alter alt_tert.

