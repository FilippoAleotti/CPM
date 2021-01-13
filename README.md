# Introduction

This repository contains the code for the paper **Efficient Coarse-to-Fine PatchMatch for Large Displacement Optical Flow**. [Yinlin Hu](http://yinlinhu.github.io), Rui Song, and Yunsong Li. CVPR. 2016. [\[Paper\]](https://zpascal.net/cvpr2016/Hu_Efficient_Coarse-To-Fine_PatchMatch_CVPR_2016_paper.pdf)

# How to Use

It is assumed that the OpenCV has been installed correctly.

```
$ cmake .
$ make
```

Then, you can play with the examples:

```
$ bash demo.sh
```

# Run me on Docker!
We dockerized this project to make it easy to use.
The base container already contains `opencv-3.4.11` and `opencv-contribs` compiled for C/C++.

You can build the container by running:

```
sudo docker build --tag cpm_container $PWD
```

Then, you can start it with:

```
sudo docker run -it -v ${PWD}/out:/CPM/out --name cpm cpm_container 
```

Note that we bind the local `data` folder to the `data` folder inside the container. Doing so, artifacts created inside the container will be available even in our local filesystem.

Inside the container, you can run the code. For instance, to run the demo example simply call:

```
bash demo.sh
```


# Citing

```
@inproceedings{hu2016cpm,
  title={Efficient Coarse-to-Fine PatchMatch for Large Displacement Optical Flow},
  author={Yinlin Hu and Rui Song and Yunsong Li},
  booktitle={CVPR},
  year={2016}
}
```