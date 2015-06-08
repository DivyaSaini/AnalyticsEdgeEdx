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

## STOCK DYNAMICS

# 1.1
> setwd("~/EdxWD/data")
> IBM = read.csv("IBMStock.csv")
> GE = read.csv("GEStock.csv")
> CocaCola = read.csv("CocaColaStock.csv")
> ProcterGamble = read.csv("ProcterGambleStock.csv")
> Boeing = read.csv("BoeingStock.csv")
> str(IBM) # 480 obs. of  2 variables

# 1.2 , 1.3
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
