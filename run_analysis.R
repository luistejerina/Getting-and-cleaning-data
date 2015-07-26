##Step 1 This section reads all the datasets needed for the exercise
##it assumes that folder "getdata-projectfiles-UCI HAR Dataset" is located in the working directory
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
X_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
y_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
activity_labels <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
X_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")

##Step 2 this section loads necessary librarys for the exercise
library(plyr)
library(reshape2)
##Step 3 this section uses dataframe "features" to assign the name of the columns of the different measurements in the dataframe
##does the same for both datasets separately (could've done it laer together)
names(X_test)<-features[,2]
names(X_train)<-features[,2]


##Step 4 this section joins together the columns corresponding to activity and subject into the test dataframe
test=cbind(subject_test,y_test,X_test)
test$group <- rep(1,nrow(test)) # make new column 

##Step 5 this section joins together the columns corresponding to activity and subject into the train dataframe
train=cbind(subject_train,y_train,X_train)
train$group <- rep(2,nrow(train)) # make new column 

##Step 6 this section appends the train and test vertically (one on top of another)
completedata=rbind(test,train)

##Step 7 this one changes the name of variables to subject and activity
colnames(completedata)[1]<-"subject"
colnames(completedata)[2]<-"activity"


##Step 8 Merges the data with the activity labels, other methods not worked, so first i merge the data and then i erase the number column

completedata <- merge(activity_labels, completedata, by.x = "V1", by.y = "activity")
##Step 9 erases the number column that gets merged with the data
completedata<-completedata[,-1]
##Step 10 changes te name of the variable to activity
colnames(completedata)[1]<-"activity"

##Step 11 this section creates a dataframe a that contains all variables (columns) that contain "mean" in their name
a<-completedata[,grepl("mean\\(", colnames(completedata))]
##Step 12 this section creates a dataframe b that contains all variables (columns) that contain "std" in their name
b<-completedata[,grepl("std", colnames(completedata))]
#Step 13 here i join a and b, that is all the variables with mean and standard deviation in their names
completedata<-cbind(completedata[,c(1,2)],a,b)




##Step 14 this section gets the datanames of the columns except activity and subject
completedatanames<-colnames(completedata[,3:68])
##Step 15 this one melts the data using the datanames list from the previous command to aoid typing all the variable names
##This is the final large dataset with 4 variables activity, subject, type f measurement and value

completedataMelt<-melt(completedata,id=c("activity","subject"),measure.vars=c(completedatanames))


##Step 16 This one uses de ddply command to collapse the data into the means by activity, subject and variable(i.e. type of variable)

completedatab <- ddply(completedataMelt, c("activity", "subject","variable"), summarise,mean = mean(value))

##Step 17 reshape to wide because im not sure i will receive credit for long format
completedatac <- dcast(completedatab, subject+activity ~ variable, mean)

##Step 18 this section exports the data into a txt file with                                                                                                     

write.table(completedatac,  "completedatac.txt", row.names = FALSE)

##Step 18 clean other datafiles
rm(a,b,completedatanames,activity_labels,completedata,features,subject_test,subject_train,test, train, X_test,X_train,y_test,y_train)


