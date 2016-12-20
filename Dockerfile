FROM httpd:2.4

# Apache configuration files
COPY httpd.conf /usr/local/apache2/conf/
COPY httpd-vhosts.conf /usr/local/apache2/conf/extra

# Install tools
RUN apt-get update \
	&& apt-get -y install git vim \
	&& useradd jun -m -c 'git user' -u 1010

# Configure user working environment
USER jun

RUN cd ~ \
	&& git clone https://github.com/junhsieh/config_centos_v2.git \
	&& cd ~/config_centos_v2 \
	&& git remote set-url origin git@github.com:junhsieh/config_centos_v2.git \
	&& bash ~/config_centos_v2/script/setHomeConfig.sh


