# Load libraries for this one we will work with data tables alone as we are
# interested in working with data frame. We will use cbind and rbind for merging.
library(data.table)

# Load data: Download the zip file and extract in a folder, use setwd() to specfy 
# the root directory 
testX <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testY <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Variable data
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
names(testY)
names(trainY)
names(activityLabels)
# Convert it into factor variables
testY$V1 <- factor(testY$V1,levels=activityLabels$V1,labels=activityLabels$V2)
trainY$V1 <- factor(trainY$V1,levels=activityLabels$V1,labels=activityLabels$V2)

# 4. Appropriately labels the data set with descriptive variable names. 
# Naming the variables on the data set
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
names(features)
colnames(testX)<-features$V2
colnames(trainX)<-features$V2

# 3. Uses descriptive activity names to name the activities in the data set
colnames(testY)<-c("Activity")
colnames(trainY)<-c("Activity")
colnames(testSub)<-c("Subject")
colnames(trainSub)<-c("Subject")

# 1. Merges the training and the test sets to create one data set.
# Note we are using rbind and cbind instead of merge as the rows and columns match.
# Check this in the RStudio Enviornment window or use str() to confirm
test<-cbind(testX,testY,testSub)
train<-cbind(trainX,trainY,trainSub)
oneDataSet<-rbind(test,train)

# 2. extract only the measurements on the mean and standard deviation for each measurement
oneDataSetMean<-sapply(oneDataSet,mean,na.rm=TRUE)
oneDataSetSD<-sapply(oneDataSet,sd,na.rm=TRUE)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Use data.table() function to convert the final data into a data table. Use lapply
# Finally write it into a csv file called tidy_data_set.csv
oneDataTable <- data.table(oneDataSet)
tidyDataSet<-oneDataTable[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidyDataSet,file="tidy_data_set.csv",sep=",",row.names = FALSE)
