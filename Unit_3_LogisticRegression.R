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
