Step1 # Import the dplyr library
Step2 # Reading test dataset
The Samsung folder was dowloaded to the working directory
I imported X and Y Test and the subject for Test and trainning data
and Merging each datasets into a single dataframe (one for each gorup)
Then I Created the run_data binding the 2 data frames

Step3 # Using the features archive I named the collumns
OBS: some columns have the same name in the documentation, so that I joined the number of column with the name
after that I selected only the measurements on the mean and standard deviation for each measurement.

Step4 # Uses descriptive activity names to name the activities in the data set
Using the activity_labels.txt I labelled the data set with descriptive variable names.

# To make data friendlier I changed the names of variables cleaning some specifc characters as the numbers and some repetition> 

Step5 # From the data set in step 4, creates a second, independent tidy data set with the average of 
each variable for each activity and each subject Writting to file "run_data_summary.txt in the working directory
