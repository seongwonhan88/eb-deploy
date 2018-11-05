FROM ubuntu:18.04
MAINTAINER seongwonhan88@gmail.com

#package upgrade
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install python3-pip

#nginx uwgsi install
RUN apt -y install nginx
RUN pip3 install uwsgi

# copy requirements
# if requirements has not changed, pip3 will not install
COPY requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

#copy entire source code
COPY . /srv/project/
WORKDIR /srv/project/

# settings module change to production
ENV DJANGO_SETTINGS_MODULE config.settings.production

#process run
WORKDIR /srv/project/ec2-deploy/app/
CMD python3 manage.py collectstatic --noinput

#delete default nginx
RUN rm -rf /etc/nginx/sites-available/*
RUN rm -rf /etc/nginx/sites-enabled/*

# project copy
RUN cp -f /srv/project/.config/app.nginx /etc/nginx/sites-available
RUN ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx
#uwsgi
CMD uwsgi --http :8000 --chdir /srv/project/app --wsgi config.wsgi