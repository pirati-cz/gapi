# start from phusion nodejs image
FROM phusion/passenger-nodejs

# set correct HOME env
ENV HOME /root

# allow user 'app' to login through ssh
RUN passwd -u app

# setup permissions for sourcing env
RUN chmod 755 /etc/container_environment && chmod 644 /etc/container_environment.sh /etc/container_environment.json

# set CMD
CMD ["/sbin/my_init"]

# build nodejs environment
RUN /build/utilities.sh
RUN /build/nodejs.sh

# turn on nginx
RUN rm -f /etc/service/nginx/down

# add config files
ADD etc/nginx/sites-enabled/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD etc/rc.local /etc/rc.local
ADD etc/ssh/sshd_config /etc/ssh/sshd_config

# install global Node.js packages
RUN npm install -g gulp gulp-coffee coffee-script mocha should

# clean temporary files and cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#EXPOSE 80
