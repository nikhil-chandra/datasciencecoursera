# Getting and Cleaning Data - R file
# Author: Nikhil Chandra

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#1.Merges the training and the test sets to create one data set.
#Reading data from files
features     = read.table('./features.txt',header=FALSE); #imports features.txt

#Reading train data
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
#Assigning column names to imported training data
colnames(subjectTrain)  = "Subject";
# checking featuers columns
colnames(features);
features[,2];
#checking xTrain columns
colnames(xTrain);
#Assigning xTrain column names as its equavalent to features[,2]number of names
colnames(xTrain) = features[,2]  ;
colnames(yTrain)        = "Activity_Label"
#Create the final training set by merging xTrain,yTrain,subjectTrain
trainingData=cbind(subjectTrain,yTrain,xTrain)
#Reading test data
# Read in the test data
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

#Assigning column names to imported test data
colnames(subjectTest)= "Subject"
colnames(xTest) = features[,2]  ; 
colnames(yTest)="Activity_Label"

#Create the final Test set by merging xTest,yTest,subjectTest
testData = cbind(subjectTest,yTest,xTest)

#Merging Training and test set to create final data set
finalDataSet= rbind(trainingData,testData)

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(finalDataSet); 

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# only retain features of mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select only the means and standard deviations from data
# increment by 2 because data has subjects and labels in the beginning
data.mean.std <- finalDataSet[, c(1, 2, features.mean.std$V1+2)]
bigData_mean<-sapply(finalDataSet,mean,na.rm=TRUE)
bigData_sd<-sapply(finalDataSet,sd,na.rm=TRUE)

#3.Uses descriptive activity names to name the activities in the data set

activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
# As activity having total 6 variables and yTrain,yTest named to 'Label' also having values 1-6 so following command assigning names of 1-6 activities in final data set.
finalDataSet$Activity_Label<-factor(finalDataSet$Activity_Label,levels=activityType$V1,labels=activityType$V2)

#4. Appropriately labels the data set with descriptive variable names. 
colNames=colnames(finalDataSet)
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalDataSet) = colNames;

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## reshape the array
library(reshape2)
molten <- melt(finalDataSet, id = c("Activity_Label", "Subject"))

## produce the tidy dataset with mean of each variable 
## for each activity and each subject
tidy <- dcast(molten, Activity_Label + Subject ~ variable, mean)
write.table(tidy,"tidy.csv",row.names=FALSE)
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');


