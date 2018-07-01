# Getting and Cleaning Data Course Project
First, I set working directory to where I want it using `setwd()`.
Then I download the file with `download.file()`, and unzip them with `unzip()`.

Then I load datasets of the 561-feature of train and test data, the datasets contain features (descriptive) and labels (descriptive) with `read.table()`.  
Then I combine train and test data to get a complete dataset with `rbind()`, and store it in a new variable `df`.  
Then I label the data set with descriptive variable names by using the descriptive information contained in `features.txt`.  
Finishing last step, I can extract only the measurements on the mean and standard deviation for each measurement using `grepl()` by matching `mean()` and `std()`. I store the dataset in a new variable `df2`.

Then I read datasets that contain the information of activity types for both train and test data. Then I combine these two datasets.  
Then I merge the activity type with its descriptive activity names and keep only the descriptive activity names.  
Then I paste the descriptive activity name information to the dataset using `cbind()`, and store it in a new variable `df3`, and rename the added column to "acitivityType".

Then I read datasets that contain the information of subjects, and similarly, combine train and test data.  
Then I paste the subject information to the dataset, and store it in a new variable `df4`, and rename this subject column to 'subject'

Finally, I create a tidy data set with the average of each variable for each activity and each subject using `group_by()` and `summarise()` from `{tidyverse}`, and store it in a new variable `dfTidy`, and rename the new aggregated variables with "mean_" in front of orginal names to explictly indicate the values are aggreated values.  
Then I output the `dfTidy` to `tidydata.csv` using `write.csv()`.
