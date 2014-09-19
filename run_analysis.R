## This R code file contains code for the course project - Getting and Cleaning the data
## Submission of project includes following files
## [1] run_analysis.R
## [2] README.md
## [3] codebook.md

## submission is in lines with following requirement mentioned in coure project
## 1. tidy data set
## 2. link to github repository with script
## 3. code book

##########################################################################################

## I have writting entire code in a function called project(). This function needs to be called from
## command line, and there are not parameters to be passed

## since this single code accomplished multiple tasks, there are print commands inserted at every stage
## these print commands keeps posting status update on command window 

project <- function (){
        
        ## command line status update
        print ("1: Code execution started. Inside function project()")        
        
        ## data from text files are being read into a dataframes
        Features = read.table('./UCI HAR Dataset/features.txt',header=FALSE);
        AType = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE); 
        
        ## training data are being imporated in  the dataframes
        STrain = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
        xTrain = read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE); 
        yTrain = read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); 
        
        
        ## Assiging user friendly column names
        colnames(AType)  = c('activityId','activityType');
        colnames(STrain) = "subjectId";
        colnames(xTrain) = Features[,2]; 
        colnames(yTrain) = "activityId";
 
        
        ## merge all training files to create consolidated training set
        trainingData = cbind(yTrain,STrain,xTrain);
       
        ## command line status update
        print ("2: consolidated training set successfully created")   
        
##-------------------------------------------------------------------

        ## test data are being imported in the data frames
        STest = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); #imports subject_test.txt
        xTest = read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE); #imports x_test.txt
        yTest = read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); #imports y_test.txt
        
        ## Assiging user friendly column names
        colnames(STest) = "subjectId";
        colnames(xTest) = Features[,2]; 
        colnames(yTest) = "activityId";

        
        ## merge all training files to create consolidated training set
        testData = cbind(yTest,STest,xTest);
        
        ## command line status update
        print ("3. consolidated test set successfully created")   

##---------------------------------------------------------------------------
        
        # creat final Data set by column binding training and test data
        finalData = rbind(trainingData,testData);
                
        ## command line status update
        print ("4. training and test data succesfully binded")   
        print ("TASK 1: successfully accomplished")
##----------------------------------------------------------

        print ("5: TASK 2: started")
        
        # Extract only the measurements on the mean and standard deviation for each measurement
        # Creating a vector for the column names
        colNames  = colnames(finalData); 
        logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
        finalData = finalData[logicalVector==TRUE];

        print("TASK 2: successfully accomplished")
##--------------------------------------------------------
        
        print("TASK 3: started")
        
        ## Use descriptive activity names to name the activities in the data set
        ## Merging the finalData set with the AType 
        finalData = merge(finalData,AType,by='activityId',all.x=TRUE);
        ## Updating the colNames vector
        colNames  = colnames(finalData); 

        print("TASK 3: successfully accomplished")
##--------------------------------------------------------

        print("TASK 4: started")
        
        ## Appropriately label the data set with descriptive activity names. 
        
        
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
        
        # Reassigning the user friendly column names
        colnames(finalData) = colNames;

        print("TASK 4: successfully accomplished")
##--------------------------------------------------------

        print("TASK 5: started")
        
        ## Create a second, independent tidy data set with the average of each variable 
        ## for each activity and each subject. 
        
        ## Creating new table without the activityType column
        finalData  = finalData[,names(finalData) != 'activityType'];
        
        ## including just the mean of each variable for each activity and each subject
        tidyData    = aggregate(finalData[,names(finalData) != c('activityId','subjectId')],by=list(activityId=finalData$activityId,subjectId = finalData$subjectId),mean);
        
        ## Merging tidyData with activityType (includes descriptive acitvity names)
        tidyData    = merge(tidyData,AType,by='activityId',all.x=TRUE);
        
        ## Export tidyData
        write.table(tidyData, './UCI HAR Dataset/tidyData.txt',row.names=TRUE,sep='\t');

        print ("TASK 5: successfully accomplished")        
##-----------------------------------------------------                
        print("removing the data frames to free memory")
        rm(Features, AType, STrain, xTrain, yTrain )
        
}