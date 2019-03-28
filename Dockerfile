
# Set the base image to use to Ubuntu
FROM ubuntu:18.04

# user 
MAINTAINER SAI ANJAN

# Set env variables used in this Dockerfile

# Local directory with project source
ENV DOCKYARD_SRC=chatapplication

# Directory in container for all project files
ENV DOCKYARD_SRVHOME=/srv

# Directory in container for project source files
ENV DOCKYARD_SRVPROJ=/srv/chatapplication

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3 python3-pip

# Create application subdirectories
WORKDIR $DOCKYARD_SRVHOME
RUN mkdir media static logs
VOLUME ["$DOCKYARD_SRVHOME/media/", "$DOCKYARD_SRVHOME/logs/"]

# Copy application source code to SRCDIR
COPY $DOCKYARD_SRC $DOCKYARD_SRVPROJ

# Install Python dependencies
RUN pip3 install -r $DOCKYARD_SRVPROJ/requirement.txt

# Install Gunicorn
RUN pip3 install gunicorn

# Port to expose
EXPOSE 8000

# Copy entrypoint script into the image
WORKDIR $DOCKYARD_SRVPROJ
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]




