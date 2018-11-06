FROM eb-docker:base
ENV DJANGO_SETTINGS_MODULE config.settings.production


#copy entire source code
COPY . /srv/project/
WORKDIR /srv/project/


#process run
WORKDIR /srv/project/app/
CMD python3 manage.py collectstatic --noinput
#delete default nginx
RUN rm -rf /etc/nginx/sites-available/* && \
    rm -rf /etc/nginx/sites-enabled/* && \
    cp -f /srv/project/.config/app.nginx /etc/nginx/sites-available && \
    ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx


#supervisor conf copy
RUN cp -f /srv/project/.config/supervisord.conf /etc/supervisor/conf.d/

# open port 80
EXPOSE 80

#supervisor run
CMD supervisord -n