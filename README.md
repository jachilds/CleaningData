# CleaningData
Coursera Data Science Specialization: Getting and Cleaning Data Course Project

This repo contains an R program written (called "run_analysis()") for the final course project for the "Getting and Cleaning Data" course of the Data Science Specialization associated with Johns Hopkins University on Coursera. The program takes a series of .txt files, merges them, adds labels to each column, and then creates a clean, tidy data set.

The data used for project assignment is found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After unzipping the file, there are 8 files that are need to build the required tidy data set as specified in the project assignment. These files are:
1) "activity_labels.txt": this file contains a list of the 6 activities tested in the data set ("X_train.txt" and "y_train.txt"): walking, walking_upstairs,   walking_downstairs, sitting, standing, laying. Each activity has a numerical label from 1 to 6.
2) "features.txt": this file lists the variables that were tested in the data set. 30 participants were asked to perform the 6 activities listed in the "activity_labels.txt" file. Each participant wore a smart watch equipped with accelerometers and gyroscopes to collect acceleration. The "features.txt" is a list of the different measuresments that were collected across the accelerometers and gyroscopes. These are essentially the column names for the data set.
3) "subject_train.txt": this file lists the participants used in the training data set. 21 of 30 participants were used for the training data set ("X_train.txt").
4) "subject_test.txt": this file lists the 9 participants used in the test data set ("X_test.txt").
5) "y_train.txt": is a single column data file that lists the activity for each record in the training data set ("X_train.txt").
6) "y_test.txt": is a single column data file that lists the activity for each record in the training data set ("X_test.txt").
7) "X_train.txt": the training data set
8) "X_test.txt": the test data set

The R program written for this assignment, called "run_analysis", reads these files into R and then transforms them into a data tables using the dplyr package. Next, the test and training files are combined using rbind(): "subject_train" is combined with "subject_test" to create a data table called "subjects", "y_train" is combined with "y_test" to create a data table called "activities", and "X_train" is combined with "X_test" to create a data table called "full_data". 

Column names are applied to each of these three data tables. The "subjects" data table is a single column data table where the single column is named "subject". The "activities" data table is a single colunn data table where the single column is called "activity". The "features.txt" file contains the column names for the "full_data" data table. 

Once the "subjects", "activities" and "full_data" tables each have appropriate column names, they are combined using cbind to make a data table called "complete_data". "complete_data" contains all of the data in one in the 8 files above.

Next, a tidy data set is created where we only see the mean and standard deviation measurements from "complete_data". This completed by using the grepl function to search for "mean//(" or "std//(" in the column names of "complete_data". Once those columns are found, complete_data is reduced from 563 columns to just 68 columns. Next, the data is grouped by participant and activity. With 30 participants and 6 activities per participant, there are 180 records. The mean() and std() measurements are averaged for each of the 180 combinations of participant and activity to create a single, tidy data set called "tidy_data" in R. This "tiny data" object is also written to a .txt file called "Course Project Tidy Data Set.txt".

And that is what run_analysis() does: reads files, combines them, cleans them, summarizes them, and creates a single, tidy data set.
