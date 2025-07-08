# makefile for docker automation
CONT_CRT_PATH	= /etc/stunnel/cert.pem
CONT_KEY_PATH	= /etc/stunnel/key.pem

HOST_CRT_PATH			= $(shell readlink -f /etc/letsencrypt/live/ivan.xenbox.ru/fullchain.pem)
HOST_KEY_PATH			= $(shell readlink -f /etc/letsencrypt/live/ivan.xenbox.ru/privkey.pem)

RUN_FLAGS       	= -p 443:443 -p 8080:8080
MOUNT_FLAGS				= -v $(HOST_CRT_PATH):$(CONT_CRT_PATH):ro -v $(HOST_KEY_PATH):$(CONT_KEY_PATH):ro

IMAGE_NAME 				= server_image
IMAGE_TAG  				= 0.2.0

CONTAINER_NAME 		= server_container

run: build
	docker run $(RUN_FLAGS) $(MOUNT_FLAGS) --name $(CONTAINER_NAME) -d $(IMAGE_NAME):$(IMAGE_TAG)

start:
	docker run $(RUN_FLAGS) $(MOUNT_FLAGS) --name $(CONTAINER_NAME) -d $(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) ./

stop:
	docker kill $(CONTAINER_NAME)

clean:
	docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

rerun: stop clean build run

ps:
	docker ps

psa:
	docker ps -a

ls:
	docker images

shell:
	docker exec -it $(CONTAINER_NAME) /bin/sh
