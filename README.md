Coursera-Getting-and-Cleaning-Data
==================================

Final assignment for Coursera: Getting and Cleaning Data course

HOW THE SCRIPT WORKS:

1. Before starting set your working directory (File>Change dir...) and make sure all data files are located within this directory

2. Install the "reshape" package and call this library to R (library(reshape))

3. Read into R the training set, training subject IDs, and training activities using read.table() and assign each to a new variable:



training<-read.table("X_train.txt")

train_id<-read.table("subject_train.txt")

train_label<-read.table("y_train.txt")



4. Rename the training subject ID and activities column as "id" and "activity" using rename():



train_id<-rename(train_id,c(V1="id"))

train_label<-rename(train_label,c(V1="activity"))



5. Bind the training activity column to the beginning of the training set using cbind():



merge_train<-cbind(train_label, training)



6. Bind the training subject id column to beginning of the newly formed training activity+training set using cbind():



merge_train2<-cbind(train_id,merge_train)



7. Read into R the test set, test subject IDs, and test activities using read.table() and assign each to a new variable:



test<-read.table("X_test.txt")

test_id<-read.table("subject_test.txt")

test_label<-read.table("y_test.txt"



8. Rename the test subject ID and activities column as "id" and "activity" using rename():



test_id<-rename(test_id,c(V1="id"))

test_label<-rename(test_label,c(V1="activity"))



9. Bind the test activity column to the beginning of the test set using cbind():



merge_test<-cbind(test_label, test)



10. Bind the test subject id column to beginning of the newly formed test activity+test set using cbind():



merge_test2<-cbind(test_id,merge_test)



11. Merge the final training and test sets that were just created using merge():



full<-merge(merge_test2, merge_train2, all=T)



12. Read the features file into R to get headings for the variables using read.tables():



headers<-read.table("features.txt")



13. View features file and find the variables corresponding to mean and standard deviation (V266 to V271) - according to the discussion board, these 6 variables are the only ones required for mean and standard deviation:



View(headers)



14. Keep only the variables/columns of the merged dataset that are required by assignment (activity, id, V266 - V271):



var_keep<-c("activity", "id", "V266", "V267", "V268", "V269", "V270", "V271")

full2<-full[var_keep]
View(full2)



15. Recode all activities such that 1=walking, 2=walking upstairs, 3=walking downstairs, 4=sitting, 5=standing, 6=laying using ifelse():



full2$activity<-ifelse(full2$activity==1, "walking", full2$activity)

full2$activity<-ifelse(full2$activity==2, "walking upstairs", full2$activity)

full2$activity<-ifelse(full2$activity==3, "walking downstairs", full2$activity)

full2$activity<-ifelse(full2$activity==4, "sitting", full2$activity)

full2$activity<-ifelse(full2$activity==5, "standing", full2$activity)

full2$activity<-ifelse(full2$activity==6, "laying", full2$activity)

View(full2)



16. Rename remaining variables such that V266=meanx, V267=meany, V268=meanz, V269=standarddeviationx, V270=standarddeviationy, V271=standarddeviationz using rename():



full2<-rename(full2,c(V266="meanx", V267="meany", V268="meanz", V269="standarddeviationx", V270="standarddeviationy", V271="standarddeviationz"))
View(full2)



17. Install the "dplyr" package and call this library to R (library(dplyr)) to complete part 5 of assignment



18. Present averages for each variable within each activity and subject id using dplyr() and chaining:



final<-full2 %>% group_by(id,activity) %>% summarize(averagex=mean(meanx),averagey=mean(meany), averagez=mean(meanz), averagesdx=mean(standarddeviationx), averagesdy=mean(standarddeviationy), averagesdz=mean(standarddeviationz))
View(final)



19. Export final tidy data as txt file:



write.table(final, "DataCleaning.txt", row.names=F)



CODEBOOK/DATA DICTIONARY:

id
   
   Subject ID
      
      1..30

activity
 
   Activities performed while wearing Smartphone
  
      walking
  
      walking upstairs
  
      walking downstairs
  
      sitting
  
      standing
  
      laying



averagex
  
   Average of means of the fast fourier transform of body acceleration signal in X-axial
    
      -1..1
    


averagey
  
   Average of means of the fast fourier transform of body acceleration signal in Y-axial
    
      -1..1
    


averagez
  
   Average of means of the fast fourier transform of body acceleration signal in Z-axial
    
      -1..1



averagesdx
  
   Average of standard deviations of the fast fourier transform of body acceleration signal in X-axial
    
      -1..1



averagesdy
  
   Average of standard deviations of the fast fourier transform of body acceleration signal in Y-axial
    
      -1..1



averagesdz
  
   Average of standard deviations of the fast fourier transform of body acceleration signal in Z-axial
    
      -1..1




