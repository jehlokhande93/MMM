
#USD as price currency
data = read.csv("usd_data.csv",header=TRUE)

boxplot(Real.Demanded.units~as.factor(Center),data=data,xlab="Countries",ylab="Real Demanded Units",main="Boxplot upon Countries")

boxplot(Real.Demanded.units~as.factor(CUC.Code),data=data,xlab="Product Type",ylab="Real Demanded Units",main="Boxplot upon Products")

colnames(data)
dataset = data

#model without seperation between products type and countries
#Using USD as price unit

model_1 = lm(Real.Demanded.units ~ Center+as.factor(CUC.Code)
               +as.factor(Offer.type)+Number.of.real.orders+Regular.Price.USD
               +Sale.Price.USD+as.factor(Discover)+Exposition.Percentaje+as.factor(Set.Flag)+as.factor(Model.Photo)
               +as.factor(Main.Offer)+Page.number+Discount, data = dataset)

#model_1 = lm(Real.Demanded.units ~ Center+Brand+Year+Campaign+CUC.Code+Offer.type+Cosmetic.grouping.OT+
#             Number.of.real.orders+Regular.Price.USD+
#             Sale.Price.USD+Discover+Exposition.Percentaje+Set.Flag+Model.Photo+
#             Main.Offer+Page.number+Discount)

summary(model_1)

#5 not defined because of singularities

BIC(model_1)
AIC(model_1)

res = model_1$resid
fitted = model_1$fitted
plot(fitted,res,xlab="Fitted Values",ylab="Residuals",main="Residual VS Fitted")
abline(0,0,col="red")

hist(res,xlab="Residuals",main="",col="Orange")

qqnorm(res,main="Q-Q Normal Plot",xlab="Normal Quantiles",ylab="Residuals")
qqline(res,col="red")

library(MASS)
boxcox(model_1)

bc_model_1 = boxcox(model_1)
which.max(bc_model_1$y)
bc_model_1$x[51]

CO03 = read.csv("CO03.csv",header=TRUE)
colnames(CO03)

#proportion_test = 0.2
#samplesize <- round(length(CO03[,1])*proportion_test)
#indexsample <- sample(1:length(CO03[,1]), size = samplesize, replace=FALSE)
#CO_test <- CO03[indexsample,]
#CO_train <- CO03[-indexsample,]

model_CO = lm(log(Real.Demanded.units) ~ as.factor(CUC.Code)
               +as.factor(Offer.type)+scale(Number.of.real.orders)+Regular.Price.Local.Currency
               +Sale.Price.Local.Currency+as.factor(Discover)+Exposition.Percentaje+as.factor(Set.Flag)+as.factor(Model.Photo)
               +as.factor(Main.Offer)+Page.number+Discount, data = CO03)

summary(model_CO)

AIC(model_CO)
BIC(model_CO)

boxplot(log(Real.Demanded.units)~as.factor(CUC.Code),data=CO03,xlab="Product Type",ylab="Real Demanded Units",main="Boxplot upon Products of Columbia")

res = model_CO$resid
fitted = model_CO$fitted
plot(fitted,res,xlab="Fitted Values",ylab="Residuals",main="Residual VS Fitted")
abline(0,0,col="red")
hist(res,xlab="Residuals",main="",col="Orange")
qqnorm(res,main="Q-Q Normal Plot",xlab="Normal Quantiles",ylab="Residuals")
qqline(res,col="red")

MX03 = read.csv("MX03.csv",header=TRUE)
colnames(MX03)
MX03set = MX03

boxplot(log(Real.Demanded.units)~as.factor(CUC.Code),data=MX03,xlab="Product Type",ylab="Real Demanded Units",main="Boxplot upon Products of Mexico")

model_MX03 = lm(log(Real.Demanded.units) ~ as.factor(CUC.Code)
               +as.factor(Offer.type)+Number.of.real.orders+Regular.Price.Local.Currency
               +Sale.Price.Local.Currency+as.factor(Discover)+Exposition.Percentaje+as.factor(Set.Flag)+as.factor(Model.Photo)
               +as.factor(Main.Offer)+Page.number+Discount, data = MX03set)

summary(model_MX03)

PE03 = read.csv("PE03.csv",header=TRUE)
colnames(PE03)
PE03set = PE03

boxplot(log(Real.Demanded.units)~as.factor(CUC.Code),data=PE03,xlab="Product Type",ylab="Real Demanded Units",main="Boxplot upon Products of Peru")

model_PE03 = lm(Real.Demanded.units ~ as.factor(CUC.Code)
               +as.factor(Offer.type)+Number.of.real.orders+Regular.Price.Local.Currency
               +Sale.Price.Local.Currency+as.factor(Discover)+Exposition.Percentaje+as.factor(Set.Flag)+as.factor(Model.Photo)
               +as.factor(Main.Offer)+Page.number+Discount, data = PE03set)

summary(model_PE03)

#200044715
CO200044715 = read.csv("CO03_200044715.csv",header=TRUE)
colnames(CO200044715)
CO_200044715 = CO200044715

model_CO_200044715 = lm(Real.Demanded.units ~ as.factor(Year)+as.factor(Campaign)
               +as.factor(Offer.type)+Cosmetic.grouping.OT+Number.of.real.orders+Regular.Price.Local.Currency
               +as.factor(Discover)+Exposition.Percentaje+as.factor(Model.Photo)+Sale.Price.Local.Currency
               +as.factor(Main.Offer)+Page.number+Discount, data = CO_200044715)

#Brand, Set flag, 

summary(model_CO_200044715)

P_200037781 = read.csv("P_200037781.csv",header=TRUE)
colnames(P_200037781)

P200037781 = P_200037781

model_200037781 =  lm(Real.Demanded.units ~ as.factor(Center)
                   +as.factor(Offer.type)+Number.of.real.orders+Regular.Price.USD
                   +Sale.Price.USD+as.factor(Discover)+Exposition.Percentaje+as.factor(Set.Flag)+as.factor(Model.Photo)
                   +as.factor(Main.Offer)+Page.number+Discount, data = P200037781)
summary(model_200037781)

library('glmnet')
library('MASS')
library('corrplot')
library('car')

original_data = read.csv('CO03.csv', header = TRUE)

original_data

original_data$Real.Demanded.units=log(original_data$Real.Demanded.units)
original_data$CUC.Code=as.factor(original_data$CUC.Code)
original_data$Offer.type=as.factor(original_data$Offer.type)
original_data$Discover=as.factor(original_data$Discover)
original_data$Set.Flag=as.factor(original_data$Set.Flag)
original_data$Model.Photo=as.factor(original_data$Model.Photo)
original_data$Main.Offer=as.factor(original_data$Main.Offer)

original_data

set.seed(411)
proportion_test = 0.20
samplesize <- round(length(original_data[,1])*proportion_test)
indexsample <- sample(1:length(original_data[,1]), size = samplesize, replace=FALSE)
testing <- original_data[indexsample,]
original_data <- original_data[-indexsample,]

original_data = original_data[,-1]

model1 = lm(Real.Demanded.units~.,data=original_data)
summary(model1)

cook = cooks.distance(model1)

#Plotting the residuals
plot(model1$fitted.values, model1$residuals, xlab="Fitted Values",ylab="Residuals")
abline(0,0,col="red")
hist(model1$residuals, xlab="Residuals", main = "",nclass=10,col="orange")
plot(cook,type="h",lwd=3,col="red", ylab = "Cook's Distance")
