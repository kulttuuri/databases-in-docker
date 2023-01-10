FROM docker.io/ubuntu:20.04
LABEL maintainer="aleksi@postari.net"
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
RUN $apt sudo systemctl nano curl gnupg2 unzip wget

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

#
# MONGODB
#

# Mongodb version 5
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN apt update
RUN $apt mongodb-org
# Expose this instance to the whole world
# Absolutely NEVER do this in a production environment
RUN sed -i "s|127.0.0.1|0.0.0.0|g" /etc/mongod.conf
RUN echo "systemctl start mongod.service" >> ~/.bashrc
RUN printf "cloud:\n  monitoring:\n    free:\n      state: 'off'" >> /etc/mongod.conf

#
# NEO4J
#

RUN curl -fsSL https://debian.neo4j.com/neotechnology.gpg.key |sudo gpg --dearmor -o /usr/share/keyrings/neo4j.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/neo4j.gpg] https://debian.neo4j.com stable 4.4" | sudo tee -a /etc/apt/sources.list.d/neo4j.list
RUN apt update
RUN $apt neo4j
RUN sed -i "s|#dbms.default_listen_address=0.0.0.0|dbms.default_listen_address=0.0.0.0|g" /etc/neo4j/neo4j.conf
RUN echo "systemctl start neo4j.service" >> ~/.bashrc
