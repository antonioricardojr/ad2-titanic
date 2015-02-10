
# Set working directory
setwd("~/Dropbox/ad2/ad2-titanic")

# Import datafiles
train <- read.csv("~/Dropbox/ad2/ad2-titanic/train.csv")
View(train)
test <- read.csv("~/Dropbox/ad2/ad2-titanic/test.csv")
View(test)



#To see how many Passengers survived or not.
table(train$Survived)
#the proportion
prop.table(table(train$Survived))

#add a new column to test.
#test$Survived <- rep(0, 418)

# creates a new data frame with two columns: PassengerId and Survived
#submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
# write the data.frame into a .csv file.
#write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

######## Part 2 - The Gender Class Model ###############

summary(train$Sex)
prop.table(table(train$Sex, train$Survived)) 
#row wise proportion
prop.table(table(train$Sex, train$Survived),1)

test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

summary(train$Age)
train$Child <- 0
train$Child[train$Age < 18] <- 1


#the result of summing is the number of survivors
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)


# TrainFare2 Fare tabulated.
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

#
aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x) / length(x) })
