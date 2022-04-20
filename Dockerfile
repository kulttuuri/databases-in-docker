FROM docker.io/ubuntu:20.04
LABEL maintainer="aleksi.postari@samk.fi"
ARG TZ=Europe/Helsinki

# Set home directory
RUN mkdir -p /home/root
WORKDIR /home/root

# Move help file to container
COPY ./files/help.txt .

###
# SETUP
###

# Set timezone
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && echo "$TZ" > /etc/timezone

# Run updates in
RUN apt-get update && apt-get upgrade -y

# Variables
ENV apt apt-get --no-install-recommends install -yq

# Basic software to be installed

#RUN $apt build-essential acl unzip git
RUN $apt sudo systemctl nano

###
# INSTALLATION
###

# Install Python3
RUN $apt python3 python3-pip python3-setuptools

# Update pip
RUN python3 -m pip install --upgrade pip

# Install pip packages
RUN pip3 install mycli

#
# SQLITE3
#

# Install sqlite3
RUN $apt sqlite3

#
# MARIADB
#

# Install MariaDB
RUN $apt mariadb-server

# Start the MySQL (mariaDB) service
RUN echo "/sbin/service mysql start" >> ~/.bashrc

#
# REDIS
#

# Install Redis
RUN $apt redis-server redis-tools

# Configure Redis to run in the background
RUN sed -i "s|daemonize yes|daemonize no|g" /etc/redis/redis.conf
#RUN sed -i "s|supervised no|supervised systemd|g" /etc/redis/redis.conf

# Copy the Redis systemd file to container
COPY ./files/redis.service /etc/systemd/system/redis.service

# Enable and start the Redis service
RUN systemctl enable redis
RUN systemctl start redis
RUN echo "systemctl start redis" >> ~/.bashrc