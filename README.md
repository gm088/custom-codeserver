# custom-codeserver
run vscode on our HPC cluster using codeserver (**https://github.com/coder/code-server**)

build docker image, then
singularity pull onto cluster, then
the submission script launches code-server in a singularity container 

pip config file that specifies installation path of new packages to one on the cluster filesystem so that we just need to install once

then append that to $PYTHONPATH along with the containers defulat pythonpaths 
see the note in the submission script about bind-addr for port forwarding

In summary:

on your computer:
```
#!/bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t username/cserver:${IMAGE_VERSION} -t username/cserver:latest . && \
docker push username/cserver:${IMAGE_VERSION}
docker push username/cserver:latest
```

On the cluster:
```
singularity pull docker://gm088/cserver:latest
```
then qsub the submission script, first checking that you replace the appropriate custom directories

```
qsub -I -l select=1:ncpus=2:mem=10G vscoderun.sh
```

