Code Book
======================

### Datasets and associated data

Both datasets - `x_train.txt` and `x_test.txt` - were imported as tables with `read.table()`. <br />
Activity data for both data sets - `y_train.txt` and `y_test.txt` - was imported as table with `read.table()`. <br />
Subject data for both data sets - `subject_train.txt` and `subject_test.txt` - was imported as table with `read.table()`.

Activity data was added to the dataset with `transform` as a new column called "activity".  <br />
Subject data was added to the dataset with `transform` as a new column called "subject".

Data sets were merged together with `rbind`.

Feature data was imported as a table using `read.table()`. <br />
Column "V2" of the features table was used as a vector to assign to the column names of the merged data set.<br />
Only features that contained the patterns "-mean()" or "-std()" were included in the tidy dataset.

Activity data was imported as a table using `read.table()`. <br />
The activities table was merged with the data set by the column "V1" in the data table and column "activity" in the dataset.<br />
The column "activity" in the dataset was assigned the respective values in the "V2" column of the activities data and the "V2" column that resulted from the merge was dropped. Only activity labels remained in the dataset.<br />

The dataset was melted: ID columns are "subject" and "activity" and variables are the "Features". The variable name is "feature" and the values are the different transformed feature labels.<br />
The data set was sorted by "subject" and then "activity".</br >
A `ddplyr` was applied to summarize the dataset by "subject", "activity" and "feature", the mean of the "values" was calculated and added to a new column called "average".

### Activity data

Activity Labels: 

<table>
    <tr>
        <td>1</td>
        <td>WALKING</td>       
    </tr>
    <tr>
        <td>2</td>
        <td>WALKING_UPSTAIRS</td>       
    </tr>
    <tr>
        <td>3</td>
        <td>WALKING_DOWNSTAIRS</td>       
    </tr>
    <tr>
        <td>4</td>
        <td>SITTING</td>       
    </tr>
    <tr>
        <td>5</td>
        <td>STANDING</td>       
    </tr>
    <tr>
        <td>6</td>
        <td>LAYING</td>       
    </tr>
</table>
    
### Subject data

Values 1 - 30 that identify the subject.

### Features

Feature labels were modified in the following pattern: 

    * "-" was removed
    * "()" was removed
    * starting "t" -> "time"
    * starting "f" -> "frequency"
    * "BodyBody" -> "body"
    * "Acc" -> "accelerator"
    * "Gyro" -> "gyroscope"
    * "Mag" -> "magnitude"
    * all names were converted to lowercase

Final feature Labels:

    timebodyacceleratormeanx
    timebodyacceleratormeany
    timebodyacceleratormeanz
    timebodyacceleratorstdx
    timebodyacceleratorstdy
    timebodyacceleratorstdz
    timegravityacceleratormeanx
    timegravityacceleratormeany
    timegravityacceleratormeanz
    timegravityacceleratorstdx
    timegravityacceleratorstdy
    timegravityacceleratorstdz
    timebodyacceleratorjerkmeanx
    timebodyacceleratorjerkmeany
    timebodyacceleratorjerkmeanz
    timebodyacceleratorjerkstdx
    timebodyacceleratorjerkstdy
    timebodyacceleratorjerkstdz
    timebodygyroscopemeanx
    timebodygyroscopemeany
    timebodygyroscopemeanz
    timebodygyroscopestdx
    timebodygyroscopestdy
    timebodygyroscopestdz
    timebodygyroscopejerkmeanx
    timebodygyroscopejerkmeany
    timebodygyroscopejerkmeanz
    timebodygyroscopejerkstdx
    timebodygyroscopejerkstdy
    timebodygyroscopejerkstdz
    timebodyacceleratormagnitudemean
    timebodyacceleratormagnitudestd
    timegravityacceleratormagnitudemean
    timegravityacceleratormagnitudestd
    timebodyacceleratorjerkmagnitudemean
    timebodyacceleratorjerkmagnitudestd
    timebodygyroscopemagnitudemean
    timebodygyroscopemagnitudestd
    timebodygyroscopejerkmagnitudemean
    timebodygyroscopejerkmagnitudestd
    frequencybodyacceleratormeanx
    frequencybodyacceleratormeany
    frequencybodyacceleratormeanz
    frequencybodyacceleratorstdx
    frequencybodyacceleratorstdy
    frequencybodyacceleratorstdz
    frequencybodyacceleratorjerkmeanx
    frequencybodyacceleratorjerkmeany
    frequencybodyacceleratorjerkmeanz
    frequencybodyacceleratorjerkstdx
    frequencybodyacceleratorjerkstdy
    frequencybodyacceleratorjerkstdz
    frequencybodygyroscopemeanx
    frequencybodygyroscopemeany
    frequencybodygyroscopemeanz
    frequencybodygyroscopestdx
    frequencybodygyroscopestdy
    frequencybodygyroscopestdz
    frequencybodyacceleratormagnitudemean
    frequencybodyacceleratormagnitudestd
    frequencybodyacceleratorjerkmagnitudemean
    frequencybodyacceleratorjerkmagnitudestd
    frequencybodygyroscopemagnitudemean
    frequencybodygyroscopemagnitudestd
    frequencybodygyroscopejerkmagnitudemean
    frequencybodygyroscopejerkmagnitudestd
