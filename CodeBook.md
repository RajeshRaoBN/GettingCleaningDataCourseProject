Introduction

This file describes the data, the variables, and the work that has been performed to clean up the data.

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Human Activity Recognition Using Smartphones Data Set 
Download: Data Folder, Data Set Description

Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 

For each record it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
The dataset includes the following files:

'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.
'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Transformations of Data

Load libraries for this one we will work with data tables alone as we are interested in working with data frame. We will use cbind and rbind for merging.

library(data.table)

Load data: Download the zip file and extract in a folder, use setwd() to specfy the root directory 

testX <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testY <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

Variable data

The class labels linked with their activity names are loaded from the activity_labels.txt file. The numbers of the testY and trainY data frames are replaced by those names:

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
names(testY)
names(trainY)
names(activityLabels)

Convert it into factor variables

testY$V1 <- factor(testY$V1,levels=activityLabels$V1,labels=activityLabels$V2)
trainY$V1 <- factor(trainY$V1,levels=activityLabels$V1,labels=activityLabels$V2)

Appropriately labels the data set with descriptive variable names. 
Naming the variables on the data set

Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly before merging them to the test and train dataset.

features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
names(features)
colnames(testX)<-features$V2
colnames(trainX)<-features$V2

Uses descriptive activity names to name the activities in the data set

colnames(testY)<-c("Activity")
colnames(trainY)<-c("Activity")
colnames(testSub)<-c("Subject")
colnames(trainSub)<-c("Subject")

Merges the training and the test sets to create one data set.
Note we are using rbind and cbind instead of merge as the rows and columns match.
Check this in the RStudio Enviornment window or use str() to confirm
The Activity and Subject columns are appended to the test and train data frames, and then are both merged in the oneDataSet data frame. We first use cbind to obtain a common test and train data set and then combine both in rbind.

test<-cbind(testX,testY,testSub)
train<-cbind(trainX,trainY,trainSub)
oneDataSet<-rbind(test,train)

extract only the measurements on the mean and standard deviation for each measurement

mean() and sd() are used against oneDataSet via sapply() to extract the requested measurements.

oneDataSetMean<-sapply(oneDataSet,mean,na.rm=TRUE)
oneDataSetSD<-sapply(oneDataSet,sd,na.rm=TRUE)

A warning is returned for the Activity column because it's not numeric. This does not impact the calcucation of the rest and NA is stored in the new data frames instead, since mean and sd are not applicable in this case. The same applies for Subject where we're not interested about the mean and sd, but since it's numeric already there is no warning.

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finaly the desired result, a tidy data table is created with the average of each measurement per activity/subject combination. The new dataset is saved in tidy_data_set.csv file.

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Use data.table() function to convert the final data into a data table. Use lapply
Finally write it into a csv file called tidy_data_set.csv

oneDataTable <- data.table(oneDataSet)
tidyDataSet<-oneDataTable[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidyDataSet,file="tidy_data_set.csv",sep=",",row.names = FALSE)
