---
output: html_document
---
# ReadMe: A Guide to the Files in this Repository #

*This is an R markdown file. It is easiest to read from RStudio: load and click "Preview HTML," or open the HTML version of this file.

## Directory of Files ##

- **ReadMe.md** is this file. (If you opened the HTML version, you are reading the file below).

- **ReadMe.html** HTML version of this file. 

- **run_analysis.R** is the R script that transforms the source data files into a single, cleaned data file, CleanedData.csv. *If you run the script, "CleanedData.csv" will appear, but may be safely ignored.*

- **NewTidyDataFile.csv** is the tidy data file of group means by activity and subject required in the project assignment. 

- **CleanedData.csv** is the cleaned data which will be produced if you run the R script. *This file is not a required part of the course project and may be ignored by the reader.* 

- **CodeBook.md** documents the variables in the files NewTidyData.csv and CleanedData.csv together with the steps taken by the script "run_analysis.R" to produce the csv file. A reference section is included at the end documenting the data sources.

* Please note: The .md files, while legible, are not conveniently human readable. Reading through RStudio's "Preveiw HTML" function or opening the HTML versions of the files is recommended.

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