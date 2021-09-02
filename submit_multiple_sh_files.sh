#!/bin/bash
#This bash script submits multiple bash scripts by extracting them from the existing folders
#Before the first usage, make it executable using the linux command below:
#$ chmod ugo+rwx submit_multiple_jobs.sh
#To stay in the same shell run it with the command below:
#$ source ugo+rwx submit_multiple_jobs.sh
DIR=/path/to/directory
cd $DIR
target="mytarget"
for FOLDER in $(find . -type d -name "${target}_pattern1"); do
        for FOLDER1 in $(find $FOLDER -type d -name "*pattern2"); do
                folder_name="$(basename $FOLDER1)"
                ID="$(echo $folder_name | awk -F'[_]' '{print $3}')"
                bsub -J "${target}_${ID}_pattern3" -P acc_myaccount -q premium -n 1 -W 2:00 -o ${target}_${ID}_pattern3_%J.stdout -eo ${target}_${ID}_pattern3_%J.stderr -L /bin/bash "source /path/to/directory/input_bash_file.sh $target $DIR $FOLDER $ID"
                sleep 1 # wait 1 second between each job submission
        done
done
