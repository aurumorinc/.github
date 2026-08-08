TAG ?= latest
IMAGE ?= llm-action-release

.PHONY: help build test push clean all

help:
	@echo "Available commands:"
	@echo "  make build TAG=latest  - Build the llm-action-release Docker image"
	@echo "  make test TAG=latest   - Run dgoss tests on the llm-action-release image"
	@echo "  make push TAG=latest   - Push image to GHCR"
	@echo "  make clean TAG=latest  - Remove local image"
	@echo "  make all TAG=latest    - Build and test the image"

build:
	./scripts/build.sh $(IMAGE) $(TAG)

test:
	./scripts/test.sh $(IMAGE) $(TAG)

push:
	docker push ghcr.io/aurumorinc/$(IMAGE):$(TAG)

clean:
	docker rmi ghcr.io/aurumorinc/$(IMAGE):$(TAG) || true

all: build test
