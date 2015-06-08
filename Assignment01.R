# 2.5
mvtArrest = subset(mvt, mvt$Arrest== "TRUE")
str(mvtArrest) # 15536 obs. of  11 variables
str(mvt) # 191641 obs. of  11 variables
DateConvertArrest = as.Date(strptime(mvtArrest$Date, "%m/%d/%y %H:%M"))
summary(DateConvertArrest)
> mvtArrest$Month = months(DateConvertArrest)
> mvtArrest$Date = DateConvertArrest
> table(mvtArrest$Month)
