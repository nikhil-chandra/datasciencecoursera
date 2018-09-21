## Getting and Cleaning Data Project

Author: Nikhil Chandra

### Description
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

### Source Data
Data + Description can be found here (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The dataset includes the following files

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

# VARIABLES:
After loading the data set Column name(variables) was given to train and test set. And train and test set was merged on basis of same column names. Variables of merged data set are as:

* Activity_Label
* Subject
* timeBodyAccEMean-X
* timeBodyAccMean-Y
* timeBodyAccMean-Z
* etc.

# Transformations for cleaning up data

## Merges the training and the test sets to create one data set.
###setting working directory to project folder where UCI HAR Dataset was unzipped.


###Reading data from files
features     = read.table('./features.txt',header=FALSE);

###Reading train data

*subjectTrain = read.table('./train/subject_train.txt',header=FALSE);

### Assigning column names to imported training data

colnames(subjectTrain)  = "Subject";

### checking featuers columns

* colnames(features);

 
### Assigning xTrain column 

* colnames(xTrain) = features[,2]  ;
* colnames(yTrain)        = "Activity_Label"

###Finalizing the  training set by merging xTrain,yTrain,subjectTrain
trainingData=cbind(subjectTrain,yTrain,xTrain)

### Create the final Test set by merging xTest,yTest,subjectTest

testData = cbind(subjectTest,yTest,xTest)


## Appropriately labels the data set with descriptive variable names. 
colNames=colnames(finalDataSet)
