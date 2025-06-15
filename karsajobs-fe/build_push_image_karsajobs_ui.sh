#/bin/bash

# build image dari docker file pada directory
docker build -t ghcr.io/gungindi/karsajobs-ui:latest . 

#login ke github packages
echo $TOKEN | docker login ghcr.io -u gungindi --password-stdin

# push ke github packagessss
docker push ghcr.io/gungindi/karsajobs-ui:latest