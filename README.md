# Getting-and-Cleaning-Data-Week-4-Project

This is the Week 4 course assignment for the Getting and Cleaning Data course on Coursera. 

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
Background: One of the most exciting areas in all of data science right now is wearable computing . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data provided for the project is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The r script, run_analysis.R, transforms the raw data into a tidy data set called finaldata.txt as follows:
The script downloads the dataset (if it is not already in the working directory).
It unzips the project folder into the Week4_Project folder (if not already unzipped).
It loads the activity(Y_test.txt, Y_train.txt), subject (subject_test.txt, subject_train.txt) and feature info (X_test.txt, X_train.txt) and reads the data from the files into the corresponding variables.
It merges the training and the test sets to create a data set for subject, activity and features.
It sets names to the variables and for each dataset.
It combines the subject, activity and features datasets into a single data frame (called Data).
It extracts only the measurements on the mean and standard deviation for each measurement.
It uses descriptive activity names (from activity_labels.txt) to name the activities in the data set and factorizes the variables.
It appropriately labels the data set with descriptive variable names.
It creates a second, independent tidy data set called FINALDATA.txt with the average of each variable for each activity and each subject.
