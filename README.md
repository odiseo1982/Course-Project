# Course-Project
Repository for the course project on getting and cleaning data course

This README file describes the code in run_analysis.R.

First, the code define the working directory, which has to be changed according to the location of the data in your computer. The first step is reading all the data that will be used in the project through the command read.table(). Then, labels are added to variables using the command colnames(). After, activities codes are complemented with activities names through the command merge(), without options. Finally, subject and info are added to the features data set using the cbind() command.

For point 1., train and test data sets are added through the rbind() command.

For point 2., variables containing mean(), Mean or dts() in its labels are selected. This is done throguh the grep() command. The resulting dataset also have subject and activities variables.

Point 3. is already done because activities names have already been included in the data set.

For point 4., '-', '()', '(', ')', ',' are eliminated from variable names. Also the first t is removed from the name of most variables and the first f is replaced by fourier, to make explicit these variables have been transformed. Finally, variable names are converted to lowercase.

For point 5., the result is obtained through the aggregate() command.

Now, the code book:

* Each row represents the mean of 73 features, for a given subject and activity.
* Subject: number assigned to each subject.
* Activity: name of the activity measured for each individual.
* The rest of the variables as in features_info.txt, taking into account the modifications described before in point 4.
