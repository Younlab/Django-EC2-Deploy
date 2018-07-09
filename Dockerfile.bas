FROM            ubuntu:17.10
MAINTAINER      d.sehyeon@gmail.com

# update, upgrade
RUN             apt -y update && apt -y dist-upgrade

# zsh
RUN             apt -y install zsh curl git
RUN             curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh  | bash
RUN             chsh -s /usr/bin/zsh   #zsh 설치할 수 있게 해줌.


# pyenv
RUN             curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
RUN             apt -y install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
                   libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
                   xz-utils tk-dev libffi-dev

#pyenv settings
RUN             echo 'export PATH="/root/.pyenv/bin:$PATH"' >>~/.zshrc
RUN             echo 'eval "$(pyenv init -)"' >> ~/.zshrc
RUN             echo 'eval "$(pyenv virtualenv-init -)"'>>~/.zshrc

# python install
ENV             PATH /root/.pyenv/bin:$PATH
RUN             eval "$(pyenv init -)"
RUN             eval "$(pyenv virtualenv-init -)"
RUN             pyenv install 3.6.5

# pipenv install
RUN             apt -y install software-properties-common python-software-properties
RUN             add-apt-repository -y ppa:pypa/ppa
RUN             apt -y update
RUN             apt -y install pipenv

# Language
ENV             LANG    C.UTF-8
ENV             LC_ALL  C.UTF-8

RUN             apt -y install vim

# Copy project files
RUN             mkdir /srv/project
COPY            ./Pipfile   /srv/project
#COPY            .           /srv/project
WORKDIR         /srv/project
RUN             pipenv install