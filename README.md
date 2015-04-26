# getting_and_cleaning_data
Repo for the course project

Following is an outline of the run_analysis.R script.
This script merges the two data files X_test.txt and X_train.txt and also attaches the necessary column names and activity (w/ description) and subject.

The features.txt file is used to set the column names.
The subject_test.txt and subject_train.txt files are used to attach the subject(numbers)
The Y_test.txt and Y_train.txt are used to attached the activities with the activity_labels.txt used to provide meaningful descriptions.  Note that features.txt and activity_labels.txt are common to both sets of measurements and are read only once.

All of this is used to build a "merged" df (X.merged)

Once the data is concatenated and column names specified then the mean & std columns are extracted (along with the subject, activity/description) by using "grep".  This produces a "reduced" df. (X.reduced)

Finally, the data is grouped and summarised. (X.summ)
