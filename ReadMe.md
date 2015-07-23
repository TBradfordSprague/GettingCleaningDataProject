---
output: html_document
---
# ReadMe: A Guide to the Files and Scripts in this Repository #

*This is an R markdown file. It is easiest to read from GitHub or from RStudio. In RStudio load and click "Preview HTML."

## Directory of Files ##

- **ReadMe.md** is this file. 

- **run_analysis.R** is the R script that transforms the source data files into a single, cleaned data file, CleanedData.csv, and also creates a new tidy data file of group means, named NewTidyDataFile.txt. *If you run the script, "CleanedData.csv" will appear, but may be safely ignored.* For further analysis of the data, however, it would likely be useful.

- **NewTidyDataFile.txt** is the tidy data file of group means by activity and subject required in the project assignment. 

- **CleanedData.csv** is the cleaned data which will be produced if you run the R script. *This file is not in this repo and is not a required part of the course project. If you run the script and it appears, you may ignore it.* 

- **CodeBook.md** documents the variables in the files NewTidyData.csv and CleanedData.csv together with the steps taken by the script "run_analysis.R" to produce the csv file and NewTidyDataFile.txt. A reference section is included at the end documenting the data sources.

* Please note: The .md files, while legible, are not conveniently human readable. Reading through GitHub or RStudio's "Preveiw HTML" function is recommended.

# What Does the Script run_analysis.R Do? #
===========================================
A more detailed outline of the analysis may be found in the file CodeBook.md. 

The details of commands in the script are thoroughly documented by comments in the script itself. The outline in this file is intended as the briefest possible summary. 

The script run_analysis.R:

1. Downloads and extracts the data archive to the current working directory. This step is skipped if the data are already present.

2. Combines “test” and “train” data into a single file.

3. Relevant columns are selected 
	a. “Column/variable names are extracted from the file “features.txt”
	b. Only variables with names containing  “mean” or “std” are retained.
	c. The subject and activity columns are pre-pended to the rest of the data. 
	d. Activity numbers are translated to descriptive strings. 

4. Creates a second, independent tidy data set which averages each 
   variable for each activity and each subject.
	a. Split the data frame according to activity and subject 
	b. Compute column means for each of the sub-lists. 
	c. Join the lists back as a single data frame.
	d. Add a column for activity.subject (e.g. SITTING.1, WALKING.3)
	e. Tidy the data by separating activity and subject variables. 
	f. Sort rows by activity first, then subject. 

The final step makes it easy to verify the success in a View() window.

## Running the Script on Mac or Linux ##

The script should work for all platforms, **except for the downloading step.**

I am told the solution is to search for the line 

    download.file(theUrl, destfile="dataArchive.zip", mode="wb") 

and modify to 

    download.file(theUrl, destfile="dataArchive.zip", mode="wb", method = "Curl")
    
Since I program on Windows 7, I cannot verify this solution. Presumably Mac and Linux programmers know the details of downloading files on their platforms.

##Data Sources ##

These data were obtained from the following file specifically stored for the Coursera course, “Getting and Cleaning Data.” Here is a link to the original file from the course.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data is available at the site from which the data was originally obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Codes and Features ##

The variables (called “features” in the original context) are documented in the file CodeBook.md. We briefly note here that the cleaned data file produced by the script references only those variables involving mean and standard deviation of measured and estimated quantities. 

<h1> Running the Script </h1>

The included script file, run_analysis.R, can be run from any directory. It will download the zip file (if not already present) from the Coursera server, expand the zip archive, and run the tasks on the newly downloaded files. 

The download and extraction steps may be easily avoided.

## Avoiding the download and extraction ##
The script can be used without the download and extraction steps. Simply place the extracted data from the archive in a subdirectory **of R's current working directory** named **"UCI HAR Dataset"**. The script will find the directory and assume it contains the necessary data. Extracting the downloaded archive from the R command line, "unzip("getdata_projectfiles_UCI HAR Dataset.zip")", will produce exactly this subdirectory. 

Extracting from Windows Explorer by default creates the subdirectory "getdata_projectfiles_UCI HAR Dataset" which in turn contains the subdirectory "UCI HAR Dataset." It *is* inconvenient, but easy to work around. Simply move the "UCI HAR Dataset" subdirectory up to R's current working directory and delete the now empty parent. The script will then find the data and avoid the download and extraction.

## No double-downloading ##
Since the script checks to see whether the data subdirectory exists, it will not download the data twice if downloading was successful. It will not extract twice if extraction is successful.
