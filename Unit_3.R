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

# ROCR package to make ROC curve
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

# You can compute the test set AUC by running the following two commands in R:
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)
