################################################
# Coursera: Getting & Cleaning data
# Course project: Alan Ault
# 15 Oct 2014
##################################################


# packages
library (stringr)
library (dplyr)
library (reshape2)


# set directories
trainDir <- "../train/"
testDir <- "../test/"




#############################################################
# Task 1: Merge test and training data sets; load labels
#############################################################

# First, load data

# load activity labels - these are the factor mappings for y data
activities <- read.table ("activity_labels.txt")
# give nice column names
names (activities) <- c("id", "activity")

# load features (variable names)
features <- read.table ("features.txt")
names (features) <- c("id", "feature")
# Training data
setwd (trainDir)
subject_train <- read.table (file="subject_train.txt")
x_train <- read.table (file="X_train.txt")
y_train <- read.table (file="y_train.txt")
# test data
setwd (testDir)
subject_test <- read.table (file="subject_test.txt")
x_test <- read.table (file="X_test.txt")
y_test <- read.table (file="y_test.txt")





# Merge X and Y values with activities and variable names
# Before we merge train and test we need to combine our
# data into a single set of observations

# Could make a function, but only doing twice, so easier
# just to do line by line

# Lets add the variable names to both data sets before we start merging
names (x_train) <- features$feature
names (x_test) <- features$feature


# Now, add the subject onto each dataset
# Just a single vector with values 1:30 depending on subject who did the test
train <- cbind (subject_train, x_train)
names (train) [1] <- "subject" # give it a useful name
test <- cbind (subject_test, x_test)
names (test) [1] <- "subject"

# second, add the y class variables onto the x values
# Y values are, in effect the labels
train <- cbind (y_train, train)
test <- cbind (y_test, test)
# change column name otherwise we have x2 V1 after merge
names (train) [1] <- "id"
names (test) [1] <- "id"

# now merge to add the activity labels
train <- merge (activities, train, by="id")
test <- merge (activities, test, by="id")

# now we can merge train and test into a single dataset
data <- rbind (train, test)






#############################################################
# Task 2; extracts only the measurements on mean and stDev
#############################################################

# we can do this by grep'ing for occurences of
# std =  standard deviation
# mean = mean in the labels
# Then we can subset by this
# Need to include activity and subject or we lose them
data <- data [ , grep( "std|mean|activity|subject", names (data)) ]


# we now need to lose the meanFreq value as we don't want it
# and it gets picked up by the previous search
# Do this as an exclude (-) rather than include
data <- data [ , -(grep ("Freq", names (data)))]




#############################################################
# Task 3: use descriptive activity names  for the activities
#############################################################

# This has already been taken care of earlier, when we merged
# the id field with the activities.txt field



###########################################################################
# Task 4: appropriately label the data set with descriptive variable names
###########################################################################

# Current variable names are technical and confusing, like fBodyBodyGyroMag-mean
# We need to replace these with names which more clearly describe what they represent, as well as lose junk

# Rules are:
# 1. all lower case
# 2. descriptive, not abbreviated
# 3. no underscores, dots or white spaces

# we're going to use the stringr library for ease of use

# first, lets replace f and t at the start with frequency
# use ^ to show they're at the start
names (data) <- gsub ("^f", "frequency", names (data))
names (data) <- gsub ("^t", "time", names (data))

# now we need to turn all into lower case
names (data) <- tolower (names (data))

# Now we need to replace all the abbreviated terms with full version
# lets use stringr package...
# e.g. gyro = gyroscope and acc = accelorometer
names (data) <- str_replace (names (data), "gyro", "gyroscope")
names (data) <- str_replace (names (data), "acc", "accelerometer")
names (data) <- str_replace (names (data), "mag", "magnitude")
names (data) <- str_replace (names (data), "std", "standarddeviation")

# we're going to lose the "()" in each string
# Using stringr package for ease of use

# need to escape the () with a \\
names (data) <- str_replace (names (data), "\\(\\)", "")

# finally, lets lose the  hypen
names (data) <- str_replace_all (names (data), "-", "")





############################################################################################
# Task 5: create a tidy data set with average of each variable for each activty and subject
###########################################################################################


# Easiest way to do this is with Dplyr summarisation
# First we group by the factors we want to keep (activity and subject)
# then we summarise across each row with a mean

# We can use the neat %>% pipe function to save lines of code
tidyData <- data %>%
        group_by (activity, subject) %>%
        summarise_each (funs(mean))

# when we do dim (tidyData), we get the same columns and 180 rows
# This is right as we get the same measurements and 6 activities * 30 subjects = 180 rows



# finally, we need to output a table to upload for marking
write.table (tidyData, file="tidyData.txt", row.names=FALSE)





