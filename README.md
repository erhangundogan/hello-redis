hello-redis
===========

NodeJS backend to read and write for Redis. Repo includes Dockerfile and minikube deployment script.

## Run

You need running minikube cluster with docker host to pull and deploy image.

```bash
make pull

# it will deploy to default kubernetes namespace
make deploy
minikube service connect
```

## Build

You can build and deploy image from scratch for your own.
Clone repo as shown below, change `REPOSITORY` from `Makefile` and change image name (e.g. `erhangundogan/hello-redis:1.2.0`) from `deploy.yaml` and then follow command below:.

```bash
git clone git@github.com:erhangundogan/hello-redis.git
cd hello-redis
# do the changes in Makefile and deploy.yaml
minikube start
eval $(minikube docker-env)
make build
make push
make deploy
minikube service connect
# minikube should browse http://127.0.0.1:57241 and you would get {data: null}
# port 57241 would be different for you. 
# if you send POST request to same address then it writes to redis e.g.
# curl --request POST --header "Content-Type: application/json" --data '{"value":"foo"}' http://127.0.0.1:57241
```
