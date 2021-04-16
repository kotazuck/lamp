FROM php:apache

RUN apt-get update \
    && apt-get install -y \
      debconf-utils \
      apt-utils \
      lsb-release \
      wget \
      gnupg

RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "mysql-apt-config mysql-apt-config/enable-repo select mysql-5.7" | debconf-set-selections \
    && echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | debconf-set-selections \
    && dpkg -i mysql-apt-config_0.8.16-1_all.deb \
    && apt-get update \
    && apt-get install -y mysql-server \
    && echo "user=mysql" >> /etc/mysql/mysql.conf.d/mysqld.cnf

COPY docker-entrypoint.sh /

ENTRYPOINT ["/bin/bash"] 

CMD ["/docker-entrypoint.sh"]
