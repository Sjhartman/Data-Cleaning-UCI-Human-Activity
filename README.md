# Data-Cleaning-UCI-Human-Activity

The run_analysis.R script downloads and cleans the Human Activity Recognition data from University of California Irvine.
The script performs the following operations sequentially:
- Prob 1:
  - Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  - Open the test and training datasets
  - Open and combine the training and test labels to their respective dataset
  - Combine the new test and training datasets together using cbind
Prob 2:
  - Label the dataset columns using a vector generated from the features.txt file
  - Use select(data, matches()) to select mean and sd data from the combined data set using Regex matching
Prob 3:
  - Translate the numeric activities into their simple identities from the activity_labels.txt document
  - Add the activity labels to the combined dataset
Prob 4:
  - Read, combine and bind the Y_training.txt and X_training.txt files to the combined dataset
  - Add labels "subjectID" and "activity"
Prob 5:
  - Creates a new table that averages the mean and sd variables of the combined data table by each activity and each subject of the study. 
  - Utilizes groupby and summarize to produce TidyTable.txt that is built to fit tidy data criteria
  
  Codebook.md describes variables used in this analysis
  TidyTable.txt is the final data frame
