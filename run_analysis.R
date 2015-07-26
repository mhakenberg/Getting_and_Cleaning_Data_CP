##0. setting up the environment (optional)
# library(plyr);
# library(dplyr);
# setwd("My working directory")
# directory="./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test"
# lista_plikow_sciezka = list.files(path=directory,pattern="*.txt",full.names=TRUE)
# lista_plikow_nazwa = list.files(path=directory,pattern="*.txt")
# for (i in 1:length(lista_plikow_sciezka)) assign(substr(lista_plikow_nazwa[i],1,nchar(lista_plikow_nazwa[i])-4), read.table(lista_plikow_sciezka[i]))
# 
# directory="./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train"
# lista_plikow_sciezka = list.files(path=directory,pattern="*.txt",full.names=TRUE)
# lista_plikow_nazwa = list.files(path=directory,pattern="*.txt")
# for (i in 1:length(lista_plikow_sciezka)) assign(substr(lista_plikow_nazwa[i],1,nchar(lista_plikow_nazwa[i])-4), read.table(lista_plikow_sciezka[i]))
# 
# directory="./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
# activity_labels<-read.table(paste(directory,"activity_labels.txt",sep="/"), stringsAsFactors=FALSE)
# features<-read.table(paste(directory,"features.txt",sep="/"), stringsAsFactors=FALSE)

##1. Merges the training and the test sets to create one data set.
subject<-rbind(subject_train,subject_test)
subject<-rename(subject,subject.id=V1)

y<-rbind(y_train,y_test)
y<-rename(y,activity.id=V1)

X<-rbind(X_train,X_test)
names(X)<-make.unique(features[,2])

full_data_set<-cbind(subject,y,X)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
full_mean_std<-select(full_data_set,subject.id,activity.id, contains("mean()"),contains("std()"))

## 3.Uses descriptive activity names to name the activities in the data set
activity_labels<-rename(activity_labels,activity.id=V1,activity.name=V2)
full_mean_std_desc<-join(full_mean_std,activity_labels,by="activity.id",type="left")
full_mean_std_desc_v2<-select(full_mean_std_desc,subject.id,activity.name,3:ncol(full_mean_std_desc))

## 4.Appropriately labels the data set with descriptive variable names
##names(full_mean_std_desc_v2)
names(full_mean_std_desc_v2)<-tolower(gsub("\\-|\\_",".",gsub("[\\(|\\)]","",names(full_mean_std_desc_v2))))

## 5.From the data set in step 4, creates a second, independent tidy 
##   data set with the average of each variable for each activity and each subject.
grp_cols <- names(full_mean_std_desc_v2)[1:2]
dots <- lapply(grp_cols, as.symbol)

summ<-full_mean_std_desc_v2 %>%
        group_by_(.dots=dots) %>%
        summarise_each(funs(mean))

write.table(summ,file="./tidy_data_set.txt",row.names=FALSE)