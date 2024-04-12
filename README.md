# custom-codeserver
run vscode on our HPC cluster 

build docker image
singularity pull onto cluster
the submission script launches code-server in a singularity container with a pip config file that specifies installation path of new packages to one on the cluster filesystem so that we just need to install once

then append that to $PYTHONPATH along with the containers defulat pythonpaths 
see the note about bind-addr for port forwarding

