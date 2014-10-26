Getting_data_project
====================

This is the project data for the Getting and Cleaning Data Project

Comprises the following 3 files:

1. CodeBook.md

Docmuent describing the data, the transforms and variables of the data itself

2. README.md

This document

3. run_analysis.R

The code used to undertake the transformation and cleaning of the data





The code takes the input data (from a an experiment recording accelorometer and gyprscopic data from a smartphone) and cleans/combines. In particular the following transformations happen:

1. Combines training and test data into a single data set
2. Labels the variables and observations with subject and activity information
3. Tidies the variable names such that they're easy to read descriptors of the measurement
4. Filters to only include the mean and standard deviation metrics
5. Summarises the data by activity, subject and variable
6. Writes to an output data.table
