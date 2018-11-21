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




 **Aufgabe 1b**
*Testen Sie das Gesamtmodell auf Linearität..



 **Aufgabe 2b**
*Wie ausgeprägt ist die Multikollinearität im Regressionsmodell von Aufgabe 1? 
Welche Gründe (inhaltliche) lassen sich für die Multikollinearität identifizieren?



**Aufgabe 4**
*Bestimmen Sie den minimalen Stichprobenumfang für eine 
Variablenbeziehung in der Höhe von ca. f2=0.1. Die Variablenbeziehung soll 
in einem Regressionsmodell mit 20 weiteren Kontrollvariablen mit einer 
Power von 0.8 und einem Signifikanzniveau von 95% 
(bzw. Irrtumswahrscheinlichkeit 0.05) getestet werden. 
*Stellen Sie Ihren Denk- /Rechenvorgang dar.

**Aufgabe 5.**
 Welche Form von Fehlschluss wird durch ein 
niedriges Signifikanzniveau "begünstigt"?.





**Aufgabe 6.** 
In welchen Fällen ist es sinnvoll das Signifikanzniveau 
höher anzusetzen als 95%?.
