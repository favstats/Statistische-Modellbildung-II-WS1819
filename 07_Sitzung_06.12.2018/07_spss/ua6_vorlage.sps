* Encoding: UTF-8.
*Wahlabsicht : V810.
fre V810.

*Gewerkschaft: v606.
fre v606.

*Konfession: V601.
fre V601.



*SPSS-Syntax zur Ermittlung des AME für eine dichotome X-Variable 
(vgl. Urban/Mayerl 2018: 413).

*X1 Variable sollte dichotom sein.

LOGISTIC REGRESSION VARIABLES Y-Variable
/METHOD=ENTER X1-Variable X2-Variable.

COMPUTE b0= [Intercept des Regressionsmodells].
COMPUTE b1= [Koeffizient der X1-Variablen].
COMPUTE b2= [Koeffizient der X2-Variablen.].
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
