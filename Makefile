REGISTRY ?= docker.io
REPOSITORY ?= erhangundogan
IMAGE_VERSION ?= $(shell cat package.json | jq -r .version)
IMAGE = $(REGISTRY)/$(REPOSITORY)/hello-redis

.PHONY: build
build:
	docker build --no-cache --build-arg IMAGE_VERSION="$(IMAGE_VERSION)" -f Dockerfile -t "$(IMAGE):$(IMAGE_VERSION)" .;

.PHONY: push
push:
	docker push $(IMAGE):$(IMAGE_VERSION);

.PHONY: pull
pull:
	docker pull $(IMAGE):$(IMAGE_VERSION);

.PHONY: deploy
deploy:
	minikube start
	eval $(minikube docker-env)
	make pull
	kubectl apply -f deploy.yaml
