#!/bin/bash  

#VARS:
# -PROJ_DIR: current dir were code is located
# -DATASET_DIR: where dataset is stored.
# -FILE: path to file that contains the list of images we want to process.
# Each lin in the file is path_image1, path_image2,name, space separated.
# The full path is give by DATASET_DIR/path_imageX
# the name, instead, will be used to name the output file.

PROJ_DIR=$PWD
DATASET_DIR="$PROJ_DIR"
OUTDIR="$PROJ_DIR/data"
FILE="data/dataset.txt" 

while read line; do
    IFS=" " read -a strarr <<< "$line"
    image1="${strarr[0]}"
    image2="${strarr[1]}"
    name="${strarr[2]}"
    cd CPM
    ./CPM "$DATASET_DIR/$image1"  "$DATASET_DIR/$image2" "$OUTDIR/$name"

    cd ../RIC
    ./RIC "$DATASET_DIR/$image1"  "$DATASET_DIR/$image2" "$OUTDIR/$name"

done < $FILE
