rm(list=ls())

setwd("C:/Users/Marco/Desktop/allbus")
getwd()

library(foreign)

allbus <- read.spss("allbus2014.sav", to.data.frame = T, use.value.labels = F, use.missings = T)

# Alter                      V84
# Geschlecht                 V81
# Schulabschluss             V86
# individuelles Nettoeink.   V420

# Alter minus 18
allbus$V84 <- allbus$V84 - 18

# Geschlecht auf 0 = w und 1 = m 
allbus$V81[which(allbus$V81 == 2)] <- 0

# Schulabschluss recodieren
allbus$V86[which(allbus$V86 == 1)] <- 0
allbus$V86[which(allbus$V86 == 2)] <- 1
allbus$V86[which(allbus$V86 == 3)] <- 2
allbus$V86[which(allbus$V86 == 4)] <- 3
allbus$V86[which(allbus$V86 == 5)] <- 4
allbus$V86[which(allbus$V86 == 6)] <- NA
allbus$V86[which(allbus$V86 == 7)] <- NA


# lineare Regressionsmodelle
model_a <- lm(V420 ~ V84, data = allbus)
model_b <- lm(V420 ~ V86, data = allbus)
model_c <- lm(V420 ~ V81, data = allbus)
model_ab <- lm(V420 ~ V84 + V86, data = allbus)
model_abc <- lm(V420 ~ V84 + V86 + V81, data = allbus)

library(texreg)
screenreg(model_a)
screenreg(model_b)
screenreg(model_c)
screenreg(model_ab)
screenreg(model_abc)


