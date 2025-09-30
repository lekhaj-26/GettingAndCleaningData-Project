# Code Book

This code book describes the variables, the data, and the transformations performed to clean up the data.

## Data Source
The original data comes from the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Variables
- subjectId: Identifier of the subject (range 1–30).
- activity: Activity performed (Walking, Sitting, Standing, Laying, Walking Upstairs, Walking Downstairs).
- Measurement variables: mean and standard deviation for accelerometer and gyroscope signals.
  Example: 
  - TimeDomain_BodyAccelerometer_mean_X
  - TimeDomain_BodyAccelerometer_std_Y
  - FrequencyDomain_BodyGyroscope_mean_Z

## Transformations
1. Merged training and test datasets.
2. Extracted only measurements on the mean and standard deviation.
3. Used descriptive activity names.
4. Renamed variables with descriptive labels.
5. Created a tidy dataset with the average of each variable for each activity and each subject.
