#before starting set your working directory (File>Change dir...) and make sure all data files are located within this directory

#install this package and call into R for renaming required later in the program
install.packages("reshape")
library(reshape)

#reads into R the training set, training subject IDs, and training activities, respectively
training<-read.table("X_train.txt")
train_id<-read.table("subject_train.txt")
train_label<-read.table("y_train.txt")

#renaming the training subject ID and activities column as "id" and "activity"
train_id<-rename(train_id,c(V1="id"))
train_label<-rename(train_label,c(V1="activity"))

#binding the training activity column to the beginning of the training set
merge_train<-cbind(train_label, training)

#binding the training subject id column to beginning of the newly formed training activity+training set
merge_train2<-cbind(train_id,merge_train)

#reads into R the test set, test subject IDs, and test activities, respectively
test<-read.table("X_test.txt")
test_id<-read.table("subject_test.txt")
test_label<-read.table("y_test.txt"

#renaming the test subject ID and activities column as "id" and "activity"
test_id<-rename(test_id,c(V1="id"))
test_label<-rename(test_label,c(V1="activity"))

#binding the test activity column to the beginning of the test set
merge_test<-cbind(test_label, test)

#binding the test subject id column to beginning of the newly formed test activity+test set
merge_test2<-cbind(test_id,merge_test)

#merges the final training and test sets
full<-merge(merge_test2, merge_train2, all=T)

#reads the features file into R to get headings for the variables
headers<-read.table("features.txt")

#views features file and finds the variables corresponding to mean and standard deviation (V266 to V271)
View(headers)

#keeps variables/columns of the merged dataset that are required by assignment (activity, id, V266 - V271)
var_keep<-c("activity", "id", "V266", "V267", "V268", "V269", "V270", "V271")
full2<-full[var_keep]
View(full2)

#recodes all activities such that 1=walking, 2=walking upstairs, 3=walking downstairs, 4=sitting, 5=standing, 6=laying
full2$activity<-ifelse(full2$activity==1, "walking", full2$activity)
full2$activity<-ifelse(full2$activity==2, "walking upstairs", full2$activity)
full2$activity<-ifelse(full2$activity==3, "walking downstairs", full2$activity)
full2$activity<-ifelse(full2$activity==4, "sitting", full2$activity)
full2$activity<-ifelse(full2$activity==5, "standing", full2$activity)
full2$activity<-ifelse(full2$activity==6, "laying", full2$activity)
View(full2)

#renames remaining variables such that V266=meanx, V267=meany, V268=meanz, V269=standarddeviationx, V270=standarddeviationy, V271=standarddeviationz
full2<-rename(full2,c(V266="meanx", V267="meany", V268="meanz", V269="standarddeviationx", V270="standarddeviationy", V271="standarddeviationz"))
View(full2)

#install and call into R package dplyr for final part of assignment
install.packages("dplyr")
library(dplyr)

#averages are presented for each variable within each activity and subject id
final<-full2 %>% group_by(id,activity) %>% summarize(averagex=mean(meanx),averagey=mean(meany), averagez=mean(meanz), averagesdx=mean(standarddeviationx), averagesdy=mean(standarddeviationy), averagesdz=mean(standarddeviationz))
View(final)

write.table(final, "DataCleaning.txt", row.names=F)
