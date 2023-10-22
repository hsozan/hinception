DOCKER := docker-compose -f ./srcs/docker-compose.yml
USER_HOME := $(HOME)

all:
	sudo mkdir -p $(USER_HOME)/data/wordpress
	sudo mkdir -p $(USER_HOME)/data/mysql
	export USER_HOME=$$HOME && $(DOCKER) up -d --build

down:
	$(DOCKER) down

re: fclean all

fclean: down
	$(DOCKER) down -v --remove-orphans
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
	sudo rm -rf $(USER_HOME)/data/wordpress
	sudo rm -rf $(USER_HOME)/data/mysql

.PHONY: all down re clean fclean
