run_analysis <- function(){
                  
#         install.packages("reshape2")

        library(reshape2)

        # Merge training and test sets to create one data set
        file.train.activities <- "./UCI HAR Dataset/train/y_train.txt"
        file.train.subjects <- "./UCI HAR Dataset/train/subject_train.txt"
        file.train.measures <- "./UCI HAR Dataset/train/X_train.txt"        

        data.train.activities <- read.table(file.train.activities)
        colnames(data.train.activities) <- "activity"
                
        data.train.subjects <- read.table(file.train.subjects)
        colnames(data.train.subjects) <- "subject"
        
        data.train.measures <- read.table(file.train.measures)
        
        data.train <- cbind(data.train.activities, data.train.subjects, data.train.measures)
 
             
        file.test.activities <- "./UCI HAR Dataset/test/y_test.txt"        
        file.test.subjects <- "./UCI HAR Dataset/test/subject_test.txt"
        file.test.measures <- "./UCI HAR Dataset/test/X_test.txt"
        
        data.test.activities <- read.table(file.test.activities)
        colnames(data.test.activities) <- "activity"
        
        data.test.subjects <- read.table(file.test.subjects)
        colnames(data.test.subjects) <- "subject"
        
        data.test.measures <- read.table(file.test.measures)
        
        data.test <- cbind(data.test.activities, data.test.subjects, data.test.measures)
        
        data <- rbind(data.train, data.test)

        # Apply feature column names to data set
        file.features <- "./UCI HAR Dataset/features.txt"          
        features <- read.table(file.features)        
        names(data)[3:length(names(data))] <- as.character(features$V2) 
        
        # Extract mean and std measures
        data.mean.std <- data[,grep("activity|subject|mean|std", names(data), ignore.case = TRUE)]
        data.mean.std <- data.mean.std[,-grep("^angle", names(data.mean.std), ignore.case = TRUE)]
        names(data.mean.std)
        
        #Use descriptive activity to name the activities in data set
        data.mean.std$activity <- 
                factor(data.mean.std$activity, 
                       labels=c("walking","walkingup","walkingdown","sitting","standing","laying"),
                       ordered=TRUE)
        
        # Appropriately labels the data set with with lowercase descriptive variable names
        names(data.mean.std) <- gsub("-|,|\\(|\\)","", names(data.mean.std))
        names(data.mean.std) <- tolower(names(data.mean.std))        
        
        # Create tidy dataset with average (mean) of each variable for each activity and each subject 
        data.mean.std.melted <- melt(data.mean.std, id.vars = c("activity", "subject"),variable.name="measure", value.name="value")
        data.mean.std.casted <- dcast(data.mean.std.melted, activity + subject ~ measure, mean)
        
        # write data set to a text named tidydata.txt
        write.table(data.mean.std.casted, file = "./tidydata.txt", row.names = FALSE)

}