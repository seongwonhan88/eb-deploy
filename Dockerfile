FROM python:3.6.7-slim
MAINTAINER seongwonhan88@gmail.com

# settings module change to production, language from ascii to utf-8
ENV LANG=C.UTF-8

#package upgrade
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install gcc nginx supervisor
RUN pip3 install uwsgi

# copy requirements
# if requirements has not changed, pip3 will not install
COPY requirements_production.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

ENV DJANGO_SETTINGS_MODULE config.settings.production


#copy entire source code
COPY . /srv/project/
WORKDIR /srv/project/


#process run
WORKDIR /srv/project/app/
CMD python3 manage.py collectstatic --noinput
#delete default nginx
RUN rm -rf /etc/nginx/sites-available/*
RUN rm -rf /etc/nginx/sites-enabled/*

# project copy
RUN cp -f /srv/project/.config/app.nginx /etc/nginx/sites-available
RUN ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx


#supervisor conf copy
RUN cp -f /srv/project/.config/supervisord.conf /etc/supervisor/conf.d/

# open port 80
EXPOSE 80

#supervisor run
CMD supervisord -n