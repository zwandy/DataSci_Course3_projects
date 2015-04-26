--------------------
ANALYSIS CODE STEPS
----------
PACKAGES
----------
1. dplyr

----------
STEP 1
----------
The UCI Har Dataset explains the following:
1. subject_test.txt contains the test subject's identifying number
2. X_test.txt contains A '561-feature vector with time and frequency domain variables'
3. y_test.txt contains the activity label
Each file contains one observation per row.

These three files are combined into a single data table by cbind.

The same is done for the training data files (subject_train.txt, X_train.txt, y_train.txt).

The two resultant datasets are then combined into one by rbind.

The file features.txt contains the column names that describes each of the 561 features of each observation. This file is used to provide the descriptive variable labels that columns 2 through 81 are renamed to.

----------
STEP 2
----------
Our dataset only needs to contain the mean and standard deviation measures for each observation.

The UCI HAR Dataset Explains that mean and standard deviation measures can be identified by the following signals.
  mean(): Mean value
  std(): Standard deviation

The merged dataset is updated to exclude any observation columns that do not contain 'mean()' or 'std()' in their label.

----------
STEP 3
----------
The UCI HAR Dataset does not descriptively name each activity performed by a subject, but assigns a number according to activity - the numbers for each activity can be found in the activity_labels.txt file.

The merged dataset is updated to replace the activity number with a descriptive name for each activity, based on the acitivty_lables.txt file. This is done by treating their activity number as a factor, and 'mutating' the merged dataset to include a new column with descriptive activity names based on activity factor number.

Columns are segmented before the mutation to ensure that the 'subject' and the new 'activity' columns remain at the front of the dataset.

----------
STEP 4
----------
The final step is to produce a second tidy data set, with a single row for each subject's activity, and the mean of each of the observation factors for that subject's activity.

This dataset is a separate text file outputed to the same working directory. The text file is named 'output.text'.



--------------------
VARIABLES (COLUMN LABELS)
----------
Each row is one 79-feature mean or standard deviation observation of one human subject performing one of six types of test or training exercises.

In the 'dataset' data frame produced by the script, there are 10299 observations of 30 subjects.

In the 'output.txt' file produced by the script, there are 180 observations.

 [1] "subject" - the unique test/training human subject number                        
 [2] "activity" - the test/training activity performed by the subject
 
From the UCI HAR Dataset features_info.txt:
"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag"

The original data set was filtered down (in STEP 2) to include only the set of variables that were estimated from the signals:
"mean(): Mean value
 std(): Standard deviation"
 
In the 'output.txt' file produced by the script, one row of the dataset contains an average of each of these variables for each subject performing one type of test or training activity.

 [3] "tBodyAcc-mean()-X"              
 [4] "tBodyAcc-mean()-Y"              
 [5] "tBodyAcc-mean()-Z"              
 [6] "tGravityAcc-mean()-X"           
 [7] "tGravityAcc-mean()-Y"           
 [8] "tGravityAcc-mean()-Z"           
 [9] "tBodyAccJerk-mean()-X"          
[10] "tBodyAccJerk-mean()-Y"          
[11] "tBodyAccJerk-mean()-Z"          
[12] "tBodyGyro-mean()-X"             
[13] "tBodyGyro-mean()-Y"             
[14] "tBodyGyro-mean()-Z"             
[15] "tBodyGyroJerk-mean()-X"         
[16] "tBodyGyroJerk-mean()-Y"         
[17] "tBodyGyroJerk-mean()-Z"         
[18] "tBodyAccMag-mean()"             
[19] "tGravityAccMag-mean()"          
[20] "tBodyAccJerkMag-mean()"         
[21] "tBodyGyroMag-mean()"            
[22] "tBodyGyroJerkMag-mean()"        
[23] "fBodyAcc-mean()-X"              
[24] "fBodyAcc-mean()-Y"              
[25] "fBodyAcc-mean()-Z"              
[26] "fBodyAcc-meanFreq()-X"          
[27] "fBodyAcc-meanFreq()-Y"          
[28] "fBodyAcc-meanFreq()-Z"          
[29] "fBodyAccJerk-mean()-X"          
[30] "fBodyAccJerk-mean()-Y"          
[31] "fBodyAccJerk-mean()-Z"          
[32] "fBodyAccJerk-meanFreq()-X"      
[33] "fBodyAccJerk-meanFreq()-Y"      
[34] "fBodyAccJerk-meanFreq()-Z"      
[35] "fBodyGyro-mean()-X"             
[36] "fBodyGyro-mean()-Y"             
[37] "fBodyGyro-mean()-Z"             
[38] "fBodyGyro-meanFreq()-X"         
[39] "fBodyGyro-meanFreq()-Y"         
[40] "fBodyGyro-meanFreq()-Z"         
[41] "fBodyAccMag-mean()"             
[42] "fBodyAccMag-meanFreq()"         
[43] "fBodyBodyAccJerkMag-mean()"     
[44] "fBodyBodyAccJerkMag-meanFreq()" 
[45] "fBodyBodyGyroMag-mean()"        
[46] "fBodyBodyGyroMag-meanFreq()"    
[47] "fBodyBodyGyroJerkMag-mean()"    
[48] "fBodyBodyGyroJerkMag-meanFreq()"
[49] "tBodyAcc-std()-X"               
[50] "tBodyAcc-std()-Y"               
[51] "tBodyAcc-std()-Z"               
[52] "tGravityAcc-std()-X"            
[53] "tGravityAcc-std()-Y"            
[54] "tGravityAcc-std()-Z"            
[55] "tBodyAccJerk-std()-X"           
[56] "tBodyAccJerk-std()-Y"           
[57] "tBodyAccJerk-std()-Z"           
[58] "tBodyGyro-std()-X"              
[59] "tBodyGyro-std()-Y"              
[60] "tBodyGyro-std()-Z"              
[61] "tBodyGyroJerk-std()-X"          
[62] "tBodyGyroJerk-std()-Y"          
[63] "tBodyGyroJerk-std()-Z"          
[64] "tBodyAccMag-std()"              
[65] "tGravityAccMag-std()"           
[66] "tBodyAccJerkMag-std()"          
[67] "tBodyGyroMag-std()"             
[68] "tBodyGyroJerkMag-std()"         
[69] "fBodyAcc-std()-X"               
[70] "fBodyAcc-std()-Y"               
[71] "fBodyAcc-std()-Z"               
[72] "fBodyAccJerk-std()-X"           
[73] "fBodyAccJerk-std()-Y"           
[74] "fBodyAccJerk-std()-Z"           
[75] "fBodyGyro-std()-X"              
[76] "fBodyGyro-std()-Y"              
[77] "fBodyGyro-std()-Z"              
[78] "fBodyAccMag-std()"              
[79] "fBodyBodyAccJerkMag-std()"      
[80] "fBodyBodyGyroMag-std()"         
[81] "fBodyBodyGyroJerkMag-std()" 
