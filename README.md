---
title: "readme"
author: "MH"
date: "Sunday, July 26, 2015"
output: md_document
---

This file documents the analysis starting from data collected from the accelerometers from the Samsung Galaxy S, going thrugh 5 required by the course project steps:
1. Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Prerequsites for running run_analysis.R file:
1. downloading and unzipping files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to your working directory
2. loading plyr and dplyr libraries (in that order)
3. loading all necesary data (test data, training data, activity labels and features) into R

#How does the code work?
1. Merging the data
        +gathers all test and training data for X,y and subject files (rbinding)
        +sorts out the name issues (full naming procedure done)
        +cbinds all filles into one full_data_set
2. Extracts only mean and std measurements
        +keeps subject and activity id's and using contain function all measurements with std() or mean()                                 transformation in name
3. Give proper activity names
        +prepare names in activity_labels file
        +left joins the names into full_data_set
        +drops activity_id
4.Labels the data set with descriptive variable names
        +all special signs are deleted (and () changed into ".")
        +variable names are transformed into lower cases
5.Creates averages of the measurements
        +grouping based on two first columns is created (subject.id and activity.name)
        +summarize function giving the average values
        





