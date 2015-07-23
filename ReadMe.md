---
output: html_document
---
# ReadMe: A Guide to the Files in this Repository #

*This is an R markdown file. It is easiest to read from GitHub or from RStudio. In RStudio load and click "Preview HTML."

## Directory of Files ##

- **ReadMe.md** is this file. 

- **run_analysis.R** is the R script that transforms the source data files into a single, cleaned data file, CleanedData.csv. *If you run the script, "CleanedData.csv" will appear, but may be safely ignored.*

- **NewTidyDataFile.txt** is the tidy data file of group means by activity and subject required in the project assignment. 

- **CleanedData.csv** is the cleaned data which will be produced if you run the R script. *This file is not in this repo and is not a required part of the course project. If you run the script and it appears, you may ignore it.* 

- **CodeBook.md** documents the variables in the files NewTidyData.csv and CleanedData.csv together with the steps taken by the script "run_analysis.R" to produce the csv file. A reference section is included at the end documenting the data sources.

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

The final step makes it easy to verify the success in a View() windows.

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
The script can be used without the download and extraction steps. Simply place the zip archive in R's current working directory under the filename "dataArchive.zip." Then extract the archive to that same directory. If the archive is not manually extracted before the script is run, the script will perform this step.

## No double-downloading ##
As written, the script checks to see whether the data archive exits. The archive is assumed to be named "dataArchive.zip" and must be in R's current working directory. If not, the script downloads and extracts the archive. 

If the script finds "dataArchive.zip," it checks for a subdirectory named "UCI HAR Dataset." If this subdirectory is found, the scirpt assumes the download and extraction has already been completed.

The script will break if "dataArchive.zip" and "UCI HAR Dataset" both exist, but the subdirectory does not contain the expected files in the expected location. If a problem develops, delete the subdirectory and/or the archive and let the script perform these steps.

The purpose in checking for the existence of the archive is to avoid repeated downloads once the archive has been obtained. If a repeated download is desired, simply move, rename, or delete the previous archive and re-run the script.