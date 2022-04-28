#!/bin/bash

if [[ ! -d results ]]
then
    mkdir results
fi

if [[ ! -d ckpts ]]
then
    mkdir ckpts
fi

num_gpus=${1:-4}

workload_dir="/mlcommons_training/image_segmentation/pytorch"

docker run --ipc=host --name=training -it --rm --runtime=nvidia \
	-v /data/kits19/data/:/raw_data \
	-v /data/kits19/preprocessed_data/:/data \
	-v ${workload_dir}/results:/results \
	-v ${workload_dir}/ckpts:/ckpts \
	unet3d:latest /bin/bash run_and_time.sh 1 $num_gpus

