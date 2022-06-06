# Databases in Docker

![image](https://user-images.githubusercontent.com/3810422/172101312-3c5d633f-3b87-41c8-a714-065f22d9e99b.png)

This repository contains automatic scripts for spinning up a Docker image containing some common DBMS systems pre-installed. Container utilizes Ubuntu linux operating system. The **build** script can be used to build the container and the **run** script to run the container and to login into the container, so that you can use any database from the container.

> This repository is meant for developing with the databases or learning the given databases, not for production deployment.

The pre-installed DBMS systems are listed below:
- MariaDB
- SQLite 3
- Redis (redis-cli and redis-server)
- MongoDB
- Neo4j (& Neo4j browser)

**Additional software / libraries installed**:
- MyCLI
- Python3

## Compatibility (Requirements)

These scripts should work with any Unix system. The scripts have been tested to work at least with with Ubuntu Linux (20.04) and MacOS (arm).

## Getting Started

In order to get everything running, following steps will need to be completed:

0. Install Docker (if not already installed)
1. Download this repository to your computer
2. Build the image
3. Run the container

### 0/3: Install Docker (if not already installed)

You need to first start by installing Docker, if you have not yet installed that. It is recommended to install the Docker Desktop software, as that pre-configures everything.

### 1/3: Download Repository

First, download this repository to somewhere on your computer. You can either clone this repository or download this repository as a zip file.

### 2/3: Build Image

To build the image, navigate to the folder where you cloned or downloaded this repository and:

1. Give run permissions to the **build** script by running ``chmod +x build``
2. Run the script with command ``./build``. It will then ask if you are sure, press **Y** to proceed building the image.

After the image has been built, you only need to run the container. Building the image again would delete any changes or data you have stored inside the container.

### 3/3: Run Container

To run the docker container:

1. You need to also give run permissions to the **run** script first by running ``chmod +x run``.
2. Now, just run the script with ``./run``.

Now at this point, you only need to run the container by running the command ``./run``. No need to run the build script anymore.
To exit out from the container, just use the command ``exit``.

Inside the container you can also find a file called ``help.txt`` in your home directory. View that file to view what commands can you use to use the pre-installed DBMS systems.
