FROM base

MAINTAINER Vilius Lukosius <vilius.lukosius@gmail.com>

# make sure the package repository is up to date
RUN apt-get update
RUN apt-get upgrade -y

# install sshd and supervisor
RUN apt-get install -y openssh-server supervisor
# install base dependencies
RUN apt-get install -y python-setuptools python-dev patch subversion python-svn

# install reviewboard
RUN easy_install ReviewBoard

# install supported DVCS
RUN apt-get install -y git-core python-subvertpy


# install external dependencies
RUN apt-get install -y memcached python-memcache
RUN apt-get install -y apache2 libapache2-mod-wsgi

# initialize reviewboard
RUN rb-site install --noinput --domain-name=reviews.local --db-type=sqlite3 --db-name=reviewboard --db-user=reviewboard --db-pass=reviewboard --cache-type=memcached --web-server-type=apache --python-loader=wsgi --admin-user=admin --admin-password=admin --admin-email=noreply@local /srv/reviews.local

# move data to proper folder
RUN mv /srv/reviews.local/reviewboard /srv/reviews.local/data/reviewboard

# update config with new data file location
RUN sed -i 's/reviewboard/\/srv\/reviews.local\/data\/reviewboard/g' /srv/reviews.local/conf/settings_local.py
RUN sed -i 's/DEBUG = False/DEBUG = True/g' /srv/reviews.local/conf/settings_local.py

# fix permissions
RUN chown -R www-data:www-data /srv/reviews.local/data /srv/reviews.local/htdocs/media/uploaded /srv/reviews.local/htdocs/media/ext /srv/reviews.local/data /srv/reviews.local/logs

# configure apache
RUN cp /srv/reviews.local/conf/apache-wsgi.conf /etc/apache2/sites-available/reviews.local
RUN a2dissite default
RUN a2ensite reviews.local

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

ADD supervisor/sshd.conf     /etc/supervisor/conf.d/sshd.conf
ADD supervisor/apache.conf   /etc/supervisor/conf.d/apache.conf


# add public key for passwordless auth
ADD ssh_keys/id_rsa_docker.pub /tmp/id_rsa_docker.pub
RUN mkdir -p /root/.ssh
RUN cat /tmp/id_rsa_docker.pub >> /root/.ssh/authorized_keys

#clean-up
RUN rm /tmp/id_rsa_docker.pub
RUN apt-get clean

# remove database for later using from local mount point
RUN rm /srv/reviews.local/data/reviewboard

expose 22 80

CMD ["/usr/bin/supervisord", "-n"]