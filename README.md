**Step 1**
Download and unzip the following archive into your working directory: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


**Step 2**
Run run_analysis.R with R Studio. The script reads all data sets from UCI HAR Dataset folder which you have unzip in Step 1. The aggregated data is write to a file named indepedent_set.txt.


**Actions performed in run_analysis.R script** 

1. Data from all data sets had been merged into a one dataset
2. The merged dataset are further filtered by means and standard deviations to form the smaller subset of data
3. Label the data set with descriptive variable names
4. Substitute activity labels with its respective activity name
5. Aggregation is conducted on each variable. The aggregated results are stored in a text file/


