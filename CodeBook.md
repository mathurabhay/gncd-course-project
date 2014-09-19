
##gncd-course-project
===================

### CODE BOOK

## describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

## Source Data

## Data Set Information
(REFER: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


##Getting and Cleaning activities carried (step wise)
(refer: couse project page)

ALL REQUIRED FILES WERE COPIED / EXTRACTED TO A COMMON FOLDER "UCI HAR Dataset". ORIGINAL FOLDER STRUCTURED REMAINS UNALTERED

### TASK 1. Merge the training and the test sets to create one data set.

There are two sets of data, training data and test data.

Training and Test data is read into following tables

features.txt to Features
activity_labels.txt to AType

subject_train.txt to STrain
x_train.txt to xTrain
y_train.txt to yTrain
subject_test.txt to STest
x_test.txt to xTest
y_test.txt to yTest

User friendly column header were set.....

Both test data and training data are merged to creat single data set


### TASK 2. Extract only the measurements on the mean and standard deviation for each measurement.

Create a logcal vector that contains 
- TRUE values for the ID, mean and stdev columns and 
- FALSE values for the rest

CREATED; SUBSET OF THIS DATA SET

### TASK 3. Use descriptive activity names to name the activities in the data set

- Use descriptive activity names to name the activities in the data set
- Merging the finalData set with the AType 
- Updating the colNames vector

### TASK 4. Appropriately label the data set with descriptive activity names.

- Appropriately label the data set with descriptive activity names. 
- Reassigning the user friendly column names

### Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

- A new data set is created (finaldata) 
- A new data set tidydata is created wherein average of each veriable for each activity and subject is collected
- tidydata set is created using write.table(tidyData, './UCI HAR Dataset/tidyData.txt',row.names=TRUE,sep='\t'); command
- tidydata set is created in folder "UCI HAR Dataset"

### finally all df / tables are removed to free up-the memory space



