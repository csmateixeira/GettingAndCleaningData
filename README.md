README
======================

### How to use the script

1. Download the data and unzip it on your local working directory. the folder "UCI HAR Dataset" should be directly under the working directory.
    * You can also use the provided function - `downloadAndUnzipSamsumgData` - that will do this for you (only if the target directory does not exist already).
2. To obtain the tidy dataset just run the main() function and assign its output to the variable you want
    * _for example:_ `tidyDataset <- main()`
3. To print the tidy dataset into a text file run the `writeDataset` function and give it the tidy data frame as an argument. It will produce a file called tidyDataset.txt.
    * _for example:_ `writeDataset(tidyDataset)`

### Functions in the file
#### Main functions

```
downloadAndUnzipSamsumgData
```
This function downloads the zipped data file and unzips it to the working directory.

```
getTrainingDataset
```
This function reads the training dataset into a table. It then adds the training Activity and Subject information to the dataset.

```
getTestDataset
```
This function reads the test dataset into a table. It then adds the test Activity and Subject information to the dataset.

```
mergeDatasets
```
This function merges the training and test datasets into one big dataset.

```
getOnlyMeanAndStdColumns
```
This function adds the Features information to the merged datasets and selects only the columns that are related to the means and standard deviation as well as Activity and Subject information.

```
addActivityLabels
```
This function adds the proper meaningful label for each activity.

```
summarizeDataset
```
This function melts the dataset with Subject and Activity as IDs and Features as variables and values. It then summarizes it and calculates the Averages for each Feature (or variable).

```
writeDataset
```
This function writes the tidy dataset to a text file for submission.

```
main
```
The main function combines the transformations of all the functions with the exception of writeDataset. It produces the final tidy dataSet.

####Auxiliary functions
```
getFeatures
```
This function loads the features into a table.

```
getActivityLabels
```
This function loads the activity labels into a table.