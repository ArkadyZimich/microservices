
USER_NAME ?= arkadyzimich
VERSION ?= latest

.PHONY: build-all build-comment build-post build-ui build-prometheus build-cloudprober push-ui push-comment push-post push-prometheus push-blackbox-exporter push-all start stop

build-all: build-comment build-post build-ui build-prometheus build-cloudprober

build-comment:
	cd src/comment/ && bash docker_build.sh

build-post:
	cd src/post-py/ && bash docker_build.sh

build-ui:
	cd src/ui/ && bash docker_build.sh

build-prometheus:
	cd monitoring/prometheus/ && docker build -t $(USER_NAME)/prometheus .

build-cloudprober:
	cd monitoring/cloudprober/ && docker build -t $(USER_NAME)/cloudprober .


push-ui:
	docker push $(USER_NAME)/ui:$(VERSION)

push-comment:
	docker push $(USER_NAME)/comment:$(VERSION)

push-post:
	docker push $(USER_NAME)/post:$(VERSION)

push-prometheus:
	docker push $(USER_NAME)/prometheus:$(VERSION)

push-cloudprober:
	docker push $(USER_NAME)/cloudprober:$(VERSION)

push-all: push-ui push-comment push-post push-prometheus push-cloudprober

start:
	cd docker && docker-compose up -d

stop:
	cd docker && docker-compose down
