# Docker wrapper to CPM-flow and RIC-flow
This project wraps two methods for optical flow estimation and refinement.
In particular, methods are:
* `Efficient Coarse-to-Fine PatchMatch for Large Displacement Optical Flow`: original code available [here](https://github.com/YinlinHu/CPM)
* `Robust Interpolation of Correspondences for Large Displacement Optical Flow`: original code available [here](https://github.com/YinlinHu/Ric)



Since both the code-bases require `opencv-3.x` and `opencv-contribs` for C++, this project enables to deploy them on different machines using a shared Docker container. 

# Run
The base image already contains `opencv-3.4.11` and `opencv-contribs` compiled for C/C++.

You can build the container by running:

```
sudo docker build --tag flow_container $PWD
```

The image contains a `workspace` folder with `CPM` and `RIC` folders inside. 

From this image, you can start a new container from it with:

```
sudo docker run -it --name demo flow_container 
```

Then, you are free to call a single project or to combine them.
For instance, to run CPM's demo, you can:

```
bash demo.sh
```

## Data folder binding

You can also bind local folders in your machine with folders inside the container.
For instance, you can bind the `data-demo` folder (copied inside the conainer) with our local `data-demo` folder.
Be aware that removing files from your local folder will do the same inside the container's linked folder.

```
sudo docker run -it -v ${PWD}/data-demo:/workspace/data-demo --name flow flow_container
```

By running the `demo.sh` script you can notice that your local `data-demo` folder now contains the results of `CPM` and `RIC`.

**NOTE:** If `$DATA` is a remote disk, it has to be mounted using `sudo sshfs`

## Process a dataset

The script `process_dataset.sh` allows to run CPM+RIC for a list of images.

```
DATA=path_to_dataset_folder
OUTDIR="output"
NAMES=path_to_file_with_names.txt

mkdir $OUTDIR
sudo docker run -it -v $DATA:/workspace/dataset -v $OUTDIR:/workspace/temp -v $NAMES:/workspace/names.txt --name flow flow_container
```

Note that `$DATA` and `$OUTDIR` have to be absolute paths.

Then:

```
bash process_dataset.sh /workspace/dataset /workspace/temp /workspace/names.txt
```

Where `$NAMES` is a txt file where each line looks like:

```
path_to_image1 path_to_image2 final_name
```

The path to the image (e.g., image1) is given by `$DATA/path_to_image1`
## Stop containers and Delete images
To stop every running container, you can run:
```
sudo docker stop $(sudo docker ps -a -q); sudo docker rm $(sudo docker ps -a -q)
```

Moreover, if you desire to free disk space, you can delete the Docker image.
To delete **every** docker image, run:
```
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
