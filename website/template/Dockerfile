# Download base image ubuntu 20.04
FROM ubuntu:20.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update && apt -y upgrade

# Install nginx, php-fpm and supervisord from ubuntu repository
RUN apt install -y nginx php-fpm php-redis php-mysqli php-intl supervisor vim certbot iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean
    
RUN mkdir -p /run/php && mkdir -p /srv/html && mkdir -p /srv/conf && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php && \
    chown -R www-data:www-data /srv/html

# Define the ENV variable
ENV php_conf /etc/php/7.4/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Enable PHP-fpm on nginx virtualhost configuration
COPY conf/ /srv/conf/
COPY html/ /srv/html/
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "\ndaemon off;" >> ${nginx_conf}

RUN sed -i -e 's/include \/etc\/nginx\/sites-enabled\/*/include \/srv\/conf\/*/g' ${nginx_conf} && \
    sed -i -e "s/octet-stream;/octet-stream;\n\tlog_format main '\$http_x_forwarded_for - \$remote_user [\$time_local] \"\$request\" \$status \$body_bytes_sent \"\$http_referer\" \"\$http_user_agent\"';/g" ${nginx_conf}
    
# Copy supervisor configuration
COPY supervisord.conf ${supervisor_conf}

# Copy start.sh script and define default command for the container
COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY update.sh /update.sh
RUN chmod +x /update.sh

CMD ["/bin/bash", "/run.sh"]

# Expose Port for the Application 
EXPOSE 80 443