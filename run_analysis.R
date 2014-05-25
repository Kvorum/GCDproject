## run_analysis.R

library(reshape2)

# Merges the training and the test sets
v1 <- read.table("train/X_train.txt")
v2 <- read.table("test/X_test.txt")
set <- rbind(v1, v2)

v1 <- read.table("train/y_train.txt")
v2 <- read.table("test/y_test.txt")
act <- rbind(v1, v2)

v1 <- read.table("train/subject_train.txt")
v2 <- read.table("test/subject_test.txt")
sub <- rbind(v1, v2)

# Extracts only the measurements on the mean and standard deviation 
# for each measurement 
features <- read.table("features.txt", stringsAsFactors = FALSE)
features <- features[,2]
ex_features <- grep("-mean\\(\\)|-std\\(\\)", features)
set <- set[, ex_features]

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
activities[, 2] = tolower(gsub("_", "", activities[, 2]))
act[,1] = activities[act[,1], 2]

# Appropriately labels the data set 
ex_features <- grep("-mean\\(\\)|-std\\(\\)", features, value=TRUE)
ex_features <- tolower(gsub("\\(|\\)|-", "", ex_features))
names(set) <- ex_features
names(act) <- "activity"
names(sub) <- "subject"

# Create one data set with x, y and subject
onedataset <- cbind(sub, act, set)

# Creates a second (tidy) data set  with the average of each variable 
# for each activity and each subject
id_vars = c("activity", "subject")
measure_vars = setdiff(colnames(onedataset), id_vars)
meltdataset <- melt(onedataset, id=id_vars, measure.vars=measure_vars)
tidydataset <- dcast(meltdataset, subject+activity ~ variable, mean)
write.table(tidydataset, "tidy_data_set.txt")
