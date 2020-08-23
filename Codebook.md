The Run_analysis.R script performs a data preparation.

1) Download the file from the website and unziping it. The data is extracted in the folder called "UCI HAR Dataset"

2) Allocate the files of the UCI HAR Dataset into variables and merge the files

featurestest <- X_test.txt
featurestrain <- X_train.txt
datafeatures is created with rbind usign featurestest and featurestrain

activitytest <- Y_test.txt
activitytrain <- Y_train.txt
dataactivity is created with rbind using activitytrain and activitytest

subjecttest <- subject_test.txt
subjecttrain <- subject_train.txt
datasubject is created using rbind using subjecttrain and subjecttest

3) Merging activity and subject and then merging with features
subjact is created usign cbind(datasubject, dataactivity)
fulldata is created using cbind(datafeatures, subjact) - fulldata is the ONE resulted dataset by merging feature, activity and subject

4) Extract measurements on the mean and standard deviation for each measurement
Using library(dplyr), extracted columns containg mean and std and combining to created a full dataset usign cbind
mstdfulldata is created and contains the measurements with mean and std, activity, subject


5) Use descriptive activity names to name the activity in the mstdfulldata
Uses the file activity_labels.txt to replace the corresponding activity in the mstdfulldata, taken from the file activity_labels.txt 

6) Label dataset with descriptive variable names for better understanding of the variables
t replaced by Time
f replaced by Frequency
Acc replaced by Accelerometer
BodyBody replaced by Body 
Gyro replaced by Gyroscope
Mag replaced by Magnitude
mean() replaced by Mean
std() replaced by STD
mstdfulldata is the tidy dataset resulting of this process

7) Create second dataset, based on mstdfulldata, independent tidy data with average of each variable for each activity and subject
Using library(dplyr), the data is summarize, generating the finaldata, taking the means of each variable for each activity and each subject, grouped by subject and activity
Export finaldata into Final_data.txt file
