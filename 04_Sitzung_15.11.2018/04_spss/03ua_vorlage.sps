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
*Erstellen Sie ein Streudiagramm zwischen den Residuen der 
Regression von "prestige_befragter" auf "bildung_befragter" 
und der Variablen "bildung_befragter". Beschreiben Sie das 
Diagramm, sprich wie die fünf "Streusäulen" in Relation zueinander aussehen. 
*Äußern Sie eine Vermutung ob dies bereits eine Verletzung der A1 
ist und begründen Sie diese kurz

*Eine der Prestigeskalen auswählen:

*- Magnitude-Prestigeskala (MPS)
- Index für den Prestige-Rang von Berufen (SIOPS)
- Internationaler sozio-ökonomischer Index (ISEI).



   
 **Aufgabe 2**
*Erstellen Sie eine Regression von Einkommen auf Alter (Alter_0) 
und speichern Sie dabei die unstandardisierten sowie die 
standardisierte Residuen aus. Erstellen Sie anschließend ein 
Streudiagramm für die beiden unterschiedlichen Residuenarten.
*Die UV soll hierbei das Alter der Befragten sein..



 **Aufgabe 2b**
*Beschreiben Sie die beiden Streudiagramme. 
*Gibt es Unterschiede, falls nein, hängt dies mit der Art 
der Erstellung der Variablen zusammen? 
Beziehen Sie sich bei Ihrer Antwort auf die 
statistischen Kenngrößen, die mittels 
FREQ-Befehl ausgegeben werden.




 ** Aufgabe 3b**

*Testen Sie die Annahme A3 und A5 (Test der Gesamtheit der Residuen) 
für die Residuen von Aufgabe 3. Sind die Annahmen erfüllt? 
Welche Einschränkungen müssen bzgl. des Tests für A5 beachtet werden?*




