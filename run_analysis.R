# Create directory and download data into directory 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Unzip data file
unzip(zipfile ="./data/Dataset.zip",exdir = "./data" )

# Set file path
dirpath <- file.path("./data" , "UCI HAR Dataset")


# Read data from text files for training and testing into new variables
ActivityDataTest  <- read.table(file.path(dirpath, "test" , "Y_test.txt" ),header = FALSE)
ActivityDataTrain <- read.table(file.path(dirpath, "train", "Y_train.txt"),header = FALSE)
SubjectDataTrain <- read.table(file.path(dirpath, "train", "subject_train.txt"),header = FALSE)
SubjectDataTest  <- read.table(file.path(dirpath, "test" , "subject_test.txt"),header = FALSE)
FeaturesDataTest  <- read.table(file.path(dirpath, "test" , "X_test.txt" ),header = FALSE)
FeaturesDataTrain <- read.table(file.path(dirpath, "train", "X_train.txt"),header = FALSE)

#Look at datasets
str(ActivityDataTest)
str(ActivityDataTrain)
str(SubjectDataTrain)
str(SubjectDataTest)
str(FeaturesDataTest)
str(FeaturesDataTrain)

# Merge Training and Test data sets and set names
dataSubject <- rbind(SubjectDataTrain, SubjectDataTest)
dataActivity<- rbind(ActivityDataTrain, ActivityDataTest)
dataFeatures<- rbind(FeaturesDataTrain, FeaturesDataTest)

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(dirpath, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# Extract measurements on the mean and standard deviation for each measurement
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

str(Data)

# Rename the activities in the data set with descriptive names
activityLabels <- read.table(file.path(dirpath, "activity_labels.txt"),header = FALSE)
Data$activity <- activityLabels[Data$activity, 2]
head(Data$activity,50)

# Label the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)

# Install PLYR package
library(dplyr);

# Create second independent data set with average of each variable
TinyData<-aggregate(. ~subject + activity, Data, mean)
TinyData<-TinyData[order(TinyData$subject,TinyData$activity),]
write.table(TinyData, file = "./data/tidydata.txt",row.name=FALSE)

str(TinyData)







