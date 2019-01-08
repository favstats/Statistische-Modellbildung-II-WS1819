* Encoding: UTF-8.



* SM II Tutorium
* Aufgabenblatt #1


** Zu Aufgabe 1:

*** a)
*Unter >Auspartialisierung< versteht man das (schrittweise) "Herausrechnen" von Varianzanteilen einer X-Variable, die durch andere X-Variablen erklärt werden können.
*Das entsprechende X wird also um die Einflüsse weiterer unabhängiger X-Variablen "bereinigt", sodass der "reine" Einfluss einer bestimmten X-Variable auf die abhängige Variable bestimmt werden kann.
*Auch wenn die weiteren X-Variablen keinen direkten Einfluss auf die abhängige Variable haben, so können sie doch mit der interessierenden X-Variablen zusammenhängen (für Teile ihrer Varianz verantwortlich sein).
*Dadurch wird der reine Einfluss einer einzelnen Variable auf die abhängige Variable "verschmutzt" und dies kann zu anderen Ergebnissen führen (Regressionskoeffizienten unterscheiden sich).
*Um aussagekräftige Ergebnisse zu erzielen, sollten daher möglichst alle (theoretisch) in Verbindung stehenden X-Variablen in ein Modell aufgenommen werden.
*Daraufhin können (beispielsweise durch eine sequentielle Regressionsanalyse) ihre jeweiligen Varianzanteile besser aufgeschlüsselt werden.

*** b)
*Bivariate Korrelationen zwischen einer X- und einer Y-Variable können bei alleiniger Betrachtung unter anderem durch Einflüsse "im Hintergrund" der X-Variablen beeinflusst sein.
*Wie in Aufgabenteil a) beschrieben können andere X-Variablen, welche dann in den multiplen Modellen mit berücksichtigt werden, als so genannte >Supressor-Variablen< fungieren.
*Damit ist gemeint, dass der wahre Zusammenhang zwischen einem X und dem Y bivariat noch unterdrückt ist und erst freigegeben wird, wenn die Hintergrund-Variable ebenfalls im Modell enthalten ist.
*Durch die Aufnahme der Hintergrund-Variable werden nämlich die Varianzanteile der vormals (im bivariaten Modell) nicht signifikanten X-Variable (mittels Auspartialisierung) herausgerechnet, 
*die mit der Hintergrund-Variable, aber nicht mit der abhängigen Variable zusammenhängen.
*Übrig bleibt und hervortreten kann dann der wahre und gegebenenfalls signifikante Effekt einer X-Variablen, welcher zuvor durch die im Hintergrund agierende Suppressor-Variable unterdrückt wurde.
*(Hinweis: Verschiedene Arten von Suppressor-Variablen können unterschiedlich wirken, d.h. auch ein bivariat signifikanter Zusammenhang kann sich im multivariaten Modell als insignifikant erweisen.)


** Zu Aufgabe 2:

*** 1. Schritt: Datensatz manuell öffnen (per Doppelklick auf Datei).

*Name: allbus2014.sav

*** 2. Schritt: Relevante Variablen identiﬁzieren (durch Suche im entsprechenden Codebuch).

*ALTER: BEFRAGTE<R> -> V84
*GESCHLECHT, BEFRAGTE<R> -> V81
*ALLGEMEINER SCHULABSCHLUSS -> V86
*NETTOEINKOMMEN<OFFENE+LISTENANGABE>,KAT. -> V420

*** 3. Schritt: Subset der Variablen erstellen.

*"Extras" -> "Variablensets definieren..." -> "Setname" vergeben -> Variablen auswählen (siehe oben) und zu "Variablen im Set" hinzufügen -> "Set hinzufügen"
*Setname: "Aufgabenblatt_1"
*"Extras" -> "Variablensets verwenden..."

*** 4. Schritt: Variablen umbenennen.

FREQUENCIES V81 V84 V86 V420.

VARIABLE LABELS 
V81 Geschlecht
V84 Alter
V86 Schulabschluss bzw. Schulbildung
V420 individuelles Nettoeinkommen.

FREQUENCIES V81 V84 V86 V420.

*** 5. Schritt: Variablen rekodieren (da ein Variablenset verwendet wird, werden die ursprünglichen Variablen überschrieben, statt neue zu kreieren).

*Alter:

FREQUENCIES V84.
COMPUTE V84=V84-18.
FREQUENCIES V84.

