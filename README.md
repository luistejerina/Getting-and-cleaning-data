# Getting-and-cleaning-data
This repository contains an R file called run_analysis.R that processes the data for the Getting and cleaning data course project. 
The code loads he dataframes contained in the Human Activity Recognition Using Smartphones Data Set at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
accessed on july 18th 2015. (see their website for specific information on the experiment)

The R file processes the data for 30 individuals and 6 activities and keeps only the measurements for means and standard deviations of each of the measurments taken on them (see codebook for the description of each measurement.

#DATAFILES BUILT WITH run_analysis.R
completedataMelted
The R file builds a dataframe called completedatab which containd 4 columns, one for the activity, one for the id of the subject, on for the type of measurement taken and one for the value of the measurement.The file has 679734 values in total (rows) for 33 types of measurements for 6 activities and for 30 individuals.

completedatab

This file saves only the means of the measurements for each variable for each activity and for each individual. the resulting datafram contains 11880 observations of the mean of the mean and standard deviation of each measurement. that is one observation for each person-activity-measurment combination.

#the steps followed by the code are the following:

Step 1
  This section reads all the datasets needed for the exercise
  it assumes that folder "getdata-projectfiles-UCI HAR Dataset" is located in the working directory
Step 2
  this section loads necessary librarys for the exercise

Step 3
  this section uses dataframe "features" to assign the name of the columns of the different measurements in the dataframe
  does the same for both datasets separately (could've done it laer together)

Step 4

  this section joins together the columns corresponding to activity and subject into the test dataframe

Step 5
  this section joins together the columns corresponding to activity and subject into the train dataframe

Step 6
  this section appends the train and test vertically (one on top of another)

Step 7
  this one changes the name of variables to subject and activity

Step 8
  Merges the data with the activity labels, other methods not worked, so first i merge the data and then i erase the number 
Step 9
  erases the number column that gets merged with the data

Step 10
  changes te name of the variable to activity
  
Step 11  
  this section creates a dataframe a that contains all variables (columns) that contain "mean" in their name

Step 12  
  this section creates a dataframe b that contains all variables (columns) that contain "std" in their name

Step 13
here i join a and b, that is all the variables with mean and standard deviation in their names

Step 14
  this section gets the datanames of the columns except activity and subject

Step 15
this one melts the data using the datanames list from the previous command to aoid typing all the variable names
This is the final large dataset with 4 variables activity, subject, type f measurement and value

Step 16
This one uses de ddply command to collapse the data into the means by activity, subject and variable(i.e. type of variable)


Step 17
this section exports the data into a txt file with    

Step 18
clean other datafiles

write.table(completedatab,  "completedatab.txt", row.names = FALSE)


