#!/bin/sh
#PBS -l walltime=12:00:00
#PBS -k oe
#PBS -j oe
#PBS -N codeserver

#-------------------------------------------------------------------------
# DECLARE PATH VARIABLES
#-------------------------------------------------------------------------
# Path of the singularity image to run rstudio-server
singularity_image="/hpcnfs/data/GN2/gmandana/singularity_images/cserver_latest.sif"
#

# Define home dir
user=`whoami`
home="/hpcnfs/data/GN2/gmandana/bin/cserver"

# pip configuration - install packages to a hpcnfs mounted dir so we can reload each time
pip_conf_file="${home}/.config/pip/pip.conf"
packages_install_path="${home}/site-packages/"
mkdir -p ${packages_install_path}

#-------------------------------------------------------------------------
# SET VARIABLES TO RUN SERVER
#-------------------------------------------------------------------------
export SINGULARITYENV_USER=$(id -un) # same as whoami
export SINGULARITYENV_PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8585:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@192.168.97.161

   and point your web browser to http://localhost:8585

2. Credentials:

   user: ${SINGULARITYENV_USER}
   password: ${SINGULARITYENV_PASSWORD}

3. Issue the following command on the login node:
      qdel -Wforce ${PBS_JOBID}
END

#### pass the custom installation path, and the default paths
export SINGULARITYENV_PIP_CONFIG_FILE=${pip_conf_file}
export SINGULARITYENV_PYTHONPATH="${packages_install_path}:/usr/lib/python310.zip:/usr/lib/python3.10:/usr/lib/python3.10/lib-dynload:/usr/local/lib/python3.10/dist-packages:/usr/lib/python3/dist-packages"

#-------------------------------------------------------------------------
# RUN CODE SERVER FROM SINGULARITY
#-------------------------------------------------------------------------

####NB for code server have to manually set 0.0.0.0 to listen at all interfaces
#### otherwise it uses a particular interfaces and you will need to gateway
#### pass the password as an environment variable according to code-server --help

/hpcnfs/software/singularity/3.7.0/bin/singularity exec --cleanenv \
   -H ${home} \
   --bind /hpcnfs/ \
   ${singularity_image} \
   code-server \
      --bind-addr 0.0.0.0:${PORT} \
      --auth password \
      --welcome-text HELLO 























