packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# read label & get features
activity_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("class_labels", "activity_name"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("index", "feature_names"))
features_wanted <- grep("(mean|std)\\(\\)", features[, feature_names])
m <- features[features_wanted, feature_names]
m <- gsub('[()]', '', m)

# load train
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_wanted, with = FALSE]
data.table::setnames(train, colnames(train), m)
train_activities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
train_subjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("Subject_Num"))
train <- cbind(train_subjects, train_activities, train)

# load test
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_wanted, with = FALSE]
data.table::setnames(test, colnames(test), m)
test_activities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
test_subjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("Subject_Num"))
test <- cbind(test_subjects, test_activities, test)

# merge train & test
combined <- rbind(train, test)

# convert class_labels to activity_name
combined[["Activity"]] <- factor(combined[, Activity], levels = activity_labels[["class_labels"]], labels = activity_labels[["activity_name"]])

combined[["Subject_Num"]] <- as.factor(combined[, Subject_Num])
combined <- reshape2::melt(data = combined, id = c("Subject_Num", "Activity"))
combined <- reshape2::dcast(data = combined, Subject_Num + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "tidy_data.txt", quote = FALSE)
