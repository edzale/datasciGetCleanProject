# datasciGetCleanProject
This repository contains tidy data obtained after getting and cleaning data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The following steps have been performed:
  - Read and merge the training and the test sets to create one data set and use descriptive activity names to name the activities in the data set
  - Extract only the measurements on the mean and standard deviation for each measurement. 
Uses 
  - Appropriately labels the data set with descriptive variable names. 
  - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

To reproduce the results you need to run run_analysis.R 
run_analysis.R utilizes the read_bind function which is in read_bind.R
