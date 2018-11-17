## Object Detection Using YOLO in a Docker Container

### Prerequisites

1. Docker
2. NVIDIA Drivers
3. NVIDIA docker
4. Darknet


#### Docker

Download and install from here: [Docker](https://www.docker.com/community-edition#/download)


#### NVIDIA drivers

Download and install from here: [NVIDIA](http://www.nvidia.com/Download/index.aspx?lang=en-us) 

#### NVIDIA docker

Download and install from here: [NVIDIA-Docker](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0))

Next step is to build the docker image. Use the [Dockerfile](Dockerfile) for that.
Run the following command (Assuming the terminal session is created in the same folder as the file) to build the image from the file.

`sudo docker build -t Darknet . `

-t flag is for giving the docker image a tag. Darknet is the tag name. You can use whatever name you want. 

More about Docker tags here: [Docker tags](https://medium.freecodecamp.org/an-introduction-to-docker-tags-9b5395636c2a)

Once the image is built, it can be found using the command `sudo docker images -a`

Before creating the container, enable xhosts for docker using the command `xhosts +`
> Warning! This command disables access control, which allows any host to connect to the X server! 

Next, we need to spin up a container from the image. 

`sudo nvidia-docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/docker_share:/docker_share -e DISPLAY=unix$DISPLAY --name yolo darknet `


| Argument     | Description |
| ------------- |  ------------- |
| `nvidia-docker` | Docker CLI repalcement for enabling nvidia drivers inside the container. |
| `/tmp/.X11-unix:/tmp/.X11-unix` | Mapping the X socket to the container. |
|` ~/docker_share:/docker_share `| Creates a folder named docker_share on the host as well as the container. This folder will be used to save the data. Any data written to this folder will be persistent.More on container persistence [here](https://docs.docker.com/storage/) |
|` DISPLAY=unix$DISPLAY` | specifying the display. |
|` --name yolo Darknet` | Specifying the name of the container and the image from which the container should be created. Here, yolo is the container name and Darknet is the image name. |
 
Once the container is started, cd into the shared folder (docker_share in this example).  

We now need to install Darknet and YOLO for object detection.  
 
#### Darknet

###### "Darknet is an open source neural network framework written in C and CUDA. It is fast, easy to install, and supports CPU and GPU computation." 

[Download and install] (https://pjreddie.com/darknet/install/)

###### Make sure to edit the Makefile and change value of GPU and OpenCV to 1.

#### YOLO: Real-Time Object Detection

###### "You only look once (YOLO) is a state-of-the-art, real-time object detection system."

`cd` to the Darknet folder and download the yolov3 weights using the command `wget https://pjreddie.com/media/files/yolov3.weights`

More on [YOLO](https://pjreddie.com/darknet/yolo/)

Now, in the host machine,if you go to the shared folder (docker_share in this example), you should be able to see the Darknet folder inside. 
Copy the video to be input for object detection into this Darknet folder in the host machine.

To perform object detection, run the following command in the docker container. Make sure that you are inside the Darknet folder in the container while running the command.

`./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights <video file>`