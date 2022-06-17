setwd(".\\")
##1. read the txt files.
data_train <- read.table(".\\UCI HAR Dataset\\train\\x_train.txt")
data_test <-read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
Feature <- read.table(".\\UCI HAR Dataset\\features.txt")$V2

##2. embedding labels and files.
names(data_test) <- Feature
names(data_train) <- Feature
data <- rbind.data.frame(data_test,data_train)
data_train <- data.frame()
data_test <- data.frame()

##3. extracting only mean and std
label_data <- names(data)
mean_colnum <- grep("-mean[()]",label_data)
std_colnum <- grep("-std[()]",label_data)
mean <- data[,mean_colnum]
std <- data[,std_colnum]

##4. give a new list of variables

if(!identical(substr(names(mean),start = 1,stop = 9),
              substr(names(std),start = 1,stop = 9))){
  stop("Feature Title Does not Match")
}
label_meanstd <- names(mean)
time <- grep("^t",label_meanstd)
FFT <-grep("^f",label_meanstd)
for(i in time){
  
}


