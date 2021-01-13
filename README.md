# Docker wrapper to CPM-flow and RIC-flow
This project wraps two methods for optical flow estimation and refinement.
In particular, methods are:
* `Efficient Coarse-to-Fine PatchMatch for Large Displacement Optical Flow`: original code available [here](https://github.com/YinlinHu/CPM)
* `Robust Interpolation of Correspondences for Large Displacement Optical Flow`: original code available [here](https://github.com/YinlinHu/Ric)



Since both the code-bases require `opencv-3.x` and `opencv-contribs` for C++, this project enable to deploy them on different machines using a shared Docker container. 

# Run
The base container already contains `opencv-3.4.11` and `opencv-contribs` compiled for C/C++.

You can build the container by running:

```
sudo docker build --tag flow_container $PWD
```

The image contains a `workspace` folder with `CPM` and `RIC` folders inside. 

From this image, you can start a new container from it with:

```
sudo docker run -it --name cpm flow_container 
```

Then, you are free to call a single project or to combine them.
For instance, to run CPM's demo, you can:

```
cd CPM
bash demo.sh
```

## Data folder binding

You can also bind local folders in your machine with folders inside the container.
For instance, you can bind the `data` folder (copied inside the conainer) with our local `data` folder.

```
sudo docker run -it -v ${PWD}/data:/workspace/data --name flow flow_container
```

By running the `demo.sh` script you can notice that your local `data` folder now contains the results of `CPM` and `RIC`.

## Process a dataset

The script `process_dataset.sh` allows to run CPM+RIC for a list of images.

```
DATA=path_to_dataset_folder
OUTDIR="output"

mkdir $OUTDIR
sudo docker run -it -v $DATA:/workspace/data -v $OUTDIR=/workspace/temp --name flow flow_container
```

Note that `$DATA` and `$OUTDIR` have to be absolute paths.

Then:

```

DATA=path_to_dataset_folder
OUTDIR="output"
NAMES=path_to_file_with_names.txt

bash process_dataset.sh $DATA $OUTDIR $NAMES
```

Where `$NAMES` is a txt file where each line 

```
path_to_image1 path_to_image2 final_name
```

The path to the image (e.g., image1) is given by `$DATA/path_to_image1`
## Delete images and containers

```
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker image prune -a
```
**NOTE:** Do not run these commands if you are using Docker in other projects

# Citations

```
@inproceedings{hu2016cpm,
  title={Efficient Coarse-to-Fine PatchMatch for Large Displacement Optical Flow},
  author={Yinlin Hu and Rui Song and Yunsong Li},
  booktitle={CVPR},
  year={2016}
}
```

```
@inproceedings{hu2017robust,
  title={Robust interpolation of correspondences for large displacement optical flow},
  author={Hu, Yinlin and Li, Yunsong and Song, Rui},
  booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  pages={481--489},
  year={2017}
}
```
