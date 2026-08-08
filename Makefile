TAG ?= latest
IMAGE ?= llm-action-release

.PHONY: help build test push clean all

help:
	@echo "Available commands:"
	@echo "  make build IMAGE=llm-action-release TAG=latest  - Build the Docker image"
	@echo "  make test IMAGE=llm-action-release TAG=latest   - Run dgoss tests on the Docker image"
	@echo "  make push IMAGE=llm-action-release TAG=latest   - Push image to GHCR"
	@echo "  make clean IMAGE=llm-action-release TAG=latest  - Remove local image"
	@echo "  make all IMAGE=llm-action-release TAG=latest    - Build and test the image"

build:
	bash ./scripts/build.sh $(IMAGE) $(TAG)

test:
	bash ./scripts/test.sh $(IMAGE) $(TAG)

push:
	docker push ghcr.io/aurumorinc/$(IMAGE):$(TAG)

clean:
	docker rmi ghcr.io/aurumorinc/$(IMAGE):$(TAG) || true

all: build test
