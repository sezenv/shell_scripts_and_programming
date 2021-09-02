ml anaconda3
source activate /hpc/users/username/.conda/envs/ML_builder
target=$1
DIR=$2
FOLDER=$3
ID=$4
precision=$5
model_building_dir=$6
input_features=$7
mkdir -p $model_building_dir/${target}_${ID}_DT_output
cd $model_building_dir/${target}_${ID}_DT_output
python ${DIR}/myscript.py -id ${target} -pid ${ID} -pre ${precision} -d $model_building_dir -f ${input_features} -m 'DT' -rand 42 -p

#To submit this .sh file, it use the command below:
#bsub -J jobname -P acc_name -q premium -n 5 -W 120:00 -R rusage[mem=1200000] -R himem -o jobname_%J.stdout -eo jobname_%J.stderr -L /bin/bash "source sample_job_submission_file.sh $target $DIR $FOLDER $ID $precision $model_building_dir $input_features"