##---------------------------------------##
## Download and unzip the dataset archive##
##---------------------------------------##
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, 'Dataset.zip')
unzip('Dataset.zip')

##--------------------------------------------------------------##
## Merges the training and the test sets to create one data set.##
##--------------------------------------------------------------##

## This part makes use of the read_bind.R function provided in a second file           ##
## The read_bind function reads multiple files and bind the resulting data using rbind ##
 
source("read_bind.R")

dataPath <- 'UCI HAR Dataset'

## Reading and merging the features
featuresList <- read.table(sprintf('%s/features.txt', dataPath))
featuresNames <- featuresList$V2

# Reading and merging activities
activities <- read_bind(dataPath, 'y', 'activity')

# Reading and merging subjects
subjects <- read_bind(dataPath, 'subject', 'subject')

# Reading and merging measurements - Use the features names as columns names
measures <- read_bind(dataPath, 'X', featuresNames)

# Merge all data sets
dataset <- cbind(subjects, activities, measures)


##-----------------------------------------------------------------------------------------##
## Extracts only the measurements on the mean and standard deviation for each measurement. ##
##-----------------------------------------------------------------------------------------##

# Keep only measures about mean and standart deviation
dataset <- dataset[grepl("mean\\(\\)|std\\(\\)", featuresNames)]


##------------------------------------------------------------------------##
## Uses descriptive activity names to name the activities in the data set ##
##------------------------------------------------------------------------##

# Reading  activity labels from the activity_lables file
activityLab <- read.table(sprintf('%s/activity_labels.txt', dataPath))

# Naming the activities in the data set
dataset$activity <- activityLab[dataset$activity, 2]


##-------------------------------------------------------------------------------##
## From the data set in step 4, creates a second, independent tidy data set with ##
## the average of each variable for each activity and each subject.              ##
##-------------------------------------------------------------------------------##

tidy <- aggregate(dataset, by=list(dataset$subject, dataset$activity), FUN=mean)

# Remove activity and subject columns and rename aggregated columns
tidy$activity <- NULL
tidy$subject <- NULL
names(tidy)[names(tidy) == 'Group.1'] <- 'subject'
names(tidy)[names(tidy) == 'Group.2'] <- 'activity'

# Writing the resulting tidy data set in a file
write.table(tidy, "accelerometers_tidy.txt", sep="\t", row.names = FALSE)