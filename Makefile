REGISTRY ?= docker.io
REPOSITORY ?= erhangundogan
IMAGE_VERSION ?= $(shell cat package.json | jq -r .version)
IMAGE = $(REGISTRY)/$(REPOSITORY)/hello-redis

.PHONY: build
build:
	docker build --no-cache \
		--build-arg IMAGE_VERSION="$(IMAGE_VERSION)" \
		--build-arg IMAGE_CREATE_DATE="`date -u +"%Y-%m-%dT%H:%M:%SZ"`" \
		--build-arg IMAGE_SOURCE_REVISION="`git rev-parse HEAD`" \
		-f Dockerfile -t "$(IMAGE):$(IMAGE_VERSION)" .;

.PHONY: push
push:
	docker push $(IMAGE):$(IMAGE_VERSION);

.PHONY: pull
pull:
	docker pull $(IMAGE):$(IMAGE_VERSION);

.PHONY: deploy
deploy:
	kubectl apply -f deploy.yaml
