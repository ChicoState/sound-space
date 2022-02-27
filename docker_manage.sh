#!/bin/bash

IMAGES=$(docker ps -q)

case $1 in
	"kill" | "down")
		docker-compose down
		yes | docker image prune
	;;
	"build")
		# docker build . -t soundspace
		docker-compose build
	;;
	"up" | "run")
		# docker run -ip 8000:8000 -d soundspace
		docker-compose up -d
	;;
	"setup")
		source $(pwd)/.bashrc
	;;
	*)
		echo ""
		echo "dm build"
		echo "	will build your image"
		echo "dm up"
		echo "	will start the containor"
		echo "dm kill"
		echo "	will stop your image"
		echo ""
	;;
esac
