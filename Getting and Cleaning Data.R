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
data_time <- data.frame(matrix(ncol=0,nrow=nrow(data)))
data_FFT <- data.frame(matrix(ncol=0,nrow=nrow(data)))
for(i in time){
  data_time[[names(mean)[i]]] <- mean[,i]
  data_time[[names(std[i])]] <- std[,i]
}
for(i in FFT){
  data_FFT[[names(mean)[i]]] <- mean[,i]
  data_FFT[[names(std[i])]] <- std[,i]
}

##5. rename
names_time <- names(data_time)
names_FFT <- names(data_FFT)
names_time <- sub("^t","time.",names_time)
names_FFT <- sub("^f","FFT.",names_FFT)
originalsign <- c("Body","Gravity","Acc","Gyro","Jerk","Mag","-mean[()]","-std[()]","[(]","[)]")
replacemsign <- c("Body.","Gravity.","Accelerometer.","Angular-velocity.","Jerk-signals.","Magnitude.",
                  "mean.","std-dev.","","")
for(i in 1:length(originalsign)){
  if(length(grep(originalsign[i],names_time))!=0){
    names_time <- sub(originalsign[i],replacemsign[i],names_time)
  }
  if(length(grep(originalsign[i],names_FFT))!=0){
    names_FFT <- sub(originalsign[i],replacemsign[i],names_FFT)
  }
}

names(data_time) <- names_time
names(data_FFT) <- names_FFT

##6.Output
data2 <- cbind.data.frame(data_time,data_FFT)
write.csv(x = data2,file = "tidy_data.csv")
## XLSX with two sheets
install.packages("openxlsx")
library(openxlsx)
xlsxsheet <- list("Time"=data_time,"Fast Fourier Transform"=data_FFT)
write.xlsx(xlsxsheet,file="tidy_data.xlsx")



