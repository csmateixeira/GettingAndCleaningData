zipedFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipedFileName <- "Dataset.zip"
method <- "curl"

downloadAndUnzipSamsumgData <- function(){
    
    if(!file.exists(zipedFileName)) {
        download.file(zipedFileUrl, destfile = zipedFileName, method = method) 
        unzip(zipedFileName)
    }
}