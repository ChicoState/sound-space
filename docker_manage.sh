#!/bin/bash

IMAGES=$(docker ps -q)

if [[ $1 = "kill" ]]
then
	docker kill $(docker ps -q)
fi

if [[ $1 = "build" ]]
then
	docker build . -t soundspace
fi

if [[ $1 = "run" ]]
then
	docker run -ip 8000:8000 -d soundspace
fi

if [[ $1 = "setup" ]]
then
	source $(pwd)/.bashrc
fi

if [[ $1 = "help" ]]
then

	echo "dm build"
	echo "	will build your image"
	echo "dm run"
	echo "	will start the containor"
	echo "dm kill"
	echo "	will stop your image"
	echo ""
	echo "The usual process should go like this:"
	echo "change code -> build -> run -> check with browser at localhost:8000 -> kill"
fi
