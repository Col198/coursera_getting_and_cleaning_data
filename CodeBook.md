Getting and Creating Data - Course Project

Codebook for  the run_analysis.R script that performs  data and analysis on the "Human Activity Recognition Using Smartphones" dataset.

Objectives:

The script run_analysis.R runs the following proesses:
Downloads data to a directory and extracts it from the Zip file.
Extracts only the measurments on the mean and standard deviations for each measurment.
Uses descriptive activity names to name the activities.
Labels the dataset with appropriate, descriptive variable names.
Creates a tiny data set with the average of each variable for each activity and each subject.

The Script

The script performs the following in order:
downloads the data from this UCI Machine Learning Repository
merges the training and test sets
extracts the the mean and standard deviation for each measurement
sets and uses descriptive activity names
labels the columns with descriptive names
creates a tidy data set
creates a second, independent tidy dataset with an average of each measurement

The final dataset is output per the requirements set out for this course project.

The run_analysis.R file is appropriately commented and follows the logicial steps set out in the course project requirements.


More Information

Details on the layout and structure of the raw data can be found in the Readme.txt file

