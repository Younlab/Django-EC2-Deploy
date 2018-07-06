FROM            ec2-deploy:bas
ENV             PROJECT_DIR     /srv/project

RUN             apt -y install nginx

COPY            .   ${PROJECT_DIR}
WORKDIR         ${PROJECT_DIR}

RUN             export VENV_PATH=$(pipenv --venv); echo $VENV_PATH;
ENV             VENV_PATH $VENV_PATH

# Run uWSGI (CMD)
#CMD         pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

# RUN Nginx
#CMD             nginx -g 'daemon off;'

