#!/usr/bin/env bash
# 실행 시 서버에서 이미 실행중이던 uwsgi 프로세스들을 모두 종료하고
# 기존 루틴 진행
# 이후 runserver 대신 uwsgi 실행 (ini 파일을 사용)

IDENTITY_FILE="$HOME/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-52-79-227-13.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/documents/project/deploy"
SERVER_DIR="/home/ubuntu/project"

# ssh로 서버에 접속하는 명령어
CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

# 켜져있는 runserver 종료
${CMD_CONNECT} "pkill 8000"
echo "-kill runserver processes"

# 서버의 파일 지움
echo "Start deploy"
ssh -i ${IDENTITY_FILE} ${USER}@${HOST} rm -rf ${SERVER_DIR}

# 서버에 프로젝트 파일을 다시 업로드
echo "Delete server files"
scp -q -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}
echo "Delete Complete"

# 서버 접속 후 SERVER_DIR 로 이동, pipenv --venv 로 가상환경의 경로 가져오기
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")


# 가상환경의 경로에 /bin/python을 붙여 서버에서 사용하는 python경로 만들기
PYTHON_PATH="${VENV_PATH}/bin/python"
echo $PYTHON_PATH

# runserver 를 실행시켜 주는 커맨드 (nohop)
#RUNSERVER_CMD="nohup ${PYTHON_PATH} manage.py runserver 0:8000 &>/dev/null &"
#echo $RUNSERVER_CMD
UWSGI_INI="uwsgi --ini .config/uwsgi_http.ini"
# 실행문
#서버에 접속 후, 프로젝트의 'app'폴더까지 이동 한 후 runserver명령어를 실행
${CMD_CONNECT} "cd ${SERVER_DIR}/app && pipenv shell && pipenv install && ${UWSGI_INI}"
echo "Runserver Complete"
echo "End"