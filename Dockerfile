FROM httpd:2.4

# Apache configuration files
COPY httpd.conf /usr/local/apache2/conf/
COPY httpd-vhosts.conf /usr/local/apache2/conf/extra

# Install tools
RUN apt-get update \
	# curl, git and vim
	&& apt-get -y install curl git vim \
	# golnag
	&& curl -fSL "https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz" -o go.tar.gz \
	&& echo "47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b go.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xz -f go.tar.gz \
	&& rm go.tar.gz \
	# Create a user
	&& useradd jun -m -c 'git user' -u 1010 -s /bin/bash

# Configure user working environment
USER jun

RUN cd ~ \
	&& git clone https://github.com/junhsieh/config_centos_v2.git \
	&& cd ~/config_centos_v2 \
	&& git remote set-url origin git@github.com:junhsieh/config_centos_v2.git \
	&& bash ~/config_centos_v2/script/setHomeConfig.sh

USER root
