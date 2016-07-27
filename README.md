# datasciencecoursera

# The code works in the following way -- 
Steps
1.first it unzips the zip file of Samsung data  
2. then using RECURIVE = TRUE in list.files functions list all the files in the folders and subfolders  
3. then it reads the test activity file , train activity file, test subject file and so on.  
4. Next it uses RBIND to bind the TEST + TRAIN data set for each of these file   
5. next it assign col names to Activity and Subjects files   
6. To assign names to features, the code uses the features.txt files to extract the col names   
7. Once the column names are assigned the code uses CBIND to create one single data set   
8. then the code uses GREP to find mean() and std() strings in the column names from the features.txt file  
9. once the list of column names with mean() and std() is retrived the Dataset is filtered based on those columns  
10. then it gets the label of Activity from the activity_label file  
11. Using factor() the Activity column in the Dataset is factorized using the activity_lable file  
12. then GSUB is used to find and replace the "t","f","Acc","Gyro","Mag","BodyBody" with more descriptive text  
13. mean for each column is calculated by Activty and Subsject by Aggregate()  
14. Write.table () is used to spit out a text file

<h1> File structure </h1>

features .txt   |   subject         |     Activity labels  <br />
                |                   |
X Test.txt      | Test subject.txt  |   Y Test Activity.txt <br />
                 |                   |
X Train.txt     | Train subsject.txt|   Y Train Activity.txt <br />
