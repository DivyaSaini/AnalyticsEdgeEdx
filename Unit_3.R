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

# Specificity = True negatives / All negatives
# Sensitivity = True postives  / All positives

# ROCR package to make ROC curve
# prediction()
# performance()
