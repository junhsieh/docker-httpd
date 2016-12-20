FROM httpd:2.4

# Apache configuration files
COPY ["httpd.conf", "/usr/local/apache2/conf/"]
COPY ["httpd-vhosts.conf", "/usr/local/apache2/conf/extra/"]

ADD ["https://raw.githubusercontent.com/junhsieh/config_centos_v2/master/script/setUtil.sh", "https://raw.githubusercontent.com/junhsieh/config_centos_v2/master/script/setConfig.sh", "/root/"]

