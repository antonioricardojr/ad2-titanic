#Setando diretorios e carregando csvs.
setwd('~/Dropbox/ad2/ad2-titanic')
train <- read.csv("train.csv")

# carregando pacotes decision tree plotting
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Recriando o modelo dos sobreviventes baseado no genero. Primeira impressão de árvores de decisão.
fit <- rpart(Survived ~ Sex, data=train, method="class")
fancyRpartPlot(fit)

# Contruindo uma árvore mais profunda e complexa. Agora consideramos mais variáveis como sexo, idade, etc.
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")
# Plot it with base-R
plot(fit)
text(fit)
# Plot da árvore que melhor evidencia os resultados.
fancyRpartPlot(fit)

# Predição para submeter ao Kaggle.
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

