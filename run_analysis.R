## load libraries
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
        unzip(zipedFileName)
    }
}

## get the training data set
getTrainingDataset <- function () {
    ds <- read.table(paste(trainFolder,"X_train.txt", sep = "/"))
    labels <- read.table(paste(trainFolder, "y_train.txt", sep = "/"))
    subjects <- read.table(paste(trainFolder, "subject_train.txt", sep = "/"))
    
    ds %>% 
        mutate(labels, Label = labels$V1) %>%
        mutate(subjects, Subject = subjects$V1) 
    
}

## get the test data set
getTestDataset <- function () {
    ds <- read.table(paste(testFolder,"X_test.txt", sep = "/"))
    labels <- read.table(paste(testFolder, "y_test.txt", sep = "/"))
    subjects <- read.table(paste(testFolder, "subject_test.txt", sep = "/"))
    
    ds %>% 
        mutate(labels, Label = labels$V1) %>%
        mutate(subjects, Subject = subjects$V1) 
}

## merge test and train data
mergeDatasets <- function () {
    testDS <- getTestDataset()
    trainDS <- getTrainingDataset()
    
    rbind(trainDS, testDS)
}

## extract only mean and std columns and name them according to features txt
getMeanAndStdFeatures <- function () {
    features <- read.table(paste(mainFolder, "features.txt", sep = "/"))    
    
    features[with(features, grepl("(mean|std)\\(\\)", features$V2, perl = TRUE)), ]
}

getMeanAndStdColumns <- function (merged) {
    features <- getMeanAndStdFeatures()  
    
    valid <- features$V1
    names <- features$V2
    
    merged <- merged[,append(valid, c(ncol(merged), ncol(merged) - 1))]
    names(merged) <- append(as.vector(names), c("Subject", "Activity"))
    
    merged
}

## get activity labels
getActivityLabels <- function () {
    read.table(paste(mainFolder, "activity_labels.txt", sep = "/")) 
}

## add meaningful activity labels
addActivityLabels <- function (merged) {
    activities <- getActivityLabels()
    
    merged <- 
        merged %>%
            merge(activities, by.x = "Activity", by.y = "V1") %>%
                mutate(Activity = V2)
    
    merged[1:(ncol(merged)-1)]
}

## melt the dataset
summarizeDataset <- function (merged) {
    
    merged %>%
        melt(id = c("Subject", "Activity")) %>%
        arrange(Subject, Activity) %>%
        ddply(.(Subject, Activity, variable), summarize, mean = mean(value), std = sd(value))
}

## main function
main <- function () {
    downloadAndUnzipSamsumgData()
    
    mergeDatasets() %>%
        getMeanAndStdColumns %>%
        addActivityLabels %>%
        summarizeDataset
        
}