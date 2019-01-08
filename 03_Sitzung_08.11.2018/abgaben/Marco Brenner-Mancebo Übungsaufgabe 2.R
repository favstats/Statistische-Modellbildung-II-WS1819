rm(list=ls())

setwd("C:/Users/Marco/Desktop/allbus")
getwd()

library(foreign)

allbus <- read.spss("allbus2014.sav", to.data.frame = T, use.value.labels = F, use.missings = T)

library(psych)
describe(allbus$V84)

allbus$alter_z <- (allbus$V84 - 49.44) / 17.51

allbus$alter_0z <- allbus$V84 - 18
describe(allbus$alter_0z)
allbus$alter_0z <- (allbus$alter_0z - 31.44) / 17.51

# Vergleich von Mean und Standardabweichung von alter_z und alter_0z
describe(allbus$alter_z)
describe(allbus$alter_0z)

# Vergleich der Zahlenwerte
head(allbus$alter_z, n = 20)
head(allbus$alter_0z, n = 20)

# Modell 1
library(texreg)

allbus$alter_0 <- allbus$V84 - 18
model1 <- lm(V420 ~ alter_0 + V86, data = allbus)

# Modell 2
describe(allbus$V86)
allbus$bildung_z <- (allbus$V86 - 3.36) / 1.25
describe(allbus$bildung_z)

model2 <- lm(V420 ~ alter_0z + bildung_z, data = allbus)

screenreg(model1)
screenreg(model2)

# Modell 2 mit z-transformierter Einkommensvariable
describe(allbus$V420)
allbus$einkommen_z <- (allbus$V420 - 11.15) / 4.96

model2 <- lm(allbus$einkommen_z ~ alter_0z + bildung_z, data = allbus)

screenreg(model2)
library(lm.beta)
lm.beta(model2)

# Aufgabe 3, R² so groß wie möglich.


model3 <- lm(V420 ~ V84 + V81 + V86 + V419 + V729 + V608 + V6 + V103 + V209 + V190 + V167 + V174 + V193 
             + V225 + V417 + V272 + V199 + V9 + V125 + V130 + V132 + V200 + V201 + V204 + V295, data = allbus)
screenreg(model3)


