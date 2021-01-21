#!bin/bash

PROJ_DIR=$PWD
DATA="$PROJ_DIR/data-demo"

cd CPM
./CPM "$DATA/image1.png"  "$DATA/image2.png" "$DATA/match.txt"

cd ../RIC
./RIC "$DATA/image1.png"  "$DATA/image2.png" "$DATA/match.txt"