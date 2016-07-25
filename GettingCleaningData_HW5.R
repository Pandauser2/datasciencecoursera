
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile ="UCI_DATA.zip")

path <- file.path(getwd(),"UCI HAR Dataset")
files <- list.files(path,recursive = FALSE) # ONLY TOP LEVEL
files <- list.files(path,recursive = TRUE)  #files within files -- everything basically

# Readiing Test Activity 
TestActivity  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)

#Reading Train Activity
ATrainctivity <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)


TrainSub <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
TestSub  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)


TestFeatr <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
TrainFeatr <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

features <- read.table(file.path(path,"features.txt"))

# join the rows 
Activity <- rbind(TrainActivity, TestActivity)

Subjects <- rbind(TrainSub,TestSub)

FeaturesVal <- rbind(TrainFeatr, TestFeatr)

# add variable names

fn <- features[,2]
names(Activity) <- ("Activity")
names(Subjects) <- ("Subjects")
names(FeaturesVal) <- fn


## feature , subjet , activity -- column bind

comb <- cbind(Subjects,Activity)

CombDataset <- cbind(FeaturesVal,comb)


## extracts only the "Mean()"" and "STD()"

Y <-  grep("mean\\(\\)|std\\(\\)",features$V2)

Subfeature <- features$V2[Y]
Subfeature <- as.character(Subfeature)  # need to convert from factor to character ; could have used dplyr and select() but got lazy

Subset <- CombDataset[,c(Subfeature,"Subjects","Activity")]

# Activyt labels
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING


desc <- read.table(file.path(path,"activity_labels.txt"))

# factorizing the Activity col which is numeric to a factor and apply the labels from desc 

Subset$Activity <- factor(Subset$Activity ,labels =desc$V2)  #sorts and assigns labels

## Apply descriptive variable names to the features column names 


names(Subset) <- gsub("^t","time",names(Subset)) #1.replace t with time

names(Subset) <- gsub("^f","frequency",names(Subset)) # 2. replace f with frequency

names(Subset) <- gsub("Gyro","Gryoscope",names(Subset))  #3. replace Gyro with Gyroscope

names(Subset) <- gsub("Acc","Accelerometer",names(Subset)) #4. replace Acc with Acceleratomer 

names(Subset) <- gsub("BodyBody","Body",names(Subset)) #5 replace bodybody with body

names(Subset) <- gsub("Mag","Magnitude",names(Subset)) #6 replace mag with magnitude

## subset with mean for each variable by Activity and Subject 

AggrSubset <- aggregate(.~Activity + Subjects,Subset, FUN= mean)

write.table(AggrSubset,"FinalTidayset.txt",row.names=FALSE)


