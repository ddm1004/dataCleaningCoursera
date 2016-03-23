library(dplyr)
library(reshape2)

# Get Data Files from web 
if (!file.exists("data")){dir.create("./data")}
data.dir<- "./data/UCI HAR Dataset"
if (!file.exists(data.dir)){
  url <-paste("https://d396qusza40orc.cloudfront.net",
              "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",sep="/")
  download.file(url, destfile="data/data_sets.zip", method="curl")
  unzip("./data/data_sets.zip", exdir="./data")
}

# get data from dataset
features <- read.table(paste(data.dir, "features.txt",sep="/"))[,2]
activities <- read.table(paste(data.dir, "activity_labels.txt", sep="/"))[,2]
X_test <- read.table(paste(data.dir, "test", "X_test.txt", sep="/"),col.names=features)
y_test <- read.table(paste(data.dir,"test","y_test.txt", sep="/"))
subj_test <- read.table(paste(data.dir, "test","subject_test.txt",sep="/"))
X_train <- read.table(paste(data.dir,"train","X_train.txt",sep="/"),col.names=features)
y_train <- read.table(paste(data.dir,"train","y_train.txt", sep="/"))
subj_train <- read.table(paste(data.dir, "train","subject_train.txt",sep="/"))

# 1. combine the test and training datasets
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)
subj <- rbind(subj_test, subj_train)
names(subj) <- "subject"

# 2. select columns that contain mean or std
X <- select(X, matches("mean|std"))

# 3. create column to list activity by name 
y <- data.frame(activities[y[,1]])
names(y)<- "activity"
tidy_data <- cbind(y,subj,X)
# add column to represent subject
# 4. cleanup column names, remove "." and set to lower case 
names(tidy_data) <- tolower(gsub("[.]","",names(tidy_data)))

# 5. create a second data set with the average of each variable for each activity and each subject

# get data column names
data_names <- names(select(tidy_data,-activity, -subject))

melt_data <- melt(tidy_data,id=c("subject","activity"),measure.vars=data_names, value.name="reading")
colnames(melt_data)[3] <- "sensor"
sensor_means <- dcast(melt_data,subject+activity ~ sensor, mean)
sensor_means <- melt(sensor_means, id=c("subject","activity"), measure.vars=data_names, value.name="mean")
colnames(sensor_means)[3] <- "sensor"
write.csv(melt_data, file="./data/tidy_data.csv")

write.csv(sensor_means, file="./data/sensor_means.csv")
write.table(sensor_means, file="sensor_means.txt", row.names=FALSE)
