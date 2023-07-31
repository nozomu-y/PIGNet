#!/bin/bash
#$ -cwd
#$ -l s_core=1
#$ -l h_rt=12:00:00
#$ -N DOWNLOAD_TRAIN_DATA
#$ -o eo_file
#$ -e eo_file

source /home/8/18B15885/.bashrc
conda activate pignet
conda list

./download_train_data.sh
