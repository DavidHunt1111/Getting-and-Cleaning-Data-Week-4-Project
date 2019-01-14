## Week 4 Project - Getting and Cleaning Data
## Author: David Hunt

## Load modules

library(downloader)
library(plyr);
library(knitr)

## Load the dataset and unzip folder

if(!file.exists("./Week4_Project")){
  dir.create("./Week4_Project")
}

Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./Week4_Project/project_Dataset.zip")){
  download.file(Url,destfile="./Week4_Project/project_Dataset.zip",mode = "wb")
}

if(!file.exists("./Week4_Project/UCI HAR Dataset")){
  unzip(zipfile="./Week4_Project/project_Dataset.zip",exdir="./projectData")
}

path <- file.path("./projectData" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)

## Read the activity files
Y_Test  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
Y_Train <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

## Read the Subject files
Subject_Train <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
Subject_Test  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

## Read Features files
X_Test  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
X_Train <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

## Req 1. Merges the training and the test sets
Subject <- rbind(Subject_Train, Subject_Test)
Activity<- rbind(Y_Train, Y_Test)
Features<- rbind(X_Train, X_Test)

## 2. Set names to variables
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeatureNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(Features)<- FeatureNames$V2

## Combine Data into single data frame
Combine <- cbind(Subject, Activity)
Data <- cbind(Features, Combine)

## Req 2. Extracts only the measurements on the mean and standard deviation for each measurement.
subset_FeatureNames<-FeatureNames$V2[grep("mean\\(\\)|std\\(\\)", FeatureNames$V2)]
selectedNames<-c(as.character(subset_FeatureNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

## 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
Data$activity<-factor(Data$activity,labels=activityLabels[,2])

## 4. Appropriately labels the data set with descriptive variable names.
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.
FinalData<-aggregate(. ~subject + activity, Data, mean)
FinalData<-FinalData[order(FinalData$subject,FinalData$activity),]
write.table(FinalData, file = "finaldata.txt",row.name=FALSE,quote = FALSE, sep = '\t')