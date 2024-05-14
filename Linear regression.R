##Linear regression
#Simple linear regression – only one input variable
#Multiple linear regression – multiple input variables
#You can use a linear regression model to learn which features are important by examining
#coefficients. If a coefficient is close to zero, the corresponding feature is considered to be less 
#important than if the coefficient was a large positive or negative value. 

#Linear assumption — model assumes that the relationship between variables is linear
#No noise — model assumes that the input and output variables are not noisy — so remove outliers if possible
#No collinearity — model will overfit when you have highly correlated input variables
#Normal distribution — the model will make more reliable predictions if your input and output variables are normally distributed. If that’s not the case, try using some transforms on your variables to make them more normal-looking
#Rescaled inputs — use scalers or normalizers to make more reliable predictions

library(corrplot)

# Generate synthetic data with a clear linear relationship
x <- seq(from = 1, to = 300)
y <- rnorm(n = 300, mean = x + 2, sd = 25)

# Convert to dataframe
simple_lr_data <- data.frame(x, y)

library(tidyverse)
# Visualize as scatter plot
ggplot(data = simple_lr_data, aes(x = x, y = y)) +
  geom_point(size = 3, color = "#0099f9") +
  theme_classic() +
  labs(
    title = "Dataset for simple linear regression",
    subtitle = "A clear linear relationship is visible"
  )


############
data("diamonds")
head(diamonds)
Data <- as.data.frame(diamonds)
head(Data)
str(Data)
summary(Data)
cor.test(Data$carat, Data$price)
plot(Data$carat, Data$price)

ggplot(data = Data, aes(x = cut, y = price)) +
  geom_bar(stat = "identity", aes(color = cut)) +
  theme_classic() +
  labs(
    title = "Dataset for simple linear regression",
    subtitle = "A clear linear relationship is visible"
  )

ggplot(data = Data, aes(x = color, y = price)) +
  geom_bar(stat = "identity", aes(color = color)) +
  theme_classic() +
  labs(
    title = "Dataset for simple linear regression",
    subtitle = "A clear linear relationship is visible"
  )

ggplot(data = Data, aes(x = clarity, y = price)) +
  geom_bar(stat = "identity", aes(color = clarity)) +
  theme_classic() +
  labs(
    title = "Dataset for simple linear regression",
    subtitle = "A clear linear relationship is visible"
  )
Corr1 <- cor(Data[, -(2:4)])
print(Corr1)
corrplot(Corr1, method = "color")
# Create a bubble plot using corrplot
corrplot(Corr1, method = "circle", type = "upper", order = "hclust", addCoef.col = "black", number.cex = 0.7)



###
set.seed(123)
sampleSplit <- sample.split(Y=Data$price, SplitRatio=0.7)
trainSet <- subset(x=Data, sampleSplit==TRUE)
testSet <- subset(x=Data, sampleSplit==FALSE)
Model1 <- lm(formula=price ~ ., data=trainSet)
summary(Model1)

modelResiduals <- as.data.frame(residuals(Model1))

ggplot(modelResiduals, aes(residuals(Model1))) +
  geom_histogram(fill="deepskyblue", color="black")


preds <- predict(Model1, testSet)
head(preds)
modelEval <- cbind(testSet$price, preds)
colnames(modelEval) <- c("Actual", "Predicted")
modelEval <- as.data.frame(modelEval)
head(modelEval)
