# Reads the data files
# Row binds the test and train columns
# Reads the feature names
# Selects the columns that end in std() or mean()

x.test.observations <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
x.train.observations <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)

observations <- rbind(x.test.observations, x.train.observations)

features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

means.stds <- (regexpr("std\\(\\)", features[, 2]) > 0) | (regexpr("mean\\(\\)", features[, 2]) > 0)

observations.means.stds <- observations[, means.stds]

feature.names1 <- gsub("\\(\\)", "", features[,2][means.stds])
feature.names2 <- gsub("-", ".", feature.names1)

names(observations.means.stds) <- feature.names2

subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjects <- rbind(subject.test, subject.train)

activity.test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
activity.train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
combined.activities <- rbind(activity.test, activity.train)
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
activities <- merge(combined.activities, activity.labels)

subject.activity <- cbind(subjects, activities[,2])
names(subject.activity) <- c("subject", "activity")

combined.data <- cbind(subject.activity, observations.means.stds)
