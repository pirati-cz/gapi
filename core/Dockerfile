FROM base/archlinux
MAINTAINER Vaclav Malek <vaclav.malek@pirati.cz>

# set environemnt
ENV HOME /root
ENV PYTHON /usr/bin/python2.7

# update system + install packages + clean
RUN pacman -Syu --noconfirm
RUN pacman -S gcc make python2 nodejs --noconfirm
RUN pacman -Sc --noconfirm
RUN npm install -g gulp gulp-coffee coffee-script mocha should rdfstore sparqljs 

# user app
RUN groupadd -g 9999 app
RUN useradd -m -g app -u 9999 -G app app

#
ADD etc/rc.local /etc/rc.local

# start 
CMD ["/home/app/gapi/bin/gapi.js"]
#CMD ["/usr/sbin/sshd","-D"]
#CMD ["/usr/sbin/sshd","-D","-d","-E","/root/sshd.log"]
#CMD ["/sbin/init"]
