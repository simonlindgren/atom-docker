# VERSION: 0.1.0
# DESCRIPTION: DIGSUM Docker Container for Atom with Hydrogen
# FULL DESCRIPTION: https://github.com/simonlindgren/atom-docker
# BUILD: sudo docker build --rm -t atom-docker .

# Use this container from dockerhub as our base image
FROM jupyter/datascience-notebook

# Update setup stuff
RUN pip install -U pip setuptools wheel

# Install python packages 
#RUN pip install -U nltk spacy networkx

# Install NLTK content
#RUN python -m nltk.downloader all

# Install spacy content
#RUN python -m spacy download en_core_web_sm

# Install Jupyter theme
#RUN pip install jupyterlab_darkside_ui

# Install and launch atom
CMD ["bash"]
ENV ATOM_VERSION 1.59.0
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
	&& dpkg -i /tmp/atom-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

RUN apm install atom-beautify \
	busy-signal \
	color-picker \
 	file-icons \
	hydrogen \
	intentions \
	linter \
 	linter-js-standard \
	linter-markdown \
	linter-ui-default \
	minimap \
	pigments


# Autorun atom
ENTRYPOINT [ "atom", "--foreground" ]
