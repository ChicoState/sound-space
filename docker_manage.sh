#!/bin/bash

IMAGES=$(docker ps -q)

case $1 in
	"kill" | "down")
		docker-compose down
		yes | docker image prune
	;;
	"build")
		docker-compose build
	;;
	"up" | "run")
		docker-compose up -d
	;;
	"setup")
		source $(pwd)/.bashrc
	;;
	"dev")
		# This allows for hot reload with the use of VScode
		# using this method make sure that everything works with docker before commiting
		flutter run -d chrome
	;;
	*)
		echo ""
		echo "dm build"
		echo "	-will build your image"
		echo "dm up"
		echo "	-will start the containor"
		echo "dm kill"
		echo "	-will stop your image"
		echo "dm dev"
		echo "	-launch debugging instance of web in chrome tab with hot reload enabled"
		echo ""
	;;
esac
