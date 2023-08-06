# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pmitsuko <pmitsuko@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/05 18:23:59 by pmitsuko          #+#    #+#              #
#    Updated: 2023/08/06 16:27:57 by pmitsuko         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## COLORS ##

DEFAULT		=	\e[39m
GREEN		=	\e[92m
YELLOW		=	\e[93m
MAGENTA		=	\e[95m
CYAN		=	\e[96m

# **************************************************************************** #

LOGIN=pmitsuko
HOME=/home/$(LOGIN)/data
COMPOSE_FILE=./srcs/docker-compose.yml

## RULES ##

all: hosts rvolumes volumes up

hosts:
	sudo sed -i "s/localhost/$(LOGIN).42.fr/g" /etc/hosts

volumes:
	sudo mkdir -p $(HOME)/wordpress
	sudo mkdir -p $(HOME)/mariadb

rvolumes:
	sudo rm -rf $(HOME)

build:
	@echo "$(BLUE)\n--------------- BUILDING IMAGES --------------\n$(DEFAULT)"
	docker-compose -f $(COMPOSE_FILE) build

up:
	@echo "$(BLUE)\n-------------- RUNNING CONTAINERS ------------\n$(DEFAULT)"
	docker-compose -f $(COMPOSE_FILE) up --build --detach

down:
	@echo "$(MAGENTA)\n-------------- REMOVING CONTAINERS -----------\n$(DEFAULT)"
	docker-compose -f $(COMPOSE_FILE) down

start:
	@echo "$(BLUE)\n-------------- STARTING CONTAINERS -----------\n$(DEFAULT)"
	docker-compose -f $(COMPOSE_FILE) down

stop:
	@echo "$(YELLOW)\n-------------- STOPING CONTAINERS ------------\n$(DEFAULT)"
	docker-compose -f $(COMPOSE_FILE) down

ls:
	@echo "$(GREEN)\n-------------------- IMAGES ------------------\n$(DEFAULT)"
	docker image ls -a
	@echo "$(GREEN)\n------------------ CONTAINERS ----------------\n$(DEFAULT)"
	docker ps -a
	@echo "$(GREEN)\n-------------------- VOLUME ------------------\n$(DEFAULT)"
	docker volume ls
	@echo "$(GREEN)\n------------------- NETWORK ------------------\n$(DEFAULT)"
	docker network ls -f type=custom

clean:
	docker image prune -f

fclean: clean down rvolumes

re: fclean all


.PHONY: all clean fclean re
