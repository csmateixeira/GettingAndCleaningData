Code Book
======================

### Feature labels

Feature labels were modified in the following pattern: 

* "-" was removed
* "()" was removed
* starting "t" -> "time"
* starting "f" -> "frequency"
* "BodyBody" -> "body"
* "Acc" -> "accelerator"
* "Gyro" -> "gyroscope"
* "Mag" -> "magnitude"

The final feature name transformations included in the tidy dataset were as follows:

<table>
    <th>
        <td>Original name</td>
        <td>Transformed Name</td>
    </th>
    <tr>
        <td>tBodyAcc-mean()-X</td>
        <td>timebodyacceleratormeanx</td>
    </tr>
</table>

|      |           |
|-----------------------------------------------|
|  |   |
| tBodyAcc-mean()-Y | timebodyacceleratormeany  |
| tBodyAcc-mean()-Z | timebodyacceleratormeanz  |
