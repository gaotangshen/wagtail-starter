SHELL := /bin/bash

BUILD_NAME = gt-playground
SVC_TAG = latest
SHELL_FLAGS = -ti
VOLUMES = -v $(PWD):/service

all:
	$(MAKE) build
	$(MAKE) run

build:
	# Build the main source image
	docker build --rm \
		-f Dockerfile \
		-t $(BUILD_NAME):$(SVC_TAG) \
		.

run:
	$(MAKE) stop
	docker run \
		$(SHELL_FLAGS) \
		-p 8000:8000 \
		--name $(BUILD_NAME) \
		$(VOLUMES) \
		$(BUILD_NAME):$(SVC_TAG)

stop:
	docker stop $(BUILD_NAME) || true && docker rm $(BUILD_NAME) || true
