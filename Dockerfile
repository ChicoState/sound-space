FROM ubuntu:20.04

# install dependancies
RUN apt-get update
RUN apt-get install -y curl git wget unzip python3
RUN apt-get clean

# clone flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# add flutter to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# copy our dir to the containor
RUN mkdir /soundspace/
COPY . /soundspace/
WORKDIR /soundspace/
RUN flutter build web

EXPOSE 8000

RUN ["chmod", "+x", "server/server.sh"]

ENTRYPOINT ./server/server.sh