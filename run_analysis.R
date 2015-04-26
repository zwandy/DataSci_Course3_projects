run_analysis <- function(){
  
  ##STEP 1: combine all test and training files into one data frame
  ##Test files
  test_subs <- read.table("UCI Har Dataset/test/subject_test.txt")
  test_x <- read.table("UCI Har Dataset/test/X_test.txt")
  test_y <- read.table("UCI Har Dataset/test/y_test.txt")
  ##Train files
  train_subs <- read.table("UCI Har Dataset/train/subject_train.txt")
  train_x <- read.table("UCI Har Dataset/train/X_train.txt")
  train_y <- read.table("UCI Har Dataset/train/y_train.txt")
  ##561 feature (x files column) names
  features <- read.table("UCI HAR Dataset/features.txt")
  ##combine and apply feature (column) names
  dataset <- combineFiles(test_subs, test_x, test_y, train_subs, train_x, train_y, features)
  
  ##STEP 2: extract only the measures for mean and standard deviation
  ##        measures, excluding all other features of each observation
  dataset <- extractMeansStds(dataset)
  
  ##STEP 3: replace the datasets activity numbers with descriptive
  ##activity names
  datas <- actNames(dataset)
  dataset <<- datas

  ##STEP 4: produce a second tidy database of the means of each feature of
  ##each activity for each subject
  dataset2 <- genFile(datas)
  write.table(dataset2, file="output.txt", row.names=FALSE)
  
}


combineFiles <- function(tests, testx, testy, trains, trainx, trainy, fnames){
  testm <- cbind(tests, testy)
  testm <- cbind(testm, testx)
  trainm <- cbind(trains, trainy)
  trainm <- cbind(trainm, trainx)
  mergeData <- rbind(testm, trainm)
  
  f <- as.character(fnames$V2) ##pull vector of names
  ##assign the names to the merged dataset
  names(mergeData) <- c('subject', 'activity', f)
  
  mergeData
}


extractMeansStds <- function(dataset){
  ##separating the data into 3 chunks - subject/activity, means, stds
  data.subjAct <- dataset[,c(1:2)]
  data.means <- dataset[,grep("mean", colnames(dataset))]
  data.stds <- dataset[,grep("std", colnames(dataset))]
  
  ##recombine the extracted data
  mergeData <- cbind(data.subjAct, data.means)
  mergeData <- cbind(mergeData,data.stds)
  
  ##data arranged by order of subject identification number
  mergeData <- arrange(mergeData, subject, activity)
  
  mergeData
}


actNames <- function(dataset){
  data.subjAct <- dataset[,c(1:2)]
  data.features <- dataset[-c(1:2)]
  
  data.subjAct <- rename(data.subjAct, actnum=activity)
  data.subjAct <- mutate(data.subjAct, activity=factor(actnum, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")))
  data.subjAct$actnum <- NULL
  mergeData <- cbind(data.subjAct, data.features)
}

genFile <- function(dataset){
    ##initializing a data frame with the correct number and name of cols
    mergeData <- dataset[200,]
  
    subjects <- nrow(as.data.frame(table(dataset$subject)))
    
    i <- 1
    while (i <= subjects){
      ##print(i)
      df <- filter(dataset, subject==i)
      
      activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
      
      j <- 1
      while (j <= 6){
        ##print(activities[j])
        df2 <- filter(df, activity==activities[j])
          if (nrow(df2)!=0){
            cols <- colMeans(df2[-c(1:2)])
            newline <- c(i, activities[j], cols)
            mergeData <- rbind(mergeData, newline)
          }
        j <- j+1
      }
      
      i <- i+1
    }

    mergeData <- mergeData[-1,]
    row.names(mergeData) <- NULL
    mergeData
}