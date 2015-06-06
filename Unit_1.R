# Direct calculations
8*6 # 48
2^4 # 16
# Mathematical functions
sqrt(2) # 1.414214
abs(-65) # 65
?sqrt # Help pages is opened for sqrt function
# Saving values to a variable
SquareRoot2 = sqrt(2) # R is case-sensitive
SquareRoot2 # 1.414214
HoursYear <- 365 * 24 # Another of assigning variables
HoursYear # 8760
# To list al the variables created in current R session
ls() # "HoursYear" "SquareRoot2"

## Vectors and Data Frames
# To create vectors in R
c(2,3,5,8,13) # [1] 2 3 5 8 13
Country = c("Brazil", "China", "India", "Switzerland", "USA")
LifeExpectancy = c(74,76,65,83,79)
Country # [1] "Brazil"      "China"       "India"       "Switzerland" "USA"   
LifeExpectancy # [1] 74 76 65 83 79

# Never combine characters and numbers in a vector. 
# R allows only one data type in a vector. 
# All the numbers will be changed to character.

# To access elements of a vector
Country[1] # [1] "Brazil"
LifeExpectancy[3] # [1] 65

# To create sequence of numbers use seq() function
seq(0,100,2) # creates seq of 0 to 100 with increment of 2
 [1]   0   2   4   6   8  10  12  14  16  18  20  22  24  26  28  30  32  34  36  38  40  42  44  46
[25]  48  50  52  54  56  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  94
[49]  96  98 100

# To create data frame
CountryData = data.frame(Country,LifeExpectancy)
CountryData
      Country LifeExpectancy
1      Brazil             74
2       China             76
3       India             65
4 Switzerland             83
5         USA             79

# To add another variable in the existing data frame use $ sign
CountryData$Population = c(199000,1390000,1240000,7997,318000)
CountryData # R combines the vector in the order they're typed
      Country LifeExpectancy Population
1      Brazil             74     199000
2       China             76    1390000
3       India             65    1240000
4 Switzerland             83       7997
5         USA             79     318000

# Rbind combines data frame by stackin the rows
