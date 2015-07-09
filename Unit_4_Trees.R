# Unit 4 - "Judge, Jury, and Classifier" Lecture


# Classification and Regression Trees (CART)
# A CART tree is a series of decision rules which can easily be explained.
# A yes response is always to the left and a no response is always to the right.
# There are different ways to control how many splits are generated.
# One way is by setting a lower bound for the number of data points in each subset.
# In R, this is called the minbucket parameter, for the minimum number of observations in each bucket or subset.
# The smaller minbucket is, the more splits will be generated.
# But if it's too small, overfitting will occur.
# This means that CART will fit the training set almost perfectly.
# But this is bad because then the model will probably not perform well on test set data or new data.
# On the other hand, if the minbucket parameter is too large, the model will be too simple and the accuracy will be poor.

# VIDEO 4

# Read in the data
stevens = read.csv("stevens.csv")
str(stevens)

# Split the data
library(caTools)
set.seed(3000)
spl = sample.split(stevens$Reverse, SplitRatio = 0.7)
Train = subset(stevens, spl==TRUE)
Test = subset(stevens, spl==FALSE)

# Install rpart library
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

# CART model
StevensTree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method="class", minbucket=25)
# method = "class" is used since we are building classification tree and not regression tree
# minbucket = 25 is used so that it doesn't overfit to our training set
prp(StevensTree) # plots the tree

# Make predictions
PredictCART = predict(StevensTree, newdata = Test, type = "class") # type="class" coz we want the majority class predictions.
table(Test$Reverse, PredictCART)
PredictCART
  0    1
0 41   36
1 22   71
(41+71)/(41+36+22+71) # calculate accuracy - 0.6588

# If you were to build a logistic regression model, you would get an accuracy of 0.665
# and a baseline model that always predicts Reverse, the most common outcome, has an accuracy of 0.547.
# So our CART model significantly beats the baseline and is competitive with logistic regression.
# It's also much more interpretable than a logistic regression model would be.

# ROC curve
library(ROCR)

PredictROC = predict(StevensTree, newdata = Test)
PredictROC

pred = prediction(PredictROC[,2], Test$Reverse)
perf = performance(pred, "tpr", "fpr")
plot(perf)

# Compute the AUC of the CART model
as.numeric(performance(pred, "auc")@y.values)



# VIDEO 5 - Random Forests

# Install randomForest package
install.packages("randomForest")
library(randomForest)

# Build random forest model
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25 )

# Convert outcome to factor
Train$Reverse = as.factor(Train$Reverse)
Test$Reverse = as.factor(Test$Reverse)

# Try again
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25 )

# Make predictions
PredictForest = predict(StevensForest, newdata = Test)
table(Test$Reverse, PredictForest)
(40+74)/(40+37+19+74)



# VIDEO 6

# Install cross-validation packages
install.packages("caret")
library(caret)
install.packages("e1071")
library(e1071)

# Define cross-validation experiment
numFolds = trainControl( method = "cv", number = 10 )
cpGrid = expand.grid( .cp = seq(0.01,0.5,0.01)) 

# Perform the cross validation
train(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method = "rpart", trControl = numFolds, tuneGrid = cpGrid )

# Create a new CART model
StevensTreeCV = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method="class", cp = 0.18)

# Make predictions
PredictCV = predict(StevensTreeCV, newdata = Test, type = "class")
table(Test$Reverse, PredictCV)
(59+64)/(59+18+29+64)

### Unit 4 - "Keeping an Eye on Healthcare Costs" Lecture


# VIDEO 6

# Read in the data
Claims = read.csv("ClaimsData.csv")

str(Claims)

# Percentage of patients in each cost bucket
table(Claims$bucket2009)/nrow(Claims)

# Split the data
library(caTools)

set.seed(88)

spl = sample.split(Claims$bucket2009, SplitRatio = 0.6)

ClaimsTrain = subset(Claims, spl==TRUE)

ClaimsTest = subset(Claims, spl==FALSE)


# VIDEO 7

# Baseline method
table(ClaimsTest$bucket2009, ClaimsTest$bucket2008)

(110138 + 10721 + 2774 + 1539 + 104)/nrow(ClaimsTest)

# Penalty Matrix
PenaltyMatrix = matrix(c(0,1,2,3,4,2,0,1,2,3,4,2,0,1,2,6,4,2,0,1,8,6,4,2,0), byrow=TRUE, nrow=5)

PenaltyMatrix

# Penalty Error of Baseline Method
as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix

sum(as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix)/nrow(ClaimsTest)


# VIDEO 8

# Load necessary libraries
library(rpart)
library(rpart.plot)

# CART model
ClaimsTree = rpart(bucket2009 ~ age + alzheimers + arthritis + cancer + copd + depression + diabetes + heart.failure + ihd + kidney + osteoporosis + stroke + bucket2008 + reimbursement2008, data=ClaimsTrain, method="class", cp=0.00005)

prp(ClaimsTree)


# Make predictions
PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")

table(ClaimsTest$bucket2009, PredictTest)

(114141 + 16102 + 118 + 201 + 0)/nrow(ClaimsTest)

# Penalty Error
as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix

sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)

# New CART model with loss matrix
ClaimsTree = rpart(bucket2009 ~ age + alzheimers + arthritis + cancer + copd + depression + diabetes + heart.failure + ihd + kidney + osteoporosis + stroke + bucket2008 + reimbursement2008, data=ClaimsTrain, method="class", cp=0.00005, parms=list(loss=PenaltyMatrix))

# Redo predictions and penalty error
PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")

table(ClaimsTest$bucket2009, PredictTest)

(94310 + 18942 + 4692 + 636 + 2)/nrow(ClaimsTest)

sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)


