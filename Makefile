DOCKER_REPO ?= albertw/apache-drill
DRILL_VERSION ?= 1.14.0

.PHONY: build
build:
	docker build --build-arg DRILL_VERSION=${DRILL_VERSION} -t ${DOCKER_REPO}:latest .
	docker tag ${DOCKER_REPO}:latest ${DOCKER_REPO}:${DRILL_VERSION}

push: build
	docker push ${DOCKER_REPO}:latest
	docker push ${DOCKER_REPO}:${DRILL_VERSION}

