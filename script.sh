#!/bin/bash

echo "Creating virtual environment"
python3 -m venv venv

echo "Activate the environment"
source venv/bin/activate

echo "Install the requirements"
pip install -r requirements.txt

echo "Getting git branch"
branch=$(git symbolic-ref --short HEAD)

jq --arg newkey "$branch" '(.HeaderAuthentication.Headers[] | select(.Name == "branch")).Value |= $newkey' ./templates/info.json
jq '.branch = main' ./templates/info.json|sponge ./templates/info.json

echo "build the docker image"
docker build --tag python-docker  .
# sudo docker build -t helloworld/sivasai:$DATE . >> /home/sivasaisagar/output
echo "built docker images and proceeding to delete existing container"
docker ps --filter "name=python-docker"
result=$( docker ps -q -f name=python-docker )
if [[ $? -eq 0 ]]; then
echo "Container exists"
sudo docker container rm -f python-docker
echo "Deleted the existing docker container"
else
echo "No such container"
fi
echo "Deploying the updated container"
docker run -d -p 5000:5000 --name python-docker python-docker
# sudo docker run -itd -p 3000:3000 --name helloworld $OUTPUT
echo "Deploying the container"