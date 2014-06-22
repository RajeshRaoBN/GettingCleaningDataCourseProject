GettingCleaningDataCourseProject
================================

Getting and Cleaning Data Course Project Submission

Repository to host project for evaluation.

The Project is discribed below:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Good luck!

The project is a part of Coursera DataSceince Stream Getting and Cleaning Data

For more information about the course go to https://class.coursera.org/getdata-004

Accompanying files include run_analysis.R which is the R script file on the data set, tidy_data_set.csv the outcome of the script file and CodeBook.md describing the code step by step.

The run_analysis.R when run on RStudio will generate tidy_data_set.csv which is loaded as tidy_data_set.txt in the coursera submission page as coursera does not accept csv files. Instruction as to how to load the text file into RStudio and view it is given below:
TDS <- read.delim("~/tidy_data_set.txt")
View(TDS)
Download the dataset from the link above.
