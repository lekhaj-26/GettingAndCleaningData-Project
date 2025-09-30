library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")


features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "featureName"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityLabel"))

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectId")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectId")

X_all <- rbind(X_train, X_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)

colnames(X_all) <- features$featureName

mean_std_features <- grep("-(mean|std)\\(\\)", features$featureName)
X_mean_std <- X_all[, mean_std_features]

y_all <- merge(y_all, activity_labels, by = "activityId")
activity <- y_all$activityLabel

names(X_mean_std) <- gsub("\\()", "", names(X_mean_std))
names(X_mean_std) <- gsub("-", "_", names(X_mean_std))
names(X_mean_std) <- gsub("^t", "TimeDomain_", names(X_mean_std))
names(X_mean_std) <- gsub("^f", "FrequencyDomain_", names(X_mean_std))
names(X_mean_std) <- gsub("Acc", "Accelerometer", names(X_mean_std))
names(X_mean_std) <- gsub("Gyro", "Gyroscope", names(X_mean_std))
names(X_mean_std) <- gsub("Mag", "Magnitude", names(X_mean_std))
names(X_mean_std) <- gsub("BodyBody", "Body", names(X_mean_std))

tidyData <- cbind(subject_all, activity, X_mean_std)

tidyData_summary <- tidyData %>%
  group_by(subjectId, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

write.table(tidyData_summary, "tidy_data.txt", row.names = FALSE)

