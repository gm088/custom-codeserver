# custom-codeserver
run vscode on our HPC cluster using codeserver (**https://github.com/coder/code-server**)

build docker image
singularity pull onto cluster
the submission script launches code-server in a singularity container with a pip config file that specifies installation path of new packages to one on the cluster filesystem so that we just need to install once

then append that to $PYTHONPATH along with the containers defulat pythonpaths 
see the note about bind-addr for port forwarding

In summary:

on your computer:
```
#!/bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t gm088/cserver:${IMAGE_VERSION} -t gm088/cserver:latest . && \
docker push gm088/cserver:${IMAGE_VERSION}
docker push gm088/cserver:latest
```

On the cluster:
```
singularity pull docker://gm088/cserver:latest
```
then qsub the submission script, first checking that you replace the appropriate custom directories
