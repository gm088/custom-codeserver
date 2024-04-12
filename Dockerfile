FROM --platform=linux/x86_64 ubuntu

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
git

# get some basics
RUN apt-get install -y software-properties-common
    
# get C++ compiler
RUN apt-get install -y g++
RUN apt-get install -y build-essential

# Install miniconda
#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
#&& /opt/miniconda3/bin/conda config --add channels defaults \
#&& /opt/miniconda3/bin/conda config --add channels conda-forge \
#&& /opt/miniconda3/bin/conda config --add channels bioconda
#
## Update path
#ENV PATH "/opt/miniconda3/bin:$PATH"
#ENV PATH "/usr/local/bin:$PATH"

RUN apt-get --quiet update --yes \
  && apt-get --quiet upgrade --yes \
  && DEBIAN_FRONTEND=noninteractive apt-get --quiet install --yes  \
  #  python-dev \
  #  python-pip \
    python3-dev \
    python3-pip \
    python3-tk \
    pandoc \
    libcurl4-openssl-dev \
    libssl-dev \
    libcairo2-dev \
    libxt-dev \
    libxml2-dev \
    libudunits2-dev \
    libhdf5-dev \
    libv8-dev \
    libgdal-dev \
    libglpk-dev \
    xorg \
    libx11-dev \
    libglu1-mesa-dev \
    libboost-all-dev \
    libgsl-dev \
    libbz2-dev \
    less \
    libmagick++-dev \
    ccache \
    libfftw3-dev \
    mysql-server \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://code-server.dev/install.sh | sh







