---
title: "Getting and Cleaning Data: Project CodeBook"
author: "Alan Ault"
date: "26 October 2014"
output: html_document
---

This is a codebook describing the data and transformations for the course project for the Coursera Getting and Cleaning Data Project.

It describes 3 elements:

1. Variables in the data set
2. The data itself
3. Outline of the transformations used to clean the data and generate the code



### Background

The data for this project is experimental data collected from the accelerometers from a Samsung Galaxy S smartphone.

A full description of the data is available here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data itself can be downloaded from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data has a number of important aspects:

* broken into test and training sets
* based on observations from 30 test subjects
* covering 6 different activities
        + Walking
        + Walking upstairs
        + Walking downstairs
        + Sitting
        + Standing
        + Laying
* Data from the accelerometers comprised 561 variables, across a number of different aspects including frequency, acceleration in different axis etc

The raw data comes with a comprehensive set of readme and description fields and the reader should examine these for further detail on the original data.


### The Tidy data and transformations used to derive it

The tidy data set is derived from the various tables and simplifies and combines the data.

It comprises of 180 rows across 68 variables

### Key transforms and process

1. Full list of variable names was added to the test and training as column names
2. Subject id's were added to test/train as a new column 
3. This was used to merge with the subject table so we had a clear description of each activity
4. Variables were filters to exclude everything other than those for mean and standard deviation
5. The variables were changed from abbreviations to more descriptive titles. e.g. facc means frequencyaccelerometer
6. Data was then grouped and summarised to provide the mean of each activity for each variable for each subject
7. Table is written out as a file for later use


### Variable descriptions

The 68 variables are as follows:

* activity: text description of the activity the subject was doing as above
* subject: subject number, from 1:30

The rest of the variables come from the accelerometers and follow the following naming convention:

* start of variable name:
        + time: time-based measurements
        + frequency: observations in Hz
* angle type:
        + body or gravity, depending on angle in original dataset
* data source type:
        + accelerometer
        + gyroscope
* summary data type:
        + mean
        + standard deviation
* axis:
        + either x, y or z axis
        
        






