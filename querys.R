install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")
library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)


# Una vez que se tengan las librerias necesarias se procede a la lectura 
# (podr? ser que necesites otras, si te las solicita instalalas y cargalas). 
# De la base de datos de Shiny, la cual es un demo y nos permite interactuar con 
# este tipo de objetos. El comando dbConnect es el indicado para realizar la 
# lectura, los dem?s par?metros son los que nos dan acceso a la BDD.

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
head(DataDB)
lenguage.esp <-  DataDB %>% filter(Language == "Spanish" )
lenguage.esp
esp.df <- as.data.frame(lenguage.esp)


esp.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
# Nos desconectamos de la base de datos
dbDisconnect(MyDataBase)

