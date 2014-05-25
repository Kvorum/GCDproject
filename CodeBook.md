## Data Source
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Data Transformation Steps

Data transformations by the run_analysis.R script:
* Merges the training and the test sets by X, Y and subset using rbind
* Extracts only the measurements on the mean and standard deviation 
for each measurement using grep
* Replace activity ids by descriptive activity names in the data set and appropriately labels the data set (clean names)
* Create one data set with x, y and subject using cbind
* Transform data using melt 
* Creates a final (tidy) data set  with the average of each variable 
for each activity and each subject using dcast

## Variable Descriptions
Variable Descriptions can be found in README.txt of source package