#install.packages("foreign")
library("foreign") 
#install.packages("survey")
library("survey")
install.packages("dplyr")
library("dplyr")


allbus<-read.spss ("C:/Users/Vanes/Desktop/Allbus.sav",
                 to.data.frame=T, use.value.labels = FALSE,reencode=T)


#relevante Variablen: 
#V84	ALTER: BEFRAGTE<R>
#V86	ALLGEMEINER SCHULABSCHLUSS
#V81	GESCHLECHT, BEFRAGTE<R>
#V420 NETTOEINKOMMEN<OFFENE+LISTENANGABE>,KAT.


#Alter Befragter v84
table(allbus$V84)
allbus$age<-allbus$V84-18
allbus$age


#Geschlecht 0 =weiblich 1 =männlich
#Geschlecht v81 bis jetzt: 1= männlich 2 =weiblich
allbus$V81
allbus$sex<-allbus$V81
allbus$sex[allbus$V81==2]<-0
allbus$sex

#Schulabschluss v86
#5 Ausprägungen; 0=kein Schulabschluss, 1=HS, 2=RS, 3=FHR, 4=Abi; Rest=-1 bzw. Missing --> soll sein
allbus$V86

#allbus$education = ifelse(allbus$V86 == 6 | allbus$V86 == 7, NA, allbus$education - 1)
allbus$education<-allbus$V86-1
allbus$education[allbus$education>=5]<- NA 
allbus$education

#Einkommen: V420


#z-Standardisierung
allbus$age.z<-(allbus$age-mean(allbus$age,na.rm=T))/sd(allbus$age,na.rm=T)
allbus$V84.z<-(allbus$V84-mean(allbus$V84,na.rm=T))/sd(allbus$V84,na.rm=T)
describe(allbus$age.z)
describe(allbus$V84.z)
allbus$age.z
allbus$V84.z

allbus$education.z<-(allbus$education-mean(allbus$education,na.rm=T))/sd(allbus$education,na.rm=T)
allbus$V420.z<-(allbus$V420-mean(allbus$V420,na.rm=T))/sd(allbus$V420,na.rm=T)


#z-Standardisierung
#select(allbus,age, education)
#mutate(allbus, age.z = scale(allbus$age, center = F, scale = T))
#describe(allbus)


#Regression
library("lm.beta")
fit1<-lm(V420~age + education, data=allbus)
summary(fit1)
lm.beta(fit1)


#mit standardisiertem Einkommen
fit3 <- lm(V420.z ~age.z+ education.z, data=allbus)
summary(fit3)
lm.beta(fit3)

#Aufgabe 3: 

#FDP-Wähler
allbus$FDP<-ifelse(allbus$V729==3,1,0)

fit<-lm(V420~age + education + sex + V425+ V128 + V70 + V38 + V71+ V727 + V730 + V521+ V96 + V95+ V417 + V491 + Schicht+ FDP, data=allbus)
summary(fit)
lm.beta(fit)


