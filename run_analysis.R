## Part 1 Merge all files to create one data set ############
##Merge Activity Data and Assign "Activity" as the name of the column
activity_test <- read.table("test/y_test.txt")
activity_train <- read.table("train/y_train.txt")
Activity_combine <- rbind(activity_test,activity_train)
names(Activity_combine) <- "Activity"

##Merge Subject Data and Assign "Subject" as the name of the column
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")
Subject_combine <- rbind(subject_test,subject_train)
names(Subject_combine) <- "Subject"

##Merge Feature Data 
feature_test <- read.table("test/X_test.txt")
feature_train <- read.table("train/X_train.txt")
Feature_combine <- rbind(feature_test,feature_train)

##Join Feature Data with feature.txt as names of columns
feature <- read.table("features.txt")
names(feature) <- c("id", "name")
names(Feature_combine) <- feature$name

##Join all Data to form one complete data set   
complete_data_set <- cbind(Feature_combine, Activity_combine, Subject_combine)
#write.table(complete_data_set, "complete_data_set.txt")      



## Part 2 Extract mean and std measurements ################
## Extract only mean and std
Temp <- c(grep("mean[(]|std[(]", feature[,2]), ncol(complete_data_set)-1, ncol(complete_data_set))
subset_data <- complete_data_set[, Temp]



## Part 3 Uses descriptive activity names #############
##Read activity_labels.txt and apply it on subset_data
activity <- read.table("activity_labels.txt")
names(activity) <- c("id", "name")
subset_data$Activity <- as.character(factor(subset_data$Activity, labels=activity$name))



## Part 4 : Labels data set with descriptive variable names ###########
Temp2 <- names(subset_data)
Temp2 <-gsub("Gyro", " Gyroscope", Temp2)
Temp2 <-gsub("^t", "Time", Temp2)
Temp2 <-gsub("Mag", " Magnitude", Temp2)
Temp2 <-gsub("std","standard.deviation", Temp2)
Temp2 <-gsub("\\()",",", Temp2)
Temp2 <-gsub("-",".", Temp2)
Temp2 <-gsub("^f", "frequency", Temp2)
Temp2 <-gsub("Acc", "Accelerometer", Temp2)
names(subset_data) <- make.names(Temp2)



## Part 5 : Find average and write to text file ###############
Temp3 <- subset_data[,-c(ncol(subset_data)-1, ncol(subset_data))]
Independent_Set <- aggregate(Temp3, by = list(subset_data$Activity, subset_data$Subject), mean)
colnames(Independent_Set)[1] <- "Subject"
colnames(Independent_Set)[2] <- "Activity"
write.table(Independent_Set, "Independent_Set.txt", row.name=FALSE)
