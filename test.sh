#!/usr/bin/env bash

IDENTITY_FILE="$HOME/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-52-79-227-13.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/documents/project/deploy"
SERVER_DIR="/home/ubuntu/project"

# ssh로 서버에 접속하는 명령어
CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

# 서버 접속 후 SERVER_DIR 로 이동, pipenv --venv 로 가상환경의 경로 가져오기
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")


# 가상환경의 경로에 /bin/python을 붙여 서버에서 사용하는 python경로 만들기
PYTHON_PATH="${VENV_PATH}/bin/python"
echo $PYTHON_PATH

# runserver 를 실행시켜 주는 커맨드 (nohop)
RUNSERVER_CMD="nohup ${PYTHON_PATH} manage.py runserver 0:8000"
echo $RUNSERVER_CMD

# 실행문
#서버에 접속 후, 프로젝트의 'app'폴더까지 이동 한 후 runserver명령어를 실행
${CMD_CONNECT} "cd ${SERVER_DIR}/app && ${RUNSERVER_CMD}"
echo "Runserver Complete"
echo "End"
