## AN ANALYTICAL DETECTIVE
# 2.5
mvtArrest = subset(mvt, mvt$Arrest== "TRUE")
str(mvtArrest) # 15536 obs. of  11 variables
str(mvt) # 191641 obs. of  11 variables
DateConvertArrest = as.Date(strptime(mvtArrest$Date, "%m/%d/%y %H:%M"))
summary(DateConvertArrest)
> mvtArrest$Month = months(DateConvertArrest)
> mvtArrest$Date = DateConvertArrest
> table(mvtArrest$Month) # JAN - 1435
# or
table(mvt$Arrest,mvt$Month)

# 3.1 
> DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
> mvt$Date = DateConvert
> hist(mvt$Date, breaks=100)

# 3.2
> mvt = read.csv("mvtWeek1.csv")
> DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
> mvt$Date = DateConvert
> boxplot(mvt$Date ~ mvt$Arrest)

# 3.3 
table(mvt$Year, mvt$Arrest) # 2152/(2152+18517) = 0.1041173
# Similarly for 3.4 and 3.5

# 4.1
sort(table(mvt$LocationDescription)) # pick the last five

# 4.2
> Top5 = subset(mvt,LocationDescription == "STREET" | LocationDescription == "GAS STATION" | LocationDescription == "DRIVEWAY - RESIDENTIAL" | LocationDescription == "ALLEY" | LocationDescription == "PARKING LOT/GARAGE(NON.RESID.)")
> str(Top5) # 177510 obs. of  11 variables:

# 4.3
> Top5$LocationDescription = factor(Top5$LocationDescription)
> str(Top5)
> table(Top5$LocationDescription, Top5$Arrest) # STREET - 11595

# 4.4, 4.5
> DateConvertTop5 = as.Date(strptime(Top5$Date, "%m/%d/%y %H:%M"))
> Top5$Weekday = weekdays(DateConvertTop5)
> Top5$Date = DateConvertTop5
> table(Top5$Weekday, Top5$LocationDescription)

## STOCK DYNAMICS

# 1.1
 setwd("~/EdxWD/data")
 IBM = read.csv("IBMStock.csv")
 GE = read.csv("GEStock.csv")
 CocaCola = read.csv("CocaColaStock.csv")
 ProcterGamble = read.csv("ProcterGambleStock.csv")
 Boeing = read.csv("BoeingStock.csv")
 str(IBM) # 480 obs. of  2 variables

# 1.2 , 1.3, 1.4, 1.5, 1.6, 1.7
IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")
> summary(IBM)
> summary(GE)
> summary(CocaCola)
> summary(ProcterGamble)
> summary(Boeing)

# 1.8
sd(ProcterGamble$StockPrice) # 18.19414

# 2.1 
plot(CocaCola$Date, CocaCola$StockPrice,type = "l")

# 2.2, 2.3
plot(CocaCola$Date, CocaCola$StockPrice,type = "l", col="RED")
lines(ProcterGamble$Date, ProcterGamble$StockPrice)
abline(v=as.Date(c("2000-03-01")), lwd=2) # P&C

# 3.1, 3.2, 3.4
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(ProcterGamble$Date, ProcterGamble$StockPrice, col="purple")
lines(GE$Date, GE$StockPrice, col="green")
lines(IBM$Date, IBM$StockPrice, col="yellow")
lines(Boeing$Date, Boeing$StockPrice, col="black")

# 3.3
abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-11-01")), lwd=2)

# 4.1
tapply(IBM$StockPrice, months(IBM$Date), mean)
mean(IBM$StockPrice)

# 4.2
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)
> mean(CocaCola$StockPrice)
tapply(GE$StockPrice, months(GE$Date), mean)
mean(GE$StockPrice)

# 4.3
tapply(Boeing$StockPrice, months(Boeing$Date), mean)
tapply(ProcterGamble$StockPrice, months(ProcterGamble$Date), mean)

## DEMOGRAPHICS AND EMPLOYMENT IN THE UNITED STATES

# 1.1
CPS = read.csv("CPSData.csv")
str(CPS) # 131302
summary(CPS) 

# 1.2
table(CPS$Industry) 

# 1.3
sort(table(CPS$State))

# 1.4
table(CPS$Citizenship) # (116639+7073)/131302 = 0.942194

# 1.5
table(CPS$Race, CPS$Hispanic)

# 2.1
summary(CPS) # Verify manually from here
