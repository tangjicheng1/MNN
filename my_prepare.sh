#!/bin/bash

### in windows wsl, with NVIDIA CUDA
sudo apt install -y wget
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_570.124.06_linux.run
sudo sh cuda_12.8.1_570.124.06_linux.run

export PATH=/usr/local/cuda-12.8/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH

sudo sh -c 'echo "/usr/local/cuda-12.8/lib64" >> /etc/ld.so.conf'
sudo ldconfig

### build
cd MNN
./schema/generate.sh
mkdir build && cd build 

cmake .. -DMNN_CUDA=ON \
         -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.8/bin/nvcc \
         -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-12.8 \
         -DCUDA_CUDART_LIBRARY=/usr/local/cuda-12.8/lib64/libcudart.so

make -j8

### macos
cmake .. -DMNN_METAL=ON
