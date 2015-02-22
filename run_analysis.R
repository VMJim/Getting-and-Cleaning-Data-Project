# author: Jim v.M.
# project: Getting & Cleaning Data

# Load required packages:
library("dplyr")

# list vars & data in memory:
existing.vars <- ls()
existing.vars <- ls() # has to be included itself ;)

# DOWNLOAD & STORE FILE in your working directory:
if( !file.exists("UCI HAR Dataset") ){
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./human_activity.zip", mode = "wb")
unzip("human_activity.zip")
}

## Extract relevant data sets:
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# intersect(unique(indiv_test),unique(indiv_train)) # sanity check: it's empty.

# 1. Merge training and test sets:
# Merging simply means rbind and cbind the data.frames here. The common attribute 
# is subject, but it's values form a partition over test and train.

test_set <- cbind(subject_test, y_test,X_test)
train_set <- cbind(subject_train, y_train, X_train)

mydata <- rbind(test_set, train_set)

## collect garbage and remove from memory:
rm(list = setdiff(ls(), c("mydata", existing.vars))

## give descriptive names to variables (attributes)

feature_names <- read.table("./UCI HAR Dataset/features.txt",
      colClasses = c("NULL", "character"))

feature_names$V2 <- gsub(pattern = "\\(\\)", replacement = "", x = feature_names$V2)
feature_names$V2 <- gsub(pattern = "-", replacement = ".", x = feature_names$V2)
feature_names$V2 <- sub(pattern = "t", replacement = "time.", x = feature_names$V2)
feature_names$V2 <- sub(pattern = "f", replacement = "frequency.", x = feature_names$V2)

header_names <- c("subject", "activity", feature_names$V2)
colnames(mydata) <- header_names

# 2. Extract mean and stdevs from the *measurement attributes*:
to_keep <- grepl("mean", header_names) | grepl("std", header_names)
to_keep[1:2] <- TRUE # also keep the subject and outcome/activity variables
mydata <- mydata[,to_keep]

# 3. Use descriptive activity names to name the activities in the data set:
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt",
                            colClasses = c("factor", "character"))

mydata$activity <- factor(mydata$activity, levels = c(1:6), 
                          labels = activity_names$V2)

# 4. Appropriately labels the data set with descriptive variable names
# already done in step 1: column/variable names taken from "./UCI HAR Dataset/features.txt"

# 5. From the data set in step 4, create a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

## via dplyr:

my_tbl <- tbl_df(mydata) %>%
 group_by(subject, activity) %>%
      summarise_each(funs(mean))

## via data.table:
# myDT <- as.data.table(mydata)
# hello <- myDT[,lapply(.SD, mean), by=c("subject","activity")]
# hello <- hello[order(hello$subject),]

# "6." Write to table:

write.table(my_tbl, file = "./tidy_table.txt", row.names = F)
# to be called as: read.table(file = "./tidy_table.txt", header = T)

# "7." again collect all garbage and remove, 
# leaving everything as it was before running the script:

rm(list = c(setdiff(ls(), existing.vars), "existing.vars"))
