# Cleans up and summarises mean and standard deviation data from the data obtained from the
#"Human Activity Recognition Using Smartphones Data Set": http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

getAndCleanUCIData <- function() {
    ## First Read from the train observation set. This data has spaces for separators so the
    ## default separator will work.
    trainObs <- read.table("./UCI HAR Dataset/train/X_train.txt")
    ## Now read the variable names - these labels apply to both the train and test data sets.
    ## The lables are also in a space separated format. The first column is simply the column index 
    ## we are not interested in, the second column is the variable name.
    variables <- read.table("./UCI HAR Dataset/features.txt")
    ## Make sure we have legal column names so that R and dplyr don't complain.
    validColNames <- make.names(names=variables[,2], unique=TRUE, allow_ = TRUE)
    # set the variable names for the training observations to the variables read from features.txt
    colnames(trainObs) <- validColNames
    ## We only want the mean and standrad deviation columns.
    trainObs <- trainObs[,grepl("mean",colnames(trainObs)) | grepl("std",colnames(trainObs)) ]
    ##Read the activities for this set
    activities <- read.table("./UCI HAR Dataset/train/y_train.txt")
    ##Add the new activity as a new variable.
    trainObs <- mutate(trainObs,activity=activities$V1)
    ##Read the activity Labels
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    ##Merge in the activityLabels
    trainObs <- merge(trainObs,activityLabels,by.x="activity",by.y="V1")
    ##Read the subject data
    subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    ##Add the subject as a new variable
    trainObs <- mutate(trainObs,subject=subjects$V1)
    
    
}