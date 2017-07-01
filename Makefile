NS=danieloliv
VERSION ?= local
VOLUMES= -v $(PWD):/usr/src/app
PORTS= \
				-p 3000:3000 -p 3001:3001
WORKDIR= -w /usr/src/app
REPO=danieloliv
IMAGE_NAME=gorilla
IMAGE_TAG ?= latest
NAME=gorilla-app
INSTANCE=default
ENV= \
	-e NODE_ENV=development

.PHONY: up setup down build shell release

up:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(PORTS) $(WORKDIR) node:8 bash # -c "npm run start"

setup:
		docker run -it --rm --name $(NAME) $(VOLUMES) $(PORTS) $(WORKDIR) node:8 bash -c "npm install -g yarn && yarn && cd client && yarn"

down:
	docker rm -f $(NAME)

build:
	docker build --rm -t $(REPO)/$(IMAGE_NAME):$(IMAGE_TAG) .

shell:
	docker exec -it $(NAME) bash

release: build
	docker push $(REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

default: up
