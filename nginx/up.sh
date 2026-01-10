#!/bin/bash
docker stop typing && docker rm typing

sudo kill $(sudo lsof -t -i:80)

docker build -t typing-game:latest .

docker run -p 80:80 --name typing typing-game:latest