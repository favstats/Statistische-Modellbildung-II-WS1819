##%######################################################%##
#                                                          #
####     Übungsaufgabe 1: Multivariate Regression       ####
#                                                          #
##%######################################################%##

# Packages laden

install.packages("devtools")
devtools::install_github("Espanta/lubripack")
lubripack::lubripack("tidyverse","labelled","haven","car", "texreg")


##%######################################################%##
####     Nützliche Funktion zum Variablen suchen:       ####
##%######################################################%##

# var_names findet Variablennamen -- benötigt "labelled" und "tidyverse" package!
var_names <- function(data, keyword = "") {
  keyword <- ifelse(keyword %in% "all", "", keyword) 
  #if 'all' turn into void, else copy keyword
  lablist <-  data %>% 
    var_label() %>% # extract variable labels
    bind_rows() %>% # binding list elements as dataframe
    t() # transpose dataframe
  name_pos <- stringr::str_detect(tolower(lablist[, 1]), tolower(keyword)) 
  # get position of string
  if(any(name_pos)){ #if the string is found
    dat <-data.frame(var_codes=names(lablist[name_pos, ]),
                     var_names=lablist[name_pos, ],
                     row.names = NULL, stringsAsFactors = F)
    #colnames(dat) <- "var_names"
    cat(paste0("####---- Nice! You found ", nrow(dat) , " variables! ----#### \n \n "))
    return(dat)
  } else{
    cat("Variable Name not found. Try again, Stupid!")
  }
}

##%######################################################%##
#                                                          #
####                     Aufgabe 2                      ####
#                                                          #
##%######################################################%##


# Bevor Sie die Analysen durchführen, suchen Sie im Codebuch 
# (o. Variablenliste)  Ihres Datensatzes (ALLBUS 2014) die
# folgenden Variablen heraus: Alter, Geschlecht, Schulabschluss
# und individuelles Nettoeinkommen in der Fassung 
# "Offene Angaben+Listeangaben".

#   Kodieren Sie dann diese Variablen wie folgt:
#   
#   -	Alter: Startwert auf 0 setzen; 18=0, 48=30
#   
#   -	Schulabschluss- bzw. Schuldbildung: 5 Ausprägungen; 
#   0=kein Schulabschluss, 1=HS, 2=RS, 3=FHR, 4=Abi;
#   Rest=-1 bzw. Missing
#   
#   -	Geschlecht: 0=weiblich; 1=männlich


## 1. Schritt: Working Directory setzen

getwd()
path_data <- "C:/Users/Fabio/Dropbox/9. Semester Master/Tutorium"
setwd(path_data)

## 2. Schritt: Datensatz einladen (mit haven und Funktion read_spss)

allbus <- read_spss("allbus2014.sav")
head(allbus)


## 3. Schritt: relevante Variablen identifizieren (mit var_names)

var_names(allbus, "alter") # V84 ALTER: BEFRAGTE<R>
var_names(allbus, "schulabschluss") # V86 ALLGEMEINER SCHULABSCHLUSS
var_names(allbus, "geschl") # V81 GESCHLECHT, BEFRAGTE<R>
var_names(allbus, "eink") # V420 NETTOEINKOMMEN<OFFENE+LISTENANGABE>,KAT.

## 4. Schritt: Jetzt wählen wir die Variablen und erstellen ein Subset! (mit select)

allb_sub <- select(allbus, V84, V86, V81, V420)

## 5. Schritt: Als nächstes benennen wir die Variablen um! (mit rename)

allb_sub <- rename(allb_sub, 
                   alter=V84, 
                   bildung = V86, 
                   geschl = V81, 
                   einkommen = V420)

## 6. Schritt: Als nächstes Rekodieren wir die Variablen (mit ifelse oder Recode)

allb_sub <- mutate(allb_sub, 
                 alter0 = alter - 18,
                 bildung_rec = ifelse(bildung == 6 | bildung == 7, NA, bildung-1),
                 geschl_rec = ifelse(geschl == 2, 0, 1))
  
#ODER mit dem Recode() Befehl aus dem car pacakge
  
allb_sub <- mutate(allb_sub, 
                   alter0 = alter - 18,
                   bildung_rec = Recode(bildung, 
                                        "6 = NA;
                                         7 = NA"),
                   geschl_rec = ifelse(geschl == 2, 0, 1))


##%######################################################%##
#                                                          #
####                     Aufgabe 3                      ####
#                                                          #
##%######################################################%##


# Berechnen Sie folgende (sequentielle) Regressionsmodelle:
#  
#  -	Modell a: Einkommen auf Alter;
#  
#  -	Modell b: Einkommen auf Bildung;
#  
#  -	Modell c: Einkommen auf Geschlecht;
#  
#  -	Modell ab: Einkommen auf Alter und Bildug;
#  
#  -	Modell abc: Einkommen auf Alter, Bildung und Geschlecht.


modell_a <- lm(einkommen ~ alter0, data = allb_sub)
modell_b <- lm(einkommen ~ bildung_rec, data = allb_sub)
modell_c <- lm(einkommen ~ geschl_rec, data = allb_sub)
modell_ab <- lm(einkommen ~ alter0 + bildung_rec, data = allb_sub)
modell_abc <- lm(einkommen ~ alter0 + bildung_rec + geschl_rec, data = allb_sub)


#mit texreg package Modelle visualisieren (screenreg):
screenreg(list(modell_a,
               modell_b,
               modell_c,
               modell_ab,
               modell_abc))

#wenn man standartisierte Variablen wünscht, einfach vorher alle Variablen standartisieren!
#dazu benutzen wir mutate_all und scale!

allb_sub_scale <- mutate_all(allb_sub, scale)

modell_a_beta <- lm(einkommen ~ alter0, data = allb_sub_scale)
modell_b_beta <- lm(einkommen ~ bildung_rec, data = allb_sub_scale)
modell_c_beta <- lm(einkommen ~ geschl_rec, data = allb_sub_scale)
modell_ab_beta <- lm(einkommen ~ alter0 + bildung_rec, data = allb_sub_scale)
modell_abc_beta <- lm(einkommen ~ alter0 + bildung_rec + geschl_rec, data = allb_sub_scale)


#Modelle anzeigen
screenreg(list(modell_a_beta ,
            modell_b_beta,
            modell_c_beta,
            modell_ab_beta,
            modell_abc_beta))


