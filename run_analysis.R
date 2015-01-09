### Getting and Cleaning Data Course Project

## Setting working directory
setwd('C:/Users/nsuarez/Desktop/coursera/UCI HAR Dataset')

## Reading data
activity_labels = read.table('activity_labels.txt')
features = read.table('features.txt')
subject_train = read.table('./train/subject_train.txt')
X_train = read.table('./train/X_train.txt')
y_train = read.table('./train/y_train.txt')
subject_test = read.table('./test/subject_test.txt')
X_test = read.table('./test/X_test.txt')
y_test = read.table('./test/y_test.txt')

## Adding labels to data
colnames(X_train) = features[,2]
colnames(y_train) = 'activity'
colnames(subject_train) = 'subject'
colnames(X_test) = features[,2]
colnames(y_test) = 'activity'
colnames(subject_test) = 'subject'
colnames(activity_labels) = c('activity','activity_name')

## Adding activities labels to activities
y_train = merge(y_train,activity_labels)
y_test = merge(y_test,activity_labels)

## Adding subject and activities to features data
data_train = cbind(subject_train,y_train,X_train)
data_test = cbind(subject_test,y_test,X_test)

## 1. Merges the training and the test sets to create one data set
data = rbind(data_train,data_test)
head(data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
data = data[,c(1:3,grep('mean()',colnames(data),fixed = T),grep('Mean',colnames(data),fixed = T),
               grep('std()',colnames(data),fixed = T))]
head(data)

## 3. Uses descriptive activity names to name the activities in the data set
# Already done, from the title: Adding activities labels to activities

## 4. Appropriately labels the data set with descriptive variable names
colnames(data) = sub('tBody','body',colnames(data))
colnames(data) = sub('tGravity','gravity',colnames(data))
colnames(data) = sub('fBody','fourierBody',colnames(data))
colnames(data) = gsub('-','',colnames(data))
colnames(data) = sub('()','',colnames(data),fixed = T)
colnames(data) = sub('(','',colnames(data),fixed = T)
colnames(data) = sub(')','',colnames(data),fixed = T)
colnames(data) = sub(',','',colnames(data),fixed = T)
colnames(data) = tolower(names(data))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject
final = aggregate(data[,-(1:3)],list(Subject = data$subject,Activity = data$activity_name),mean)
final = arrange(final,Subject,Activity)

## Exporting data
write.table(final,'tidy_data_set.txt',row.name = F)
