---
title: "CodeBook: Getting and Cleaning Data"
author: "Jim v.M."
date: "February 22, 2015"
output: html_document
---

# Study Design

The following study design is a *paraphrased* version of the one in the reference at the end of this section.

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

"Finally, all features were normalized and bounded within [-1,1].

"The features (variables 3 to 68) selected for this database come from the accelerometer and gyroscope 3-axial raw signals time.Acc-XYZ and time.Gyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (time.BodyAcc-XYZ and time.GravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

"Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time.BodyAccJerk-XYZ and time.BodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (time.BodyAccMag, time.GravityAccMag, time.BodyAccJerkMag, time.BodyGyroMag, time.BodyGyroJerkMag). 

"Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency.BodyAcc-XYZ, frequency.BodyAccJerk-XYZ, frequency.BodyGyro-XYZ, frequency.BodyAccJerkMag, frequency.BodyGyroMag, frequency.BodyGyroJerkMag.

"These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. 

Reference: [www.smartlab.ws URL to original datafiles, ReadMe & variable information]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") 

# Raw Data

The raw data files are taken from:  [www.smartlab.ws]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"). The merged raw data contains 10299 observations on 563 variables in total.

# Tidying the Raw Data

By running the R script `run_analysis.R`, the raw data is tidied in the following steps: 

  1. Relevant files are downloaded.
  2. Files are unzipped into the *current* working directory.
  3. Data files are loaded into R (version 3.1.2) through `read.table()`.
  4. Subject, outcome and feature variables are merged.
  5. Train and test data are merged.
  6. Descriptive and readable variable names are added as headers.
  7. Variables subsetted (selected) on the condition that they
  contain measurements on mean or standard deviation, or are 
  subject or outcome variables.
  8. Descriptive variable labels added to the `activity` variable.
  9. Using `tbl_df{dplyr}` the table is converted into a `tbl`.
  10. For each indiviual and each activity observations in the
  table are aggregated via `mean` to produce a final tidy `data.frame`.
  11. The tidy `data.frame` is saved in the current working directory
  as `tidy_table.txt`.
  12. The working environment is restored to its state before running
  `run_analysis.R`.

The resulting data.frame is now in wide tidy format as described in [Tidy Data (pdf warning)]("http://vita.had.co.nz/papers/tidy-data.pdf"). (Steps 1 and 2 are only carried out if the files are **not** already in the working directory.)

# Code Book of the Tidy Data

The tidy data.frame contains 180 observations on 68 variables.

## First Two Variables

- variable name: subject  
  -- type: categorical 
    - value range: 1,2,..,30  
- variable name: activity  
  -- type: categorical 
    - value range:   
        1. STANDING          
        2. SITTING           
        3. LAYING            
        4. WALKING           
        5. WALKING_DOWNSTAIRS
        6. WALKING_UPSTAIRS  

## Variables Three to Sixty-eight

The remainder of the variables are numeric (continuous) measurements in Hertz (Hz) normalized to fall into the interval [-1,1]. Because of this normalization (the values of) these variables are unitless.

These variables come in the following regular format: 

<_domain_>.<_measurement type_>.<_statistic_>.<_direction of movement_>

The component ranges are as follows:  

  1. <_domain_>: time, frequency.
  2. <_measurement type_>: BodyAcc, GravityAcc, ..., BodyBodyGyroJerkMag. 
  3. <_statistic_>: mean, std, meanFreq.
  4. <_direction_>: <_none_>, X, Y, Z.

For example, frequency.BodyAcc.std.Z stands for the average standard error of the "body acceleration" measurement in the Z direction in the frequency domain (of a certain individual during a certain activity).

All sixty-eight measurement variables are listed below: 

time.BodyAcc.mean.X                   
time.BodyAcc.mean.Y                   
time.BodyAcc.mean.Z                   
time.BodyAcc.std.X                    
time.BodyAcc.std.Y                    
time.BodyAcc.std.Z                    
time.GravityAcc.mean.X                
time.GravityAcc.mean.Y                
time.GravityAcc.mean.Z                
time.GravityAcc.std.X                 
time.GravityAcc.std.Y                 
time.GravityAcc.std.Z                 
time.BodyAccJerk.mean.X               
time.BodyAccJerk.mean.Y               
time.BodyAccJerk.mean.Z               
time.BodyAccJerk.std.X                
time.BodyAccJerk.std.Y                
time.BodyAccJerk.std.Z                
time.BodyGyro.mean.X                  
time.BodyGyro.mean.Y                  
time.BodyGyro.mean.Z                  
time.BodyGyro.std.X                   
time.BodyGyro.std.Y                   
time.BodyGyro.std.Z               
time.BodyGyroJerk.mean.X              
time.BodyGyroJerk.mean.Y              
time.BodyGyroJerk.mean.Z              
time.BodyGyroJerk.std.X               
time.BodyGyroJerk.std.Y               
time.BodyGyroJerk.std.Z               
time.BodyAccMag.mean                  
time.BodyAccMag.std                
time.GravityAccMag.mean               
time.GravityAccMag.std                
time.BodyAccJerkMag.mean              
time.BodyAccJerkMag.std               
time.BodyGyroMag.mean                 
time.BodyGyroMag.std              
time.BodyGyroJerkMag.mean             
time.BodyGyroJerkMag.std              
frequency.BodyAcc.mean.X              
frequency.BodyAcc.mean.Y              
frequency.BodyAcc.mean.Z              
frequency.BodyAcc.meanFreq.X          
frequency.BodyAcc.meanFreq.Y          
frequency.BodyAcc.meanFreq.Z          
frequency.BodyAccJerk.mean.X          
frequency.BodyAccJerk.mean.Y          
frequency.BodyAccJerk.mean.Z          
frequency.BodyAccJerk.meanFreq.X      
frequency.BodyAccJerk.meanFreq.Y      
frequency.BodyAccJerk.meanFreq.Z       
frequency.BodyGyro.mean.X             
frequency.BodyGyro.mean.Y             
frequency.BodyGyro.mean.Z             
frequency.BodyGyro.meanFreq.X         
frequency.BodyGyro.meanFreq.Y         
frequency.BodyGyro.meanFreq.Z  
frequency.BodyAccMag.mean           
frequency.BodyAccMag.meanFreq     
frequency.BodyBodyAccJerkMag.mean   
frequency.BodyBodyAccJerkMag.meanFreq  
frequency.BodyBodyGyroMag.mean       
frequency.BodyBodyGyroMag.meanFreq     
frequency.BodyBodyGyroJerkMag.mean  
frequency.BodyBodyGyroJerkMag.meanFreq 
