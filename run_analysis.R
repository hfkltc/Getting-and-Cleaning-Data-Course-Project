# ---
# title: "run_analysis.R"
# author: "Fang-Ke Huang, PhD"
# date: "March 20, 2016"
# ---

# Task
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Clear objects from the workspace
rm(list = ls())

# Download and unzip the raw files into working directory
setwd("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "auto")
unzip("Dataset.zip")

# 1) Merges the training and the test sets to create one data set.
training <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/train/X_train.txt")
test <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/test/X_test.txt")
train_test <- rbind(training, test)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# Variable names were first captured from 'features.txt' and assigned to 'train_test' as its column names.
features <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/features.txt")
colnames(train_test) <- features[, 2]
# Column names containing 'mean' or 'std' were picked out and the measurements in these columns were extracted.
mean.std <- train_test[, grep("mean|std", features[, 2])]
#including column contains mean(), std(), and meanFreq()

# 3) Uses descriptive activity names to name the activities in the data set
features <- colnames(mean.std)
# The original variable names were converted to descriptive names. This step was done by replacing "^t" with "Time", "^f" with "Frequency", "Acc" with "Acceleration", "Gyro" with "Gyration", "Mag" with "Magnitude", "-mean()" with "Mean", "-std()" with "STD", "-meanFreq()" with "MeanFreq", "-X" with "X", "-Y" with "Y", "-Z" with "Z".
features <- sub("^t", "Time", features)
features <- sub("^f", "Frequency", features)
features <- sub("Acc", "Acceleration", features)
features <- sub("Gyro", "Gyration", features)
features <- sub("Mag", "Magnitude", features)
features <- sub("-mean()", "Mean", features, fixed = TRUE)
features <- sub("-std()", "STD", features, fixed = TRUE)
features <- sub("-meanFreq()", "MeanFreq", features, fixed = TRUE)
features <- sub("-X", "X", features, fixed = TRUE)
features <- sub("-Y", "Y", features, fixed = TRUE)
features <- sub("-Z", "Z", features, fixed = TRUE)

# 4) Appropriately labels the data set with descriptive variable names.
# The column names of the data set 'mean.std' was replaced with the descriptive variable names.
colnames(mean.std) <- features

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# The activity and subject information was captured from files: 'subject_train.txt', 'subject_test.txt', 'y_train.txt', and 'y_test.txt'.
activity.labels <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/activity_labels.txt")
train.subject <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/test/subject_test.txt")
train.activity <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/train/y_train.txt")
test.activity <- read.table("C:/Users/Fang-Ke/Dropbox/courses/DataScienceTool/data-cleaning/project/UCI HAR Dataset/test/y_test.txt")
activity <- rbind(train.activity, test.activity)
subject <- rbind(train.subject, test.subject)
f.activity <- factor(activity$V1, labels = activity.labels$V2)
f.subject <- factor(subject$V1)
# This information was then combined with data set 'mean.std'.
mean.std <- cbind(mean.std, data.frame(f.activity, f.subject))
library(data.table)
dt.mean.std <- data.table(mean.std)
# An independent tidy data set 'dt.mean.std.summary' was created with the average of each variable for each activity and each subject.
dt.mean.std.summary <- dt.mean.std[,lapply(.SD,mean),by=.(f.subject, f.activity)]
dt.mean.std.summary <- dt.mean.std.summary[order(f.subject, f.activity)]
write.csv(dt.mean.std.summary, "mean.std.summary.csv", row.names = FALSE)
