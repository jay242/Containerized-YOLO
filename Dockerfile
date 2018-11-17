FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER Jaiju Joseph <jaiju.joseph@aalto.fi>

# Install some dependencies
RUN apt-get update && apt-get install -y \
		bc \
		build-essential \
		cmake \
		curl \
		g++ \
		gfortran \
		git \
		nano \
		pkg-config \
		python-dev \
		software-properties-common \
		unzip \
		vim \
		wget \
	    libssl-dev \
        libffi-dev \
       python3-dev \
       python3-pip \
       libopencv-dev \
       python-opencv


CMD ["/bin/bash"]
