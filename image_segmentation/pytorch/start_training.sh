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

if [ -z $2 ]
then

	docker run --ipc=host --name=training -it --rm --runtime=nvidia \
		-v /data/kits19/data/:/raw_data \
		-v /data/kits19/preprocessed_data/:/data \
		-v ${workload_dir}/results:/results \
		-v ${workload_dir}/ckpts:/ckpts \
		unet3d:latest /bin/bash run_and_time.sh 1 $num_gpus
else
	mem_limit=$2

	docker run --ipc=host --name=training -it --rm --runtime=nvidia \
		--memory="${mem_limit}" \
		--memory-swap="-1" \
		--memory-swappiness="100" \
		-v /data/kits19/data/:/raw_data \
		-v /data/kits19/preprocessed_data/:/data \
		-v ${workload_dir}/results:/results \
		-v ${workload_dir}/ckpts:/ckpts \
		unet3d:latest /bin/bash run_and_time.sh 1 $num_gpus
fi
