hello-redis
===========

NodeJS backend to read and write from Redis. This is a demonstration repo and it should not be deployed to production.

## Run

You need running minikube cluster with docker host to pull and deploy image.

```bash
git clone git@github.com:erhangundogan/hello-redis.git
cd hello-redis
make pull

# it will deploy to default kubernetes namespace
make deploy
minikube service hello-redis-app
# minikube should browse http://127.0.0.1:57241 and you would get {data: null}
# port 57241 might be different for you. 
```

## Build

You can build and deploy image from scratch for your own.
Clone repo as shown below, change `REPOSITORY` from `Makefile` and change image name (e.g. `erhangundogan/hello-redis:1.2.1`) from `deploy.yaml` and then follow command below:.

```bash
git clone git@github.com:erhangundogan/hello-redis.git
cd hello-redis
# do the changes in Makefile and deploy.yaml
minikube start
eval $(minikube docker-env)
make build
make push
make deploy
minikube service hello-redis-app
# minikube should browse http://127.0.0.1:57241 and you would get {data: null}
# port 57241 might be different for you. 
# if you send POST request to same address then it writes to redis e.g.
# curl --request POST --header "Content-Type: application/json" --data '{"value":"foo"}' http://127.0.0.1:57241
```
