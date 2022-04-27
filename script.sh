#!/bin/bash

echo "Creating virtual environment"
python3 -m venv venv

echo "Activate the environment"
source venv/bin/activate

echo "Install the requirements"
pip install -r requirements.txt

echo "Get branch"
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Get commit hash"
GIT_COMMIT=$(git log -1 --format=%h)

echo "Write data to info json"
contents="$(git_commit=${git_hash}; jq --arg git_commit "$git_commit" '.[] .git_hash = $git_commit' templates/info.json)" && \
echo -E "${contents}" > templates/info.json
contents="$(git_branch=${git_branch}; jq --arg git_branch "$git_branch" '.[] .branch = $git_branch' templates/info.json)" && \
echo -E "${contents}"

git_branch=${GIT_BRANCH}; jq --arg git_branch "$git_branch" '.[] | .branch = $git_branch' templates/info.json 

echo "build the docker image"
docker build --tag python-docker\
 --build-arg GIT_COMMIT=$(git log -1 --format=%h) --build-arg GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD) . 

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