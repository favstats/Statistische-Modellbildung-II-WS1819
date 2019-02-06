* Encoding: UTF-8.
****************************************************Syntax Übungsaufgabe 10*************************************************************
***********************************************************************************************************************************************

**Benutzen Sie den esse03_mod.sav Datensatz. Benutzen Sie als Gruppierungsvariable „Länder“.

**Aufgabe 1
Berechnen Sie das Nullmodell (Modell0) für die AV: stflife (allgemeine Lebenszufriedenheit).

* REML Schätzung.
MIXED stflife
  /METHOD=REML
  /random=intercept | subject(Länder). 

**Aufgabe 1a
Berechnen Sie den ICC anhand des Nullmodells.


**Aufgabe 1b
Welche Aussage lässt sich auf Grundlage des Nullmodells treffen?


**Aufgabe 2
Berechnen Sie Modell 1 mit der UV: Erwerbsstatus (0=erwerbstätig; 1=arbeitslos).

MIXED stflife with Erwerbsstatus
  /fixed=Erwerbsstatus | sstype(3)
  /print= solution
  /method=REML
  /random=intercept | subject(Länder).

**Aufgabe 2a
Interpretieren Sie den Koeffizienten für Erwerbsstatus inhaltlich (als Fixed-Effekt).

**Aufgabe 2b
Führen Sie einen Likelihood-Ratio-Test (LRT) zwischen Modell0 und Modell1 durch (Achten Sie drauf, dass für den LRT die ML-Schätzung und nicht die REML gewählt werden muss).

* ML Schätzung.
MIXED stflife
  /METHOD=ML
  /random=intercept | subject(Länder). 

MIXED stflife with Erwerbsstatus
  /fixed=Erwerbsstatus | sstype(3)
  /print= solution
  /method=ML
  /random=intercept | subject(Länder).

**Aufgabe 2c
Wie lautet Ihre Schlussfolgerung für Modell 1?

**Aufgabe 3
Lassen Sie in Modell 2 (zusätzlich) den Slope von Erwerbsstatus über die Länder variieren (Random setzen).

* Random Slope (Kovarianz zwischen Länder wird zusätzlich geschätzt).
MIXED stflife with Erwerbsstatus
  /fixed=Erwerbsstatus | sstype(3)
  /method=REML
  /print=solution
  /random=intercept Erwerbsstatus | subject(Länder) covtype(UNR).

**Aufgabe 3a
Führen Sie einen Likelihood-Ratio-Test zwischen Modell 1 und Modell 2 durch.

MIXED stflife with Erwerbsstatus
  /fixed=Erwerbsstatus | sstype(3)
  /print= solution
  /method=ML
  /random=intercept | subject(Länder).

* Random Slope (Kovarianz zwischen Länder wird zusätzlich geschätzt).
MIXED stflife with Erwerbsstatus
  /fixed=Erwerbsstatus | sstype(3)
  /method=ML
  /print=solution
  /random=intercept Erwerbsstatus | subject(Länder) covtype(UNR).

**Aufgabe 3b
Interpretieren Sie den Random Slope von Erwerbsstatus inhaltlich (als Random Effekt).


