Cleaning Data code book
========================================================

Introduction
--------------------------------------------------------
The file run_analysis.R can be used to analyze the source files as obtained from the URL [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The source data was created by using data test subjects wearing smartphones and logging all the movements for. By videotaping the subjects it was possible to link each movement made by the test subjects to exact measurements from the smartphones. 

Analysis
--------------------------------------------------------
The goal of the analysis is to combine the source datasets and to link each measurement with an activity. After this the data is filtered to only have the data related to the mean and standard deviation.  
Finally it is required to create a dataset with a mean of the mean and standard deviation per subject, activity and the measurements. 

Packages
--------------------------------------------------------
The following packages are required to run the file:
* reshape2
* plyr

Workflow
--------------------------------------------------------
1. Read the source files that contain the measurement data. The results are stored in the variables *x.test.observations* and *x.train.observations*.
2. The two source datasets are combined into a single data frame called *observations*.
3. The labels for the activities are read from the source file into the variable *features*.
4. The *features* dataframe is processed to extract the mean and standard deviation columns, the boolean values for these columns are assigned to the variable *means.stds*.
5. The *observations* are filtered to only include the columns that contain the means and stds, new variable *observations.means.stds*. 
6. The subjects files, `subject_test.txt` and `subject_train.txt`, are combined with the activity files, `y_test.txt` and `y_train.txt`, to create a dataframe that identifies each row against an activity and subject. The result of this combined the the activity labels as defined in the file `activity_labels.txt`. The result is stored in the variable *subject.activity*.
7. The *subject.activity* and *observations.means.stds* are binded by column to obtain a dataframe where each observation is combined the the subject and the activity. Stored in the data.frame *combined.data*. 
8. Use **melt** and **ddply** functions to create a data.frame with the mean value for each subject and activity. 
9. Write an output file called `tidy_data.txt`.




