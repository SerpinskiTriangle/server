# makefile for docker automation

# configuration

## general
DOCKERFILE 				= Dockerfile

BUILD_CONTEXT 		= .

IMAGE_NAME 				= server_image
IMAGE_TAG  				= 0.3.0 #last commit before moving to nginx

CONTAINER_NAME 		= server_container

## volume configuration
CONT_CRT_PATH			= /etc/nginx/ssl/fullchain.pem
CONT_KEY_PATH			= /etc/nginx/ssl/privkey.pem

HOST_CRT_PATH			= $(shell readlink -f /etc/letsencrypt/live/ivan.xenbox.ru/fullchain.pem)
HOST_KEY_PATH			= $(shell readlink -f /etc/letsencrypt/live/ivan.xenbox.ru/privkey.pem)

## flags
PORT_FLAGS       	= -p 443:443
VOLUME_FLAGS			= -v $(HOST_CRT_PATH):$(CONT_CRT_PATH):ro -v $(HOST_KEY_PATH):$(CONT_KEY_PATH):ro

#commands

## core commands
build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(DOCKERFILE) $(BUILD_CONTEXT) || true

run:
	docker run --rm $(PORT_FLAGS) $(VOLUME_FLAGS) --name $(CONTAINER_NAME) -d $(IMAGE_NAME):$(IMAGE_TAG) || true

stop:
	docker kill $(CONTAINER_NAME) || true

clean:
	docker rm  -f $(CONTAINER_NAME)						|| true
	docker rmi -f $(IMAGE_NAME):$(IMAGE_TAG) 	|| true

## iterative commands
rerun: stop clean build run

## utility commands
ps:
	docker ps

psa:
	docker ps -a

ls:
	docker images

sh:
	docker exec -it $(CONTAINER_NAME) /bin/sh
