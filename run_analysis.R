# Reads the data files
# Row binds the test and train columns
# Reads the feature names
# Selects the columns that end in std() or mean()

x.test.observations <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
x.train.observations <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)

observations <- rbind(x.test.observations, x.train.observations)

features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

means.stds <- (regexpr("std()", features[, 2]) > 0) | (regexpr("mean()", features[, 2]) > 0)

observations.means.stds <- observations[, means.stds]