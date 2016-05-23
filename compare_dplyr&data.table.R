## package dplyr data.table
library(dplyr)
library(data.table)

## others
library(jsonlite)
library(compare)
library(tidyr)
library(ggplot2)
library(lubridate)

## data
spending = fromJSON("https://data.medicare.gov/api/views/nrth-mfg3/rows.json?accessType=DOWNLOAD")
names(spending)

meta <- spending$meta
hospital_spending = data.frame(spending$data)
colnames(hospital_spending) <- make.names(meta$view$columns$name)
hospital_spending = select(hospital_spending, -c(sid:meta))
glimpse(hospital_spending)

cols <- 6:11
hospital_spending[, cols] = lapply(hospital_spending[, cols], as.character)
hospital_spending[, cols] = lapply(hospital_spending[, cols], as.numeric)

cols <- 12:13
hospital_spending[, cols] = lapply(hospital_spending[, cols], ymd_hms)

## select one columns
hospital_spending_DT <- data.table(hospital_spending)
class(hospital_spending_DT)

from_dplyr <- select(hospital_spending, Hospital.Name)
from_data_table <- hospital_spending_DT[, .(Hospital.Name)]
compare(from_dplyr, from_data_table, allowAll = TRUE)

## delete one columns
from_dplyr <- select(hospital_spending, -Hospital.Name)
from_data_table <- hospital_spending_DT[, !c("Hospital.Name"), with = FALSE]
compare(from_dplyr, from_data_table, allowAll = TRUE)

DT <- copy(hospital_spending_DT)
DT = DT[, Hospital.Name:=NULL]
"Hospital.Name" %in% names(DT)

## delete multiple colums
DT=copy(hospital_spending_DT)
DT=DT[,c("Hospital.Name","State","Measure.Start.Date","Measure.End.Date"):=NULL]
c("Hospital.Name","State","Measure.Start.Date","Measure.End.Date") %in% names(DT)

from_dplyr = select(hospital_spending, Hospital.Name,State,Measure.Start.Date,Measure.End.Date)
from_data_table = hospital_spending_DT[,.(Hospital.Name,State,Measure.Start.Date,Measure.End.Date)]
compare(from_dplyr, from_data_table, allowAll = TRUE)

hospital_spending %>% group_by(Hospital.Name) %>% summarize(mean = mean())
