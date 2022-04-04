FROM ubuntu:latest

# install dependancies
RUN apt-get update && apt-get install -y curl git wget unzip python3 && apt-get clean

# clone flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# add flutter to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel stable && flutter upgrade
RUN flutter config --enable-web

# copy our dir to the containor
RUN mkdir /soundspace/
COPY . /soundspace/
WORKDIR /soundspace/
RUN flutter build web

EXPOSE 8000

RUN ["chmod", "+x", "server/server.sh"]

ENTRYPOINT ./server/server.sh
