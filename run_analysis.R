## Download data 
if (!file.exists("UCI HAR Dataset/")){
  message("Downloading data")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata-projectfiles-UCI HAR Dataset.zip"),
  unzip("getdata-projectfiles-UCI HAR Dataset.zip"))
}

## Read test set data
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test.subject) <- "subject"
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")
test.activity <- factor(test.activity$V1, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
test <- cbind(test.subject, test.activity, test.data)
names(test)[2] <- "activity"
rm(test.data, test.subject, test.activity)

## Read training set data
train.data <- read.table("UCI HAR Dataset/train/X_train.txt") 
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train.subject) <- "subject"
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")
train.activity <- factor(train.activity$V1, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
names(train)[2] <- "activity"
rm(train.data, train.subject, train.activity)

## Merges the training and the test sets to create one data set
dat.merged <- merge(test, train, by = intersect(names(test), names(train)), all = TRUE)
rm(test, train)

## Extracts only the measurements on the mean and standard deviation for each measurement
dat <- select(dat.merged, 1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544: 545)
rm(dat.merged)

## Uses descriptive activity names to name the activities in the data set
names(dat) <- list("subject", "activity", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()") 

## Appropriately labels the data set with descriptive variable names 
avedat <- ddply(dat, c("subject", "activity"), numcolwise(mean))

## Print the averaged data to a file 
write.table(avedat, file="HAR_averages.txt", row.names=FALSE) 




