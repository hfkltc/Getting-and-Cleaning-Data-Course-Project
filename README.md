# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set.

This readme.md explains how all of the scripts work and how they are connected.

The dataset includes the following folder and files:
- RawFiles folder
- CodeBook.md
- run_analysis.R

CodeBook.md describes the variables, the data, and any transformations or work that I performed to clean up the data.

run_analysis.R does the following:

1) Download the raw file and unzip the file into local directory.
2) Read and merges the training and the test sets to create one data set.
3) Extracts only the measurements on the mean and standard deviation for each measurement.
4) Uses descriptive activity names to name the activities in the data set
5) Appropriately labels the data set with descriptive variable names.
6) Creates an independent tidy data set with the average of each variable for each activity and each subject.
