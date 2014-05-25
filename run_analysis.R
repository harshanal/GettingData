##
## Coursera - Getting an CLeaning Data - Peer assessments
##

## Set working directory
setwd("C:/Users/user2/Dropbox/Coursera/Getdata/peerass/UCI HAR Dataset/UCI HAR Dataset")
## The reshape2 library has been used here for data manipulation
library(reshape2)
# Preparing dataset for Test data
dsTestSubject <- read.table("test/subject_test.txt")
dsXTest <- read.table("test/X_test.txt")
dsYTest <- read.table("test/y_test.txt")
# Preparing dataset for Train data
dsTrainSubject <- read.table("train/subject_train.txt")
dsXTrain <- read.table("train/X_train.txt")
dsYTrain <- read.table("train/y_train.txt")
# Preparing dataset for features and activity labels
featureList <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")
# Merging subject datasets
dsSubject <- rbind(dsTestSubject, dsTrainSubject)
colnames(dsSubject) <- "subject"
# Merging testing and training labels
dsLabel <- rbind(dsYTest, dsYTrain)
dsLabel <- merge(dsLabel, activityLabels, by=1)[,2]
# Merge the test and train main dataset, applying the textual headings
dsData <- rbind(dsXTest, dsXTrain)
colnames(dsData) <- featureList[, 2]
# Compiling full dataset
dsData <- cbind(dsSubject, dsLabel, dsData)
# Create a smaller dataset containing only the mean and std variables
search <- grep("-mean|-std", colnames(data))
dsMeanSt <- dsData[,c(1,2,search)]

# Compute the means, grouped by subject/label
melted = melt(dsMeanSt, id.var = c("subject", "label"))
means = dcast(melted , dsSubject + dsLabel ~ variable, mean)

# Save the resulting dataset
write.table(means, file="./data/tidy_data.txt")

# Output final dataset
means