FROM docker.io/ubuntu:20.04
LABEL maintainer="aleksi.postari@samk.fi"
ARG TZ=Europe/Helsinki

#RUN useradd -ms /bin/bash dbuser
#USER dbuser
#RUN groupadd docker
#RUN usermod -aG docker $USER

RUN mkdir -p /home/root
WORKDIR /home/root

# Set timezone
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && echo "$TZ" > /etc/timezone

# Run updates in
RUN apt-get update && apt-get upgrade -y

# Install required apt packages
RUN apt-get --no-install-recommends install -yq \
  python3 \
  python3-pip \
  python3-setuptools \
  sqlite3 \
  mariadb-server

RUN echo "/sbin/service mysql start" >> ~/.bashrc

# Install required pip packages
#RUN python3 -m pip install --upgrade pip

# Mount volumes
