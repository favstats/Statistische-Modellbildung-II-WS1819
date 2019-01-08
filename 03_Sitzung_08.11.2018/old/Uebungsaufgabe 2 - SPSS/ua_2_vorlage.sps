* Encoding: UTF-8.
*Datenaufbereitung aus vorheriger Woche'.

*Alter.
compute alter0= v84-18.
variable labels alter0 "Alter mit 18 als Nullpunkt".
*FREQUENCIES VARIABLES=alter0
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Bildung.
Recode v86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS) into bildung_rec.
variable labels bildung_rec "Abschluss umkodiert".
value labels bildung_rec 0"Kein Schulabschluss" 1"Hauptschule" 2"Realschule" 3"Fachhochschulreife" 4"Abi".
*FREQUENCIES VARIABLES=bildung_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Geschlecht.
Recode v81 (2=0) (1=1) (else=copy) into geschl_rec.
variable labels geschl_rec "Geschlecht mit w=0".
value labels geschl_rec 0"weiblich" 1"männlich".
*FREQUENCIES VARIABLES=geschl_rec
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.

*Einkommen.
COMPUTE einkommen = v420.
*FREQUENCIES VARIABLES=einkommen 
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS KURTOSIS.


*Aufgabe 2**.

*Führen Sie eine z-Standardisierung für die Originalaltersvariable (alter_z) 
und die auf Null gesetzte Altersvariable (alter_0z) sowie für „unsere“ 
Bildungsvariable (0 bis 4). [Daten: ALLBUS 2014].

*Aufgabe 2a**.

*Vergleichen Sie die Zahlenwerte, Mean und die Standardabweichung 
von alter_z und alter_0z und erklären Sie Ihre „Beobachtung“.

*Aufgabe 2b**.

*Führen Sie eine Regression von Einkommen auf Alter_0 und Bildung (Modell 1)
und eine Regression von Einkommen auf alter_0z und bildung_z (Modell 2) 
durch und vergleichen Sie die b-Koeffizienten.

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