*Schulabschluss bzw. Schulbildung:

FREQUENCIES V86.
RECODE V86 (1=0) (2=1) (3=2) (4=3) (5=4) (else=SYSMIS).
VALUE LABELS V86
0 "kein Schulabschluss"
1 "HS"
2 "RS"
3 "FHR"
4 "Abi".
FREQUENCIES V86.

*Geschlecht:

FREQUENCIES V81.
RECODE V81 (2=0).
VALUE LABELS V81
0 "weiblich"
1 "männlich".
FREQUENCIES V81.


** Zu Aufgabe 3:

*Modell a

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT V420 
  /METHOD=ENTER V84.

*Modell b

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT V420 
  /METHOD=ENTER V86.

*Modell c

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT V420 
  /METHOD=ENTER V81.

*Modell ab

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT V420 
  /METHOD=ENTER V84 V86.

*Modell abc

REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT V420 
  /METHOD=ENTER V84 V86 V81.

*** a)
*Die unstandardisierten Regressionskoeffizienten (RK) können nicht zum Vergleich herangezogen werden, da verschiedene Variablen (unterschiedliche Skalierung) in den Modellen verwendet werden.
*Unstandardisierte RK werden zum Vergleich derselben Variable(n) mittels identischer Modelle, aber in unterschiedlichen Stichproben (verschiedene Daten) verwendet.
*Streng genommen können die standardisierten RK, die hier berichtet werden, nicht für den Vergleich über verschiedene Modelle hinweg verwendet werden, 
*sondern eigentlich nur unterschiedlich skalierte Variablen innerhalb eines Modells (d.h. z.B. innerhalb von ab ODER abc) vergleichen.
*Modell a (Alter): 0,068
*Modell b (Schulbildung): 0,255
*Modell c (Geschlecht): 0,350
*Modell ab (Alter / Schulbildung): 0,135 / 0,291
*Modell abc (Alter / Schulbildung / Geschlecht): 0,140 / 0,302 / 0,359
*Gezeigt werden können so allerdings Suppressor-Effekte (siehe Aufgabe 1 b)):
*Der RK der Variable Alter wird deutlich größer, wenn die Variable Bildung hinzugezogen wird (andersherum nicht ganz so stark), da diese gemeinsam variieren, 
*was auch aus theoretischer Perspektive plausibel erscheint (Modell ab).
*Bei Hinzunahme der Variable Geschlecht bleiben die Effekte aller Variablen hingegen quasi gleich (Modell abc).

*** b)
*R² (Determinationskoeffizient, unten berichtet) wird als ein Maß der Güte eines Regressionsmodells verwendet (vereinfacht ausgedrückt: Anteil der durch (alle) X erklärten Varianz von Y), doch ist sehr fehleranfällig.
*Daher sollten eigentlich immer Standardschätzfehler (SEE) sowie Gesamtmodell-Signifikanz (F-Test) zusätzlich betrachtet werden.
*Im bivariaten Fall gilt ähnliches wie für die Regressionskoeffizienten beim Vergleich zwischen Modellen (siehe Aufgabenteil a)), da R² aus r berechnet werden kann.
*Da R² durch die Anzahl der X-Variablen verzerrt werden kann (durch die Aufnahme weiterer X-Variablen kann R² nur größer werden oder in seltenen Fällen gleich bleiben),
*sollte eigentlich stets zusätzlich das korrigierte R² betrachtet werden (hier aufgrund der geringen Anzahl an Variablen keine nennenswerten Unterschiede).
*Modell a (Alter): 0,005
*Modell b (Schulbildung): 0,065
*Modell c (Geschlecht): 0,122
*Modell ab (Alter, Schulbildung): 0,082
*Modell abc (Alter, Schulbildung, Geschlecht): 0,211
*Das Modell mit den meisten Variablen (abc) hat - wie zu erwarten war - den größten R²-Wert -> es scheint mehr Varianz von Einkommen erklärt werden zu können, wenn alle drei Variablen berücksichtigt werden.
*Der R²-Wert von Modell abc kann nicht mittels der Rechung im bivariaten Modell mit den Werten von Modell a, Modell b und Modell c oder Modell ab und Modell c berechnet werden,
*da die bereits erwähnten Hintergrund-Effekte, also Zusammenhänge der X-Variablen, auch hier beobachtet werden können und mit einbezogen werden.


*ENDE