FROM httpd:2.4

# Apache configuration files
#COPY ["httpd.conf", "/usr/local/apache2/conf/"]

RUN cd /usr/local/apache2/conf/ \
    && cp httpd.conf httpd.conf.ORIG \
	&& awk '/^    AllowOverride [Nn]one/{c++;if(c==2){sub("None","All");c=0}}1' httpd.conf > httpd.conf.AWK \
	&& mv -f httpd.conf.AWK httpd.conf \
	&& sed -i \
		   -e "s/^#LoadModule proxy_module/LoadModule proxy_module/" \
		   -e "s/^#LoadModule proxy_fcgi_module/LoadModule proxy_fcgi_module/" \
		   -e "s/^#LoadModule rewrite_module/LoadModule rewrite_module/" \
		   -e "s/^#Include conf\/extra\/httpd-vhosts.conf/Include conf\/extra\/httpd-vhosts.conf/" \
		   httpd.conf \
	&& cd /usr/local/apache2/conf/extra \
    && cp httpd-vhosts.conf httpd-vhosts.conf.ORIG \
    && mkdir /usr/local/apache2/htdocs/host_not_found \
    && echo hi > /usr/local/apache2/htdocs/host_not_found/index.html

COPY ["httpd-vhosts.conf", "/usr/local/apache2/conf/extra/"]

ADD ["https://raw.githubusercontent.com/junhsieh/config_centos_v2/master/script/setUtil.sh", "https://raw.githubusercontent.com/junhsieh/config_centos_v2/master/script/setConfig.sh", "/root/"]

