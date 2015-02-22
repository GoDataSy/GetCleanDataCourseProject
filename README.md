# GetCleanDataCourseProject
####Instructions for running run_analysis.R script
This script assumes the reshape2 package is installed. If not, the following line should be uncommented before run_analysis() is run.

install.packages("reshape2")

####Instructions for loading tidydata.txt
tidydata.txt file can be read into R using read.table(header=TRUE)

####A Description of the HAR Experiments
The HAR study conductors describe the study as follows:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

####How the run_analysis.R Script Works
Files used from the HAR study include:
- 'train/y_train.txt': Training labels. Each row identifies an activity performed for each window sample. Its range is from 1 to 6.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/X_train.txt': Training set which contains the measurements derived from the accelerator and gyroscope signals
- 'test/y_test.txt': Test labels. Each row identifies an activity performed for each window sample. Its range is from 1 to 6.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set which contains the measurements derived from the accelerator and gyroscope signals
- 'features.txt': List of all features. These are the measurement names.
- 'activity_labels.txt': Links the class labels with their activity name.

The script:

Merges the training and the test sets to create one data set.
* a. The y_train.txt and subject_train.txt datasets are read into R and named "data.train.activities" and "data.train.subjects", respectively; and are assigned the column names "activity" and subject", resp.  		
* b. The X_train.txt is read into R and named "data.train.measures"  
* c. The "data.train.activities", "data.train.subjects" and "data.train.measures" data sets are column-bound to form one data set.
* d-f. In the same way as above, the corresponding "test" datasets are combined to form a data set.
* g. The training and test are combined to form one dataset using rbind().
* h. Names from features.txt file are applied to the measurements columns 

Extracts only the measurements on the mean and standard deviation for each measurement. 
* a. Columns whose names contain the following character strings are extracted: "activity", "subject", "mean", "std"
* b. From the above list, column whose names  contain "angle" at the beginning are dropped
* c. The resulting data set is named "data.mean.std" 

Uses descriptive activity names to name the activities in the data set. 
Lowercase descriptive names are assigned to the activities in the data set by making the activity variable a factor and assigning identifying labels (walking, walkingup, walkingdown, sitting, standing, laying)

Appropriately labels the data set with descriptive variable names. 
The column names are stripped of dashes, commas, and parentheses; and are made lowercase. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* a. The dataset is transformed (melted) so that four columns are created:
*   activity: the activity column
*   subject: the subject column
*   measure: Each row identifies a measurement (feature) for a sampled activity and subject.
*   value: Each row holds the measure's value for a given activity, subject and window sample. 
* b. The data set is transformed again (casted) so that a mean for each measure is created for each activity-subject combination. The measure names are now included in the column names again.

The data set is written to a file named "tidydata.txt" and placed in the user's working directory.