## Download the zip archive and extract to local directory
##    Check for previous download and extraction before performing these steps.
##    This saves time and we don't want to unnecessarily pound on the server.

if(!file.exists("dataArchive.zip")) {
    message("Data archive not found, downloading and expanding archive ...")
    theUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(theUrl, destfile="dataArchive.zip", mode="wb")
    unzip("dataArchive.zip")
} else { 
    message("Data archive exists, skipping download ...")
    if(!file.exists("UCI HAR Dataset")) {
        unzip("dataArchive.zip")
    } else {
        message("Data folder exists, skipping extraction step ...")
    }
}

## Read the files in the TEST subdirectory
    x_test_df <- read.table("./UCI HAR Dataset/test/x_test.txt")
    y_test_df <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subject_test_df <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Read the files in the TRAIN subdirectory
    x_train_df <- read.table("./UCI HAR Dataset/train/x_train.txt")
    y_train_df <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_train_df <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Join like test and train files together. Put all the data in the TEST data frames.
    x_test_df <- rbind(x_test_df, x_train_df)
    y_test_df <- rbind(y_test_df, y_train_df)
    subject_test_df <- rbind(subject_test_df, subject_train_df)

## We are done with the TRAIN files, so delete them.
    rm(x_train_df, y_train_df, subject_train_df)

   ## read the features file; these data are the variable identifiers and eventual col names
   ##    The second column of the table are the variable/column names. Extract them to a vector.
    features_df <- read.table("./UCI HAR Dataset/features.txt", sep=" ", colClasses="character")
    col_names <- as.vector(features_df[,2])
   ## Attach the column names now. This is useful if we need to do script debugging.
    colnames(x_test_df) <- col_names
	
   ## Determine which column names have "mean" or "std" as a substring.
   ##    Note: We are searching on strings but storing indices (i.e. integers)
    mean_cols <- grep("mean", col_names, ignore.case=TRUE)
    std_cols <- grep("std", col_names, ignore.case=TRUE)
   ## Combine, remove duplicates, and sort in order. 
   ##     The result is the subset of column indices we want to keep.
    select_cols <- sort(unique(c(mean_cols, std_cols)))
	
   ## Now subset the data frames with the index vector constructed above. 
    x_test_df <- x_test_df[select_cols]
	
   ## Read the columnS of activities from the test & train directories & join
    y_test_df  <- read.table("./UCI HAR Dataset/test/y_test.txt")
    y_train_df <- read.table("./UCI HAR Dataset/train/y_train.txt")
    y_test_df  <- rbind(y_test_df, y_train_df)
    rm(y_train_df)
    
   ## Read the table that translates activity numbers (1..6) to descriptive strings.
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
   ## The underscore "_" character will be troublesome later. So remove it now,
   ##   Eliminate the first column too; it just contains the indices 1, 2, ...
    activity_labels <- sub("_", "", activity_labels$V2)

   ## Now feed the vector of activities (integers) through the activity label column.
   ##   The integers act as row selectors, neatly translating indices to strings.
   ##   This creates our column of strings describing the activity of each observation.
    activity_col <- activity_labels[as.vector(y_test_df[,1])]
	rm(y_test_df)
	
   ## Create the vector of subjects that each row in the table represents.
    subject_col <- as.vector(subject_test_df)
    rm(subject_test_df)
    
   ## Assemble columns to be pre-pended to the data frame constructed above.
    prepend_cols <- data.frame(Subject=subject_col, Activity=activity_col)
   ## Attach names to these columns. It saves naming them after the large
   ##   data frame is constructed--columns come with names this way.
    colnames(prepend_cols) <- c("Subject", "Activity")
	
   ## Attach these left-most columns to the larger data frame.
    allTheData <- cbind(prepend_cols, x_test_df)
    rm(x_test_df)
    write.csv(allTheData, "./CleanedData.csv")

## Clean-up the workspace. Remove intermediate variables we don't need anymore.
    rm(activity_col, activity_labels, col_names, features_df, mean_cols)
    rm(prepend_cols, select_cols, std_cols, subject_col)

## Now create the tidy data set described in the CodeBook.md file.
##   First split the dataFrame by activity and subject
    splitData <- split(allTheData, f=list(allTheData$Activity,allTheData$Subject))
    
    ##   Then get the column means for each combination of factors
    ##      Omit the first two columns means; these are the factor variables
    ##      used to split the data. 
    theNewTidyData <- lapply(splitData, function (x) colMeans(x[,-c(1,2)]))
    theNewTidyData <- as.data.frame(theNewTidyData)
    theNewTidyData <- t(theNewTidyData)##   transpose, so that variables correspond to columns.
    rm(splitData)

    ## This gives us the column means by activity and subject
    ## Unfortunately, the activity and subject are together in a single column
    ## e.g. Walking.1, Walking.2 ... Sitting.1, etc.
    ## We need to represent what is now in the row names in two columns: activity and subject.
    
    ## Need a new column containing names we can separate
    theRowNames <- rownames(theNewTidyData)
    theNewTidyData <- cbind(activity.subject=as.data.frame(theRowNames), as.data.frame(theNewTidyData))
    rm(theRowNames)
    
    ## Now do the separation. Silently load dplyr and tidyr packages first.
    suppressPackageStartupMessages(library(dplyr))
    suppressPackageStartupMessages(library(tidyr))
    theNewTidyData <- separate(theNewTidyData, col=theRowNames, into=c("activity", "subject"))
    
    ## switch subjects to numeric so that they sort as expected, then sort the data frame
    theNewTidyData$subject <- as.numeric(theNewTidyData$subject)
    theNewTidyData <- arrange(theNewTidyData, activity, subject)
    
    ## still have the old column names. Modify to identify the variables as group means.
    col_names <- colnames(theNewTidyData)
    col_names[3:length(col_names)] <- paste0("GrpMean",col_names[3:length(col_names)])
    colnames(theNewTidyData) <- col_names; rm(col_names)
    ##write.csv(theNewTidyData, "./NewTidyDataFile.csv")
    write.table(theNewTidyData, "./NewTidyDataFile.txt", row.name=FALSE)
    View(theNewTidyData)
    