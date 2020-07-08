## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## --------------------------------------------------------------------------
# getwd()


## --------------------------------------------------------------------------
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'HADataset.zip')


## --------------------------------------------------------------------------
library(dplyr)
TrainData <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/train/X_train.txt', sep = '')))

TestData <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/test/X_test.txt', sep = '')))


## --------------------------------------------------------------------------
ActivityLabels <- read.table(paste(getwd(), '/test/UCI HAR Dataset/activity_labels.txt', sep = ''))
# head(ActivityLabels)

##Training Data
TrainDataLabels <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/train/y_train.txt', sep = '')))
# head(TrainDataLabels)

ActivityLabelsTrain <- data.frame()
for (i in 1:nrow(TrainDataLabels)) {
    ActivityLabelsTrain[i,1] <- ActivityLabels[as.numeric(TrainDataLabels[i,1]),2]
}

TrainData <- cbind(ActivityLabelsTrain, TrainData)
# head(TrainData)

##TestData
TestDataLabels <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/test/y_test.txt', sep = '')))
# head(TestDataLabels)

ActivityLabelsTest <- data.frame()
for (i in 1:nrow(TestDataLabels)) {
    ActivityLabelsTest[i,1] <- ActivityLabels[as.numeric(TestDataLabels[i,1]),2]
}
TestData <- cbind(ActivityLabelsTest, TestData)
# head(TestData)



## --------------------------------------------------------------------------
Combined <- bind_rows(TrainData, TestData)
# dim(Combined)
# names(Combined)
# head(Combined)


## --------------------------------------------------------------------------
VariableNames <- read.table(paste(getwd(), '/test/UCI HAR Dataset/features.txt', sep = ''))
VariableNames <- VariableNames[2]
colnames(VariableNames) <- 'variable ID'
# head(VariableNames)
colnames(Combined) <- c('activity', VariableNames[,1])
# head(Combined)
# names(Combined)


## --------------------------------------------------------------------------
meanSd <- select(Combined, matches('mean()|std()|activity'))
meanSd


## --------------------------------------------------------------------------
##Training Data
Subject_Train <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/train/subject_train.txt', sep = '')))
# unique(Subject_Train)

Subject_Test <- tibble(read.table(paste(getwd(), '/test/UCI HAR Dataset/test/subject_test.txt', sep = '')))
# unique(Subject_Test)

Combined_subjectID <- bind_rows(Subject_Train, Subject_Test)
# dim(Combined_subjectID)


## --------------------------------------------------------------------------
Combined <- cbind(Combined_subjectID, Combined)
names(Combined)[1] <- 'subjectID'
# dim(Combined)
# head(Combined)



## --------------------------------------------------------------------------
Combined <- select(Combined, matches('mean....$|std()|activity|subjectID'))
# View(Combined)

TidyTable <- Combined %>%
    group_by(subjectID, activity) %>%
    summarise_all(mean)
# TidyTable <- subset(TidyTable, select = -c(85,86))
View(TidyTable)
# dim(TidyTable)



## --------------------------------------------------------------------------
write.table(TidyTable, file = 'TidyTable.txt')


