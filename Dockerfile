# VERSION: 0.1.0
# DESCRIPTION: DIGSUM Docker Container for Atom with Hydrogen
# FULL DESCRIPTION: https://github.com/simonlindgren/atom-docker
# BUILD: sudo docker build --rm -t atom-docker .

# Use this container from dockerhub as our base image
#FROM jupyter/datascience-notebook

# Update setup stuff
#RUN pip install -U pip setuptools wheel

# Install python packages 
#RUN pip install -U nltk spacy networkx

# Install NLTK content
#RUN python -m nltk.downloader all

# Install spacy content
#RUN python -m spacy download en_core_web_sm

# Install Jupyter theme
#RUN pip install jupyterlab_darkside_ui

FROM ubuntu:latest

ENV ATOM_VERSION v1.59.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      fakeroot \
      gconf2 \
      gconf-service \
      git \
      gvfs-bin \
      libasound2 \
      libcap2 \
      libgconf-2-4 \
      libgcrypt20 \
      libgbm1 \
      libgtk2.0-0 \
      libgtk-3-0 \
      libnotify4 \
      libnss3 \
      libx11-xcb1 \
      libxkbfile1 \
      libxss1 \
      libxtst6 \
      libgl1-mesa-glx \
      libgl1-mesa-dri \
      policykit-1 \
      python \
      xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb > /tmp/atom.deb && \
    dpkg -i /tmp/atom.deb && \
    rm -f /tmp/atom.deb && \
    useradd -d /home/atom -m atom -s /bin/bash

USER atom

CMD ["/usr/bin/atom","-f","--no-sandbox"]

# Autorun atom
ENTRYPOINT [ "atom", "--foreground" ]
