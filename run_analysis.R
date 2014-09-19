## load libraries
library(plyr)
library(dplyr)
library(reshape2)

## variables for download
zipedFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipedFileName <- "Dataset.zip"
method <- "curl"

## variables for dataset loading
mainFolder <- "UCI HAR Dataset"
testFolder <- paste(mainFolder, "test", sep = "/")
trainFolder <- paste(mainFolder, "train", sep = "/")

## download and unzip function
downloadAndUnzipSamsumgData <- function(){
    
    if(!file.exists(zipedFileName)) {
        download.file(zipedFileUrl, destfile = zipedFileName, method = method)         
    }
    
    if(!file.exists(mainFolder)) {
        unzip(zipedFileName)
    }
}

## get the training data set and add Activity and Subject information
getTrainingDataset <- function () {
    ds <- read.table(paste(trainFolder,"X_train.txt", sep = "/"))
    labels <- read.table(paste(trainFolder, "y_train.txt", sep = "/"))
    subjects <- read.table(paste(trainFolder, "subject_train.txt", sep = "/"))
    
    ds %>% 
        transform(activity = labels$V1) %>%
        transform(Subject = subjects$V1) 
    
}

## get the test data set
getTestDataset <- function () {
    ds <- read.table(paste(testFolder,"X_test.txt", sep = "/"))
    labels <- read.table(paste(testFolder, "y_test.txt", sep = "/"))
    subjects <- read.table(paste(testFolder, "subject_test.txt", sep = "/"))
    
    ds %>% 
        transform(activity = labels$V1) %>%
        transform(Subject = subjects$V1) 
}

## merge test and train data
mergeDatasets <- function () {
    testDS <- getTestDataset()
    trainDS <- getTrainingDataset()
    
    rbind(trainDS, testDS)
}

## extract only mean and std columns and name them according to features txt
getFeatures <- function () {
    read.table(paste(mainFolder, "features.txt", sep = "/"))
}

getOnlyMeanAndStdColumns <- function (merged) {
    features <- getFeatures()
    
    names(merged) <- append(as.vector(features$V2), c("activity", "subject"))
    
    merged <- select(merged, matches("((mean|std)\\(\\))|activity|subject"))
    
    names(merged) <- changeLabels(names(merged))
    
    merged
        
}

changeLabels <- function (names) {
    names %>%
        gsub(pattern = "-|\\(|\\)", replacement = "") %>%
        gsub(pattern = "^t", replacement = "time") %>%
        gsub(pattern = "^f", replacement = "frequency") %>%
        gsub(pattern = "BodyBody", replacement = "body") %>%
        gsub(pattern = "Acc", replacement = "accelerator") %>%
        gsub(pattern = "Gyro", replacement = "gyroscope") %>%
        gsub(pattern = "Mag", replacement = "magnitude") %>%
        tolower
}

## add meaningful activity labels
getActivityLabels <- function () {
    read.table(paste(mainFolder, "activity_labels.txt", sep = "/")) 
}

addActivityLabels <- function (merged) {

    merged %>%
        merge(getActivityLabels(), by.x = "activity", by.y = "V1") %>%
            mutate(activity = V2) %>%
                select(-V2)
}

## summarize the dataset
summarizeDataset <- function (merged) {
    
    merged %>%
        melt(id = c("subject", "activity"), variable.name = "feature") %>%
        arrange(subject, activity) %>%
        ddply(.(subject, activity, feature), summarize, average = mean(value))
}

## write dataset
writeDataset <- function (tidy) {
    write.table(tidy, "tidyDataset.txt", row.name = FALSE)
}

## main function
main <- function () {
    downloadAndUnzipSamsumgData()
    
    mergeDatasets() %>%
        getOnlyMeanAndStdColumns %>%
        addActivityLabels %>%
        summarizeDataset
        
}