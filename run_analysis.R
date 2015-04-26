run_analysis <- function(){
        # get activity description df (applies to both test & train)
        activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
        
        # get column labels for setting onto measurements (for both test & train)
        feature.columns <- read.table("UCI HAR Dataset/features.txt")
        feature.column.names <- feature.columns[,2]
        
        # start with test data set
        # get test activity df 
        Y.test <- read.table("UCI HAR Dataset/test/Y_test.txt")
        # merge activity and description df's and set column names
        Y.test.activity <- merge(Y.test, activity.labels, by.x = 1, by.y = 1, all=TRUE)
        colnames(Y.test.activity) <- c("activity","activity.description")

        # get test subjects df and set column name
        subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        colnames(subject.test) <- c("subject")

        # get test measurement data
        X.test <- read.table("UCI HAR Dataset/test/X_test.txt")
        # get column labels and set onto measurements
        colnames(X.test) <- feature.column.names
        
        # bind the subject, activity and measurements into a single df
        X.test <- cbind(subject.test,Y.test.activity,X.test)

        # now do the train data set
        # get train activity df 
        Y.train <- read.table("UCI HAR Dataset/train/Y_train.txt")
        # merge activity and description df's and set column names
        Y.train.activity <- merge(Y.train, activity.labels, by.x = 1, by.y = 1, all=TRUE)
        colnames(Y.train.activity) <- c("activity","activity.description")
        
        # get train subjects df and set column name
        subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        colnames(subject.train) <- c("subject")
        
        # get train measurement data
        X.train <- read.table("UCI HAR Dataset/train/X_train.txt")
        # get column labels and set onto measurements
        colnames(X.train) <- feature.column.names
        
        # bind the subject, activity and measurements into a single df
        X.train <- cbind(subject.train,Y.train.activity,X.train)
        
        # row bind the test and train df's
        X.merged <- rbind(X.test, X.train)
        
        # using grep find columns containg "mean" and "std" 
        mean.columns <- feature.column.names[grep("-mean()", feature.column.names, ignore.case=TRUE)]
        mean.columns.names <- as.character(mean.columns)
        std.columns <- feature.column.names[grep("-std()", feature.column.names, ignore.case=TRUE)]
        std.columns.names <- as.character(std.columns)
        
        # reduce df to only the desired columns
        X.reduced <- X.merged[, c("subject", "activity", "activity.description", mean.columns.names, std.columns.names)]
        # group_by and summarise by activity (description) and subject using means for all columns
        X.summ <- X.reduced %>% group_by(activity.description, subject) %>% summarise_each(funs(mean))
        
}