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
        mutate(labels, Activity = labels$V1) %>%
        mutate(subjects, Subject = subjects$V1) 
    
}

## get the test data set
getTestDataset <- function () {
    ds <- read.table(paste(testFolder,"X_test.txt", sep = "/"))
    labels <- read.table(paste(testFolder, "y_test.txt", sep = "/"))
    subjects <- read.table(paste(testFolder, "subject_test.txt", sep = "/"))
    
    ds %>% 
        mutate(labels, Activity = labels$V1) %>%
        mutate(subjects, Subject = subjects$V1) 
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
    
    names(merged) <- append(as.vector(features$V2), c("Activity", "Subject"))

    select(merged, matches("((mean|std)\\(\\))|Activity|Subject"))
        
}

## add meaningful activity labels
getActivityLabels <- function () {
    read.table(paste(mainFolder, "activity_labels.txt", sep = "/")) 
}

addActivityLabels <- function (merged) {

    merged %>%
        merge(getActivityLabels(), by.x = "Activity", by.y = "V1") %>%
            mutate(Activity = V2) %>%
                select(-V2)
}

## summarize the dataset
summarizeDataset <- function (merged) {
    
    merged %>%
        melt(id = c("Subject", "Activity"), variable.name = "Feature") %>%
        arrange(Subject, Activity) %>%
        ddply(.(Subject, Activity, Feature), summarize, Average = mean(value))
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