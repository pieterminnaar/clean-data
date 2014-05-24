# Reads the data files
# Row binds the test and train columns
# Reads the feature names
# Selects the columns that end in std() or mean()
# Requires reshape2 and plyr packages
library(reshape2)
library(plyr)

# Read the observations 
x.test.observations <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
x.train.observations <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)

# Combine the test and train dataset, note that the order here must be used for 
# the steps that read the subjects and activities (first test and then train)
observations <- rbind(x.test.observations, x.train.observations)

# Read the features
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

# Find the features that contain standard deviation and mean values
means.stds <- (regexpr("std\\(\\)", features[, 2]) > 0) | 
              (regexpr("mean\\(\\)", features[, 2]) > 0)

# Filter observations to only have the mean and std columns
observations.means.stds <- observations[, means.stds]

# Create readable names 
feature.names1 <- gsub("\\(\\)", "", features[,2][means.stds])
feature.names2 <- gsub("-", ".", feature.names1)
names(observations.means.stds) <- feature.names2

# Read the subject data
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjects <- rbind(subject.test, subject.train)

# Read the activity files 
activity.test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
activity.train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

# Combine activities
combined.activities <- rbind(activity.test, activity.train)

# Read activity labels and merge with the combined.activities
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
activities <- merge(combined.activities, activity.labels)

# Combine subjects and activities 
subject.activity <- cbind(subjects, activities[,2])
names(subject.activity) <- c("subject", "activity")

# Combine subjects+activites with the filtered observation data
combined.data <- cbind(subject.activity, observations.means.stds)

# Create a new dataset to create a row for each observation
combined.data.row.values <- melt(combined.data, id.vars=c("subject", "activity"))

# Calculate the means for the source data
mean.subject.activity.variable <- ddply(combined.data.row.values, 
                                       .(subject, activity, variable), 
                                       summarize, mean(value))
names(mean.subject.activity.variable)[4] <- "mean"

# Create a result file for all the steps 
write.csv(mean.subject.activity.variable, file = "tidy_data.txt", row.names=FALSE)

