# Import the dplyr library
library(dplyr)

# Reading test dataset
x.test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
y.test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
subject.test <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep="", header=FALSE)

# Merge test datasets into a single dataframe
test <- data.frame(subject.test, y.test, x.test)

# Reading training dataset
x.train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="",header=FALSE)
y.train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="",header=FALSE)
subject.train <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep="", header=FALSE)

# Merge training datasets into a single dataframe
train <- data.frame(subject.train, y.train, x.train)

# Creating the data we need and removing the aux data
run_data <- rbind(train, test)
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
# some columns have the same name in the documentation, so that I joined the number of column with the name
features<-mutate(features,nf=paste(V1,V2,sep="-"))

column.names <- c("subject_id", "activity_labels",as.vector(features[, 3]))
colnames(run_data) <- column.names

remove(subject.test, x.test, y.test, subject.train,x.train, y.train, test, train,column.names,features)

#Second Item: selecting only the measurements on the mean and standard deviation for each measurement.
run_data <- select(run_data, contains("subject"), contains("label"),
                   contains("mean"), contains("std"), -contains("freq"),
                   -contains("angle"))

# Uses descriptive activity names to name the activities in the data set
activity.labels <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="", header=FALSE)

# 4. Appropriately labels the data set with descriptive variable names.

run_data$activity_labels <- as.character(activity.labels[match(run_data$activity_labels, 
                                                               activity.labels$V1), 'V2'])



colnames(run_data)<-names(setNames(run_data, (gsub("\\(\\)", "", colnames(run_data)))))
colnames(run_data)<-names(setNames(run_data, (gsub("^(.*?)-", "", colnames(run_data)))))
colnames(run_data)<-names(setNames(run_data, (gsub("-", "_", colnames(run_data)))))
colnames(run_data)<-names(setNames(run_data, (gsub("BodyBody", "Body", colnames(run_data)))))



# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject

run_data_summary <- run_data %>%
  group_by(subject_id, activity_labels) %>%
  summarise_each(list(mean))

# Writting to file
write.table(run_data_summary, file="run_data_summary.txt", row.name=FALSE)