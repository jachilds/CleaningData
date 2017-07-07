run_analysis <- function() {
    
    #Set the directory
    setwd("C:/Documents/Coursera/Module 3/Project")
    
    #Load the relevant packages
    library(dplyr)

    #Open the relevant files using read.table and then convert to a dplyr data table object
    #activities: the list of activities (walking, walking_downstairs, sitting, etc.)
    #features: the list of the 561 measurements (these are column names for the data)
    #subject: the column which lists the participant (1 - 30) for each record of data
    #activities: the column which lists the activity for each record of data
    #data: the measurement data; 561 column headers and all records
    activity_label <- tbl_df(read.table("UCI HAR Dataset/activity_labels.txt"))
    features_label <- read.table("UCI HAR Dataset/features.txt")
    train_subject <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
    train_activities <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt"))
    train_data <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt"))
    test_subject <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
    test_activities <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt"))
    test_data <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt"))
    
    #Combine train and test data
    subjects <- rbind(train_subject, test_subject)
    activities <- rbind(train_activities, test_activities)
    full_data <- rbind(train_data, test_data)
    
    #Name the column in 'subjects'
    names(subjects) <- "subject"
    
    #Change the activity number (1-6) to a activity name (e.g. "walking")
    #Name the column in 'activities' to "activity"
    activities <- inner_join(activities, activity_label)
    activities <- activities[,2]
    names(activities) <-"activity"
    
    #Name the columns in 'full_data'
    data_names <- as.character(features_label[,2])
    names(full_data) <- data_names
    
    #Combine all data into one data table
    complete_data <<- cbind(subjects, activities, full_data)
    
    #Pull out only mean and std columns from 'full_data'
    cnames <- names(full_data)
    select_cols <<- grepl("mean\\(|std\\(",cnames)
    meanstddata <<- complete_data[,c(TRUE, TRUE, select_cols)]
    
    #Create a data table that is an average of each variable for each activity
    #and each subject; I interpretted this to mean that for participant 1, there
    #would be an average for each variable for the 6 activities (walking, 
    #standing, etc.); so with 30 participants with 6 activities, we would have 
    #180 rows with an average for each of the 66 variables
    groupeddata <- group_by(meanstddata, subject, activity)
    tidy_data <<- summarize_each(groupeddata, "mean", c(3:68))
    View(tidy_data)
    write.table(tidy_data, "Course Project Tidy Data Set.txt")
}    