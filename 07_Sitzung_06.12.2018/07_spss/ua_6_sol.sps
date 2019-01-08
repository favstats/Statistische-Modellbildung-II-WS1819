* Encoding: UTF-8.
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

recode V601 (1 = 0) (3 = 1) (3 thru 6 = 0) into katholisch.
mis val katholisch (99).
fre katholisch.

LOGISTIC REGRESSION VARIABLES spd
/METHOD=ENTER evangelisch gewerkschaft 
/save=PRED.

TEMPORARY.
select if evangelisch=1 and gewerkschaft=1.
fre PRE_1.

LOGISTIC REGRESSION VARIABLES spd
/METHOD=ENTER katholisch gewerkschaft 
/save=PRED.

TEMPORARY.
select if katholisch=1 and gewerkschaft=0.
fre PRE_2.

