# Getting and Cleaning Data Course Project
## Project description

The following is from the project description on Coursera.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run\_analysis.R that does the following.

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 

## Project Dependencies

The run\_analysis.R file requires `dplyr` and `reshape2` packages.

## Running the code

From within R, execute the following code.  

`source("run_analysis.R")`

It will create the required data directory and download the needed data files.  Within  the data directory it will create three new files, sensor_means.txt, data/tidy\_data.csv and sensor\_means.csv, represnting the output.  The data will also exist within R in teh `melt_data` and `sensor_means` variables.

## Internals

The code combines the training and test data, initially using rbind to create unified views on the sensor data, activity, and subject.  For the sensor data, `select` is used along with `matches` to extract only the mean and standard deviation of the sensors.  teh column names are then cleaned up by making them all lower case and removing the periods to facilitate easier entry.  The data is then melted into a new form, with the sensors each becoming a column, and the value for the sensor reading a seperate column.  The data is then cast back from this form, taking the mean of each sensor value with respect to a given activity and subject.  This data is then melted back into a tidier format.  Finally, two csvs are generated, one containing all the sensor readings, and another containing the means.
