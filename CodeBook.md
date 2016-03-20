---
title: "CodeBook.md"
author: "Fang-Ke Huang, PhD"
date: "March 20, 2016"
output: html_document
---

## Introduction
This code book describes the variables, the data, and any transformations or work that I performed to clean up the data.

## Study Design
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Code book
### Raw data files
Location: https://github.com/hfkltc/Getting-and-Cleaning-Data-Course-Project/tree/master/RawFiles

Scale: Features are normalized and bounded within [-1,1].

Units: 

- The acceleration signal from the smartphone accelerometer axis in standard gravity units 'g'

- The angular velocity vector measured by the gyroscope in units radians/second. 

Files:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'y_train.txt': Training labels.

- 'y_test.txt': Test labels.

- 'X_train.txt': Not included because the file is too big.

- 'X_test.txt': Not included because the file is too big.

For more information, please refer to: https://github.com/hfkltc/Getting-and-Cleaning-Data-Course-Project/blob/master/RawFiles/README.txt

### Data transformations
1. The training data 'X_train.txt' and the test data 'X_test.txt' were merged to create one data set "train_test".

2. Variable names were first captured from 'features.txt' and assigned to 'train_test' as its column names. Column names containing 'mean' or 'std' were picked out and the measurements in these columns were extracted. The resulting data set is called 'mean.std' and contains only the measurements on the mean and standard deviation for each observation.

3. The original variable names were converted to descriptive names. This step was done by replacing "^t" with "Time", "^f" with "Frequency", "Acc" with "Acceleration", "Gyro" with "Gyration", "Mag" with "Magnitude", "-mean()" with "Mean", "-std()" with "STD", "-meanFreq()" with "MeanFreq", "-X" with "X", "-Y" with "Y", "-Z" with "Z".

4. The column names of the data set 'mean.std' was replaced with the descriptive variable names.

5. The activity and subject information was captured from files: 'subject_train.txt', 'subject_test.txt', 'y_train.txt', and 'y_test.txt'. This information was then combined with data set 'mean.std'. An independent tidy data set 'dt.mean.std.summary' was created with the average of each variable for each activity and each subject.

### Variables
For each record it is provided:

- An identifier of the subject: 'f.subject'

- Its activity label: 'f.activity' 

- The average value of the mean and standard deviation of the time and frequency domain variables including the triaxial acceleration from the accelerometer (total acceleration), the estimated body acceleration, and triaxial Angular velocity from the gyroscope.

For example:
'TimeBodyAccelerationMeanX' represents the average value of the means of time doamin signals of body acceleration on the X axis with units 'g'.

For more information, please read https://github.com/hfkltc/Getting-and-Cleaning-Data-Course-Project/blob/master/RawFiles/features_info.txt