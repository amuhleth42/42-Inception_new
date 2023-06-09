NAME = 		inception

COMPOSE =	-f ./srcs/docker-compose.yml

DOCKER =	docker-compose $(COMPOSE) -p $(NAME)



all:	start

build:
	$(DOCKER) build

start:
	$(DOCKER) up -d --build

down:
	$(DOCKER) down

clean:
	$(DOCKER) down --volumes
	sudo rm -rf /home/amuhleth/data/wp_db/*
	sudo rm -rf /home/amuhleth/data/wp_site/*

re:	clean build start


.PHONY:	all build start down clean re
