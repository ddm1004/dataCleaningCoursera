# Code Book

## Data

The data used in this project comes from sensor data from the accelerometers of Samsung Galaxy S smartphones.  Full details on the original data is available here:

 * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

While the run_analysis.R script will fetch the data, the data used in this processing is available here:

 * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Original Data Set Information

The following information is directly from the UCI website and the included README.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Features per record

 * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
 * Triaxial Angular velocity from the gyroscope.
 * A 561-feature vector wtih the timed and frequency domain variables.
 * Its activity label.
 * An identifier of the subject who carried out the experiment.

### Dataset included files:

 * __README.txt__
 * __features_info.txt__: Information about the variables used on the feature vector.
 * __activity_labels.txt__: Links the class labesl with their activity name.
 * __train/X_train.txt__: Training set.
 * __train/y_train.txt__: Training labels.
 * __test/X_test.txt__: Test set.
 * __test/y_test.txt__: Test labels

The following files are available for the train and test data.  Their descriptions are equivalent.

 * __train/subject_train.txt__: Each row identifies the subject who performed the activity for each window sample.  Its range is from 1 to 30.
 * __train/Inertial Signals/total_acc_x_train.txt__: The acceleration signal from the smartphone accelerometer X axis in standard gravity units _g_. Every row shows a 128 element vector.  The same description applies for the _total_acc_y_train.txt_ and _total_acc_z_train.txt_ files for the Y and Z axis.
 * __train/Inertial Signals/body_acc_x_train.txt__: The body acceleration signal obttained by subtracting the gravity from the total acceleration.
 * __train/Inertial Signals/body_gyro_x_train.txt__: The angular velocity vector measured by the gyroscope for each window sample.  The units are radians/second.

### Notes
 * Features are normalized and bounded within [-1,1]
 * Each feature vector is a row on the text fiel.

## Processing

All processing is done in the run_analysis.R script.  

It begins by determining if the data is present, and if not getting the data.

The data is then read into R.

Next a combined data set combining the training and testing data is generates a new data set, label set, and subject set.

Then the columns containing means and standard deviations are selected and the rest of the columns are discarded

After this, the columns names are moved to all lower case and the periods are removed to provide consistant formatting and easier typing of column names.

The data is then melted into a new table, in whcih the sensor columns are combined into two columns, one for the sensor name and another for the reading.

Finally, the melted data and the sensor mean data is written out to csv files so that the data can be used in either via further R processing or via other processing mechanisms.

The sensor mean data is also written to a text file.
## Variables

Two key variables exist at teh end of processing, along with several intermediate variables. 

### Intermediate variables
 * __X__: This represents the combined training and test data.  The test data is first, followed by the training data.  Only columns containing mean and standard deviation values are contained.  There are 86 columns, all representing sensor readings.  All readings are normalized to [-1,1].  Units depend on the measurement being used.  All measurements begining with t and containing Acc are normalized distance/time^2.  All measurements begining with t and continaing Gyro are normalied radians/second.  All measurements begining with f represent the fourier transform of the time domain signal.  
 * __y__: Combined test and training labels.  Test labels are first.  Data is all one of the following: SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.
 * __subj__: combined test and training subject labels.  Test labels are first. 
 * __tidy_data__: Data from that combines the activity, subject, and sensor readings.  All sensor names are all lower case with periods removed from the data to simplify access to the columns.

### Final Variables
  * __melt_data__: There are 88 columns, subject, activity, and the sensor names.  The subject and activity columns are taken directly from the data set, with the subject being a number and the activity being one of LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, or WALKING_UPSTAIRS.  The sensor columns represents the values read from the sensor.  Units are the same as _X_
 * __sensor_means__: There are also 88 columns.  The first two are the same as _melt_data_, while the remainder are the mean reading of the given sensor for the given individual and activity. 

## Output Files

Three files are output from the script, sensor_means.txt, tidy_data.csv and sensor_means.csv.

 *__tidy_data.csv__: There are four columns, subject, activity, sensor, and reading.  The subject and activity columns are taken directly from the data set, with the subject being a number and the activity being one of LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, or WALKING_UPSTAIRS.  The sensor column represents the sensor that is being read, while the reading column represents the sensor value read.  Units are 

In sensor_means.csv, there are 
 * __sensor_means.csv__: There are also four columns.  The first three are the same as _melt_data_, while the fourth is the mean reading of the given sensor for the given individual and activity. 
