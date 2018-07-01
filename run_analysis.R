# set working directory
setwd('F:/Study and Work/Coursera/Data Science Specialization/2 Getting and Cleaning Data/Week 4')
# download file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',destfile = 'dataset.zip',mode='wb')
unzip('dataset.zip')

# load datasets
train<-read.table('UCI HAR Dataset/train/X_train.txt') 
test<-read.table('UCI HAR Dataset/test/X_test.txt')
feature<-read.table('UCI HAR Dataset/features.txt')
activity<-read.table('UCI HAR Dataset/activity_labels.txt')

# combine train and test data to get a complete dataset
df<-rbind(train,test)

library(tidyverse)
# Appropriately labels the data set with descriptive variable names
# rename the column names using the descriptive column names stored in the 'features.txt'
names(df)<-feature[,2]
# Extracts only the measurements on the mean and standard deviation for each measurement
df2<-df[,grepl('mean\\(\\)|std\\(\\)',names(df))]

# read datasets that contain the information of activity types
trainLabel<-read.table('UCI HAR Dataset/train/y_train.txt')
testLabel<-read.table('UCI HAR Dataset/test/y_test.txt')

# combine train and test data
label<-rbind(trainLabel,testLabel)
# merge the activity type with its descriptive activity names
label<-left_join(label,activity)
# keep only the descriptive activity names
label<-label[,2]

# paste the descriptive activity name information to the dataset
df3<-cbind(label,df2)
# rename this label column to 'acitivityType'
names(df3)[1]<-'activityType'

# read datasets that contain the information of subjects
trainSubject<-read.table('UCI HAR Dataset/train/subject_train.txt')
testSubject<-read.table('UCI HAR Dataset/test/subject_test.txt')

# combine train and test data
subject<-rbind(trainSubject,testSubject)
# paste the subject information to the dataset
df4<-cbind(subject,df3)
# rename this subject column to 'subject'
names(df4)[1]<-'subject'

# create a tidy data set with the average of each variable for each activity and each subject
dfTidy<-df4%>%group_by(activityType,subject)%>%summarise_all(mean)
# rename the new aggregated variables with "mean_" in front of orginal names
names(dfTidy)[3:68]<-sapply(names(dfTidy)[3:68], function(x)paste('mean_',x,sep=''))

# output the dataset
write.csv(dfTidy,'tidydata.csv',row.names = F)

