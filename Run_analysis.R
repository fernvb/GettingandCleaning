#Download the file from the website#
download <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(download, destfile = "/Users/fernandavirginiabardos/R/GetClean/data/Dataset.zip", method = "curl")

#Unzip the file#
unzip(zipfile = "Dataset.zip", exdir = "/Users/fernandavirginiabardos/R/GetClean/data/")

#New Folder UCI HAR Dataset#
path <- file.path("/Users/fernandavirginiabardos/R/GetClean/data/", "UCI HAR Dataset")
listfiles <- list.files(path, recursive = TRUE)

#Allocating files to variables and merge datasets#
#Features files#
featurestest <- read.table(file.path(path, "test", "X_test.txt"), header = FALSE)
featurestrain <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)
datafeatures <- rbind(featurestrain, featurestest)
datafeaturesnames <- read.table(file.path("/Users/fernandavirginiabardos/R/GetClean/data/UCI HAR Dataset", "features.txt"), header = FALSE)
names(datafeatures) <- datafeaturesnames$V2

#Activity files#
activitytest <- read.table(file.path(path, "test", "Y_test.txt"), header = FALSE)
activitytrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)
dataactivity <- rbind(activitytrain, activitytest)
names(dataactivity) <-"Activity"

#Subject files#
subjecttest <- read.table(file.path(path, "test", "subject_test.txt"), header = FALSE)
subjecttrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
datasubject <- rbind(subjecttrain, subjecttest)
names(datasubject) <-"Subject"

#Combine all files in one dataset#
subjact <- cbind(datasubject, dataactivity)
fulldata <- cbind(datafeatures, subjact)

#Extract measurements on the mean and standard deviation for each measurement#
library(dplyr)
meanfulldata <- fulldata %>% select(contains("mean()"))
stdfulldata <- fulldata %>% select(contains("std()"))
mstdfulldata <- cbind(meanfulldata, stdfulldata, dataactivity, datasubject)

#Use descriptive activity names to name the activity in the mstdfulldata#
activitylabels <- read.table(file.path("/Users/fernandavirginiabardos/R/GetClean/data/UCI HAR Dataset", "activity_labels.txt"), header = FALSE)
mstdfulldata$Activity <- activitylabels[mstdfulldata$Activity, 2]

#Label dataset with descriptive variable names#
names(mstdfulldata) <- gsub("^t", "Time", names(mstdfulldata))
names(mstdfulldata) <- gsub("^f", "Frequency", names(mstdfulldata))
names(mstdfulldata) <- gsub("Acc", "Accelerometer", names(mstdfulldata))
names(mstdfulldata) <- gsub("BodyBody", "Body", names(mstdfulldata))
names(mstdfulldata) <- gsub("Gyro", "Gyroscope", names(mstdfulldata))
names(mstdfulldata) <- gsub("Mag", "Magnitude", names(mstdfulldata))
names(mstdfulldata) <- gsub("[()]","", names(mstdfulldata))
names(mstdfulldata) <- gsub("mean", "Mean", names(mstdfulldata))
names(mstdfulldata) <- gsub("std", "STD", names(mstdfulldata))

#Creates a second dataset, independent tidy data with average of each variable for each activity and subject
library(dplyr)
finaldata <- mstdfulldata %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))
write.table(finaldata, "/Users/fernandavirginiabardos/R/GetClean/data/Final_data.txt", row.names = FALSE)




