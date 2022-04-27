# syntax=docker/dockerfile:1

FROM python:3.9.2

ARG GIT_COMMIT=unspecified \
    GIT_BRANCH=unspecified
LABEL git_commit=$GIT_COMMIT \
      git_branch=$GIT_BRANCH

ENV git_hash=$GIT_COMMIT \
    git_branch=$GIT_BRANCH
ADD . ${git_hash}  
ADD . ${git_branch}

WORKDIR python-docker

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt && \
    apt update 

COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]