#!/bin/bash

SCORING_DIR=pdbbind_v2020/scoring
DOCKING_DIR=pdbbind_v2020/docking
RANDOM_DIR=pdbbind_v2020/random
CROSS_DIR=pdbbind_v2020/cross

mkdir -p $SCORING_DIR
mkdir -p $DOCKING_DIR
mkdir -p $RANDOM_DIR
mkdir -p $CROSS_DIR

# scoring
wget https://zenodo.org/record/8091220/files/PDBbind-v2020_scoring.tar.xz?download=1 -O $SCORING_DIR/data.tar.xz
cd $SCORING_DIR
tar -xzf data.tar.gz
../../generate_keys.py -d data -k keys -c ../../coreset_keys.txt --train
../../pdb_to_affinity.py -d data -f pdb_to_affinity.txt -i ../../INDEX_refined_data.2020
cd -
echo "Downloaded, unpacked and processed pdbbind v2020 scoring data."

# docking
wget https://zenodo.org/record/8091220/files/PDBbind-v2020_docking.tar.xz?download=1 -O $DOCKING_DIR/data.tar.xz
cd $DOCKING_DIR
tar -xzf data.tar.gz
../../generate_keys.py -d data -k keys -c ../../coreset_keys.txt --train
../../pdb_to_affinity.py -d data -f pdb_to_affinity.txt -i ../../INDEX_refined_data.2020
cd -
echo "Downloaded, unpacked and processed pdbbind v2020 docking data."

# random screening
wget https://zenodo.org/record/8091220/files/PDBbind-v2020_random.tar.xz?download=1 -O $RANDOM_DIR/data.tar.xz
cd $RANDOM_DIR
tar -xzf data.tar.gz
../../generate_keys.py -d data -k keys -c ../../coreset_keys.txt --train
../../pdb_to_affinity.py -d data -f pdb_to_affinity.txt -i ../../INDEX_refined_data.2020 --screening
cd -
echo "Downloaded, unpacked and processed pdbbind v2020 random screening data."

# cross screening
wget https://zenodo.org/record/8091220/files/PDBbind-v2020_cross.tar.xz?download=1 -O $CROSS_DIR/data.tar.xz
cd $CROSS_DIR
tar -xzf data.tar.gz
../../generate_keys.py -d data -k keys -c ../../coreset_keys.txt --train
../../pdb_to_affinity.py -d data -f pdb_to_affinity.txt -i ../../INDEX_refined_data.2020 --screening
cd -
echo "Downloaded, unpacked and processed pdbbind v2020 random screening data."
