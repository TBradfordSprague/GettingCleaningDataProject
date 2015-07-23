# Code Book #
=============

# How to Run the Script #
==========================
Note: For easier reading, read from GitHub or load this file into RStudio and click "Preview HTML." 

Place the script in R's current working directory and "source"" it with R.

- If a "UCI HAR Dataset" subdirectory is in the working directory, the download and zip extraction step will be skipped.

- If the zip archive is stored in "DataArchive.zip" or "getdata_projectfiles_UCI HAR Dataset" in the working directory, the download will be skipped.

- These "skips"" reduce time and load on the server if the script is run multiple times. 

- Downloading and unzipping were not required for the project, but these steps make clear the source of the data and solve problems related to location and names of data files. If not found, they will simply be created in a predictable way. See the next section for how to avoid downloading and extracting the archive.

# What Does the Script Do? #
========================
The details of how each step is performed are thoroughly documented in the comments in the script itself. This outline is intended as an overview and summary of the strategy used.
The script file performs the following steps:

1. Downloads and extracts the data archive to the current working directory
	a. Download and extraction skipped if a "UCI HAR Dataset" subdirectory exists.
	b. Downloading is skipped if the data archive exists exists in the working directory.

2. Combines “test” and “train” data. E.g. subject_test and subject_train are concatenated in the single file, subject_test.

3. Relevant columns are selected 
	a. “Features” (column/variable names) are extracted from the file “features.txt”
	b. Features with substring “mean” or “std” are identified by index, using grep commands.
	c. The resulting indices form the list of columns to be selected. These are stored in the vector “select_cols”.
	d. “select_cols” is used to select the columns from the original tables and to select the corresponding features for use as column names.
	e. The subject and activity columns constructed from “subject_test.txt”, “y-test.txt”, and corresponding train files, are pre-pended to the rest of the data. Activities are translated from indices (1..6) to descriptive strings. 

4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	a. Split the data frame according to activity and subject 
	b. Compute column means for each of the sub-lists. 
	c. Join the lists back as a single data frame.
	d. Add a column for activity.subject (e.g. SITTING.1, WALKING.3)
	e. Tidy the data by separating activity and subject variables. 
	f. Sort rows by activity first, then subject. 

The final step makes it easy to verify the success in a View() windows.

# Are the Data Structures Tidy? #
================================

The tables created conform to Wickham's standards (see [Wickham] in references below):

    1. Each variable forms a column.
    2. Each observation forms a row.
    3. Each type of observational unit forms a table.

The class discussion forums discuss tidy data and identify this format as the 
**wide form of tidy data.** 

       https://class.coursera.org/getdata-030/forum/thread?thread_id=107
       https://class.coursera.org/getdata-030/forum/thread?thread_id=204 


# Variables, Feature Selection, and Units of Measure #
=====================================================

	## A Note On Units ##
	-----------------------------------------------------------------

	*From the README.txt file of the original archive:
	“Features are normalized and bounded within [-1,1].”*
	<end-quote>

	**Consequently, the measures do not correspond to any particular
       units. However, they are all consistent, and so retain usefulness
       for comparison to each other within the dataset.**
	-------------------------------------------------------------------

The variables of the new tidy data set relabeled by prepending the string “GrpMean” to indicate that these are group means. e.g. tBodyAcc-XYZ becomes GrpMeantBodyAcc-XYZ to indicate the group mean of the indicated subject and activity for total body acceleration along X, Y, and Z axes. 

The translation of each variable name is exactly the same as for the original variables, except that GrpMean indicates a group mean for a single combination of activity and subject. Which ones are indicated by the “subject” and “activity” variables in the tidy data set. 

A single codebook for both the combined/cleaned data and the new tidy group mean data is thus possible, as the only distinction in variable names is whether or not GrpMean has been prepended (indicating a group mean and that the variable belongs to the new tidy data set).

The remainder of this section is mostly a repetition of information from the file features-info.txt from the data archive referenced in the ReadMe.txt. It allows one to identify the measurement/estimate reflected in each column of the data tables.

See also the references section at the end of this document.

** There are important changes, however, as a number of the variables in the original archived have been “selected out.” These are noted below.**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

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
	fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

	mean(): Mean value
	std(): Standard deviation


Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

Note: These variables are retained by the script, since they involve means.
	gravityMean
	tBodyAccMean
	tBodyAccJerkMean
	tBodyGyroMean
	tBodyGyroJerkMean


## Variables Removed by the run_analysis.R script ##
===============================================
The following variables are in the original files, but are removed by the script. They are documented here only for completeness.

	mad(): Median absolute deviation 
	max(): Largest value in array
	min(): Smallest value in array
	sma(): Signal magnitude area
	energy(): Energy measure. Sum of the squares divided by the number of values. 
	iqr(): Interquartile range 
	entropy(): Signal entropy
	arCoeff(): Autorregresion coefficients with Burg order equal to 4
	correlation(): correlation coefficient between two signals
	maxInds(): index of the frequency component with largest magnitude
	meanFreq(): Weighted average of the frequency components to obtain a mean frequency
	skewness(): skewness of the frequency domain signal 
	kurtosis(): kurtosis of the frequency domain signal 
	bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
	angle(): Angle between to vectors.


The complete list of variables from the original files of each feature vector is available in 'features.txt'

## References and Notes ##
==========================
The standards for tidy data are due to Hadley Wickham.
[Wickham] http://vita.had.co.nz/papers/tidy-data.pdf

The data were originally obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The zip archive for this project was obtained from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For more information about this dataset contact: activityrecognition@smartlab.ws

## License: ##
========
The following license statement was provided with the original data.

    Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
    
    [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
    
    This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
    
    Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
