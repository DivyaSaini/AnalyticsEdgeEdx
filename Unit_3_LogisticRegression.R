# Categorical Variable - limited number of possible outcomes
# Binary Variable - only two possible outcomes

# 0 <= Logistic Response Function <= 1

# Logistic response function - P(y = 1) = 1/(1 + e^(-(Bo + B1X1 + B2X2 + .... + BkXk))

# Logit = log(Odds) = Bo + B1X1 + B2X2 + .... + BkXk

# caTools package - sample.split() to split data set into training and testing set in a balanced way

# nrow() - to count number of rows

# glm() - to build a logistic regression model using generalized linear model function with family=binomial argument
# AIC value - tells quality of the model

# predict() with argument type="response" gives the probablities

# Specificity increases as we increase the threshold
# Sensitivity decreases as we increase the threshold

# Specificity = True negatives / All negatives = TN / (TN + FP)
# Sensitivity = True postives  / All positives = TP / (TP + FN)

# ROCR package to make ROC (Receiver Operator Characteristic) curve
# prediction()
# performance()

# Overall Accuracy = (TN+TP)/N
# Overall Error Rate = (FP+FN)/N

# False Negative Error Rate = FN / (TP + FN) = 1 - Sensitivity
# False Positive Error Rate = FP / (TN + FP) = 1 - Specificity

# The AUC of a model has the following nice interpretation: 
# given a random patient from the dataset who actually received poor care, 
# and a random patient from the dataset who actually received good care, 
# the AUC is the perecentage of time that our model will classify which is which correctly.


# Compute the test set predictions in R by running the command:
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data=qualityTrain, family=binomial)
predictTest = predict(QualityLog, type="response", newdata=qualityTest)

# You can compute the test set AUC (Area Under Curve) by running the following two commands in R:
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)

# Unordered factor variables
# Factor variables are variables that take on a discrete set of values, 
# like the "Region" variable in the WHO dataset from the second lecture of Unit 1. 
# This is an unordered factor because there isn't any natural ordering between the levels. 
# An ordered factor has a natural ordering between the levels (an example would be the classifications "large," "medium," and "small").

# To convert unordered factors into factors
parole$state = as.factor(parole$state)

# Now output of summary(parole$state) = table(parole$state) rather than calculating mean, median etc

# If you set a random seed, split, set the seed again to the same value, and then split again,
# you will get the same split. However, if you set the seed and then split twice, you will get different splits. 
# If you set the seed to different values, you will get different splits.

# You can also verify this by running the specified code in R. 
# If you have training sets train1 and train2, the function sum(train1 != train2) 
# will count the number of values in those two data frames that are different.

# It would be time-consuming to type all the variables, 
# but R provides the shorthand notation "readingScore ~ ." to mean "predict readingScore 
# using all the other variables in the data frame." 
# The period is used to replace listing out all of the independent variables. 
# As an example, if your dependent variable is called "Y",
# your independent variables are called "X1", "X2", and "X3", 
# and your training data set is called "Train", instead of the regular notation:

LinReg = lm(Y ~ X1 + X2 + X3, data = Train)

# You would use the following command to build your model:

LinReg = lm(Y ~ ., data = Train)

# same is applicable for glm() to use all variables in the model

1) If we have a coefficient c for a variable, then that means the log odds (or Logit) are increased by c for a unit increase in the variable.

2) If we have a coefficient c for a variable, then that means the odds are multiplied by e^c for a unit increase in the variable.
-1.7006288

### Unit 3, Modeling the Expert


# Video 4

# Read in dataset
quality = read.csv("quality.csv")

# Look at structure
str(quality)

# Table outcome
table(quality$PoorCare)

# Baseline accuracy
98/131

# Install and load caTools package
install.packages("caTools")
library(caTools)

# Randomly split data
set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
split

# Create training and testing sets
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)

# Logistic Regression Model
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data=qualityTrain, family=binomial)
summary(QualityLog)

# Make predictions on training set
predictTrain = predict(QualityLog, type="response")

# Analyze predictions
summary(predictTrain)
tapply(predictTrain, qualityTrain$PoorCare, mean)



# Video 5

# Confusion matrix for threshold of 0.5
table(qualityTrain$PoorCare, predictTrain > 0.5)

# Sensitivity and specificity
10/25
70/74

# Confusion matrix for threshold of 0.7
table(qualityTrain$PoorCare, predictTrain > 0.7)

# Sensitivity and specificity
8/25
73/74

# Confusion matrix for threshold of 0.2
table(qualityTrain$PoorCare, predictTrain > 0.2)

# Sensitivity and specificity
16/25
54/74



# Video 6

# Install and load ROCR package
install.packages("ROCR")
library(ROCR)

# Prediction function
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

### Unit 3, The Framingham Heart Study

# Video 3

# Read in the dataset
framingham = read.csv("framingham.csv")

# Look at structure
str(framingham)

# Load the library caTools
library(caTools)

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(framingham$TenYearCHD, SplitRatio = 0.65)

# Split up the data using subset
train = subset(framingham, split==TRUE)
test = subset(framingham, split==FALSE)

# Logistic Regression Model
framinghamLog = glm(TenYearCHD ~ ., data = train, family=binomial)
summary(framinghamLog)

# Predictions on the test set
predictTest = predict(framinghamLog, type="response", newdata=test)

# Confusion matrix with threshold of 0.5
table(test$TenYearCHD, predictTest > 0.5)

# Accuracy
(1069+11)/(1069+6+187+11)

# Baseline accuracy
(1069+6)/(1069+6+187+11) 

# Test set AUC 
library(ROCR)
ROCRpred = prediction(predictTest, test$TenYearCHD)
as.numeric(performance(ROCRpred, "auc")@y.values)
