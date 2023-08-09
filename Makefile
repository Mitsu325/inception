# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pmitsuko <pmitsuko@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/05 18:23:59 by pmitsuko          #+#    #+#              #
#    Updated: 2023/08/07 20:23:44 by pmitsuko         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## COLORS ##

DEFAULT		=	\e[39m
GREEN		=	\e[92m
YELLOW		=	\e[93m
BLUE		=	\e[94m
MAGENTA		=	\e[95m

# **************************************************************************** #

## DNS ##
DOMAIN_NAME	=	pmitsuko.42.fr
ADDRESS		=	127.0.0.1

## DIRECTORIES ##
DATA_BIND		=	/home/pmitsuko/data
COMPOSE_FILE	=	docker-compose.yml

## RULES ##

all: hosts rmvolumes volumes up

hosts:
	sudo chmod 646 /etc/hosts
	echo "$(ADDRESS) $(DOMAINNAME)" >> /etc/hosts

volumes:
	sudo mkdir -p $(DATA_BIND) $(DATA_BIND)/wordpress $(DATA_BIND)/mariadb

rmvolumes:
	sudo rm -rf $(DATA_BIND)

up:
	@echo "$(BLUE)\n--------------- BUILDING IMAGES --------------\n$(DEFAULT)"
	cd srcs && docker-compose -f $(COMPOSE_FILE) up --build --detach

down:
	@echo "$(MAGENTA)\n-------------- REMOVING CONTAINERS -----------\n$(DEFAULT)"
	cd srcs && docker-compose -f $(COMPOSE_FILE) down --rmi all --remove-orphans -v

start:
	@echo "$(BLUE)\n-------------- STARTING CONTAINERS -----------\n$(DEFAULT)"
	cd srcs && docker-compose -f $(COMPOSE_FILE) start

stop:
	@echo "$(YELLOW)\n-------------- STOPING CONTAINERS ------------\n$(DEFAULT)"
	cd srcs && docker-compose -f $(COMPOSE_FILE) stop

ls:
	@echo "$(GREEN)\n-------------------- IMAGES ------------------\n$(DEFAULT)"
	docker image ls -a
	@echo "$(GREEN)\n------------------ CONTAINERS ----------------\n$(DEFAULT)"
	docker ps -a
	@echo "$(GREEN)\n-------------------- VOLUME ------------------\n$(DEFAULT)"
	docker volume ls
	@echo "$(GREEN)\n------------------- NETWORK ------------------\n$(DEFAULT)"
	docker network ls -f type=custom

clean: down

clean_hosts:
	sudo chmod 646 /etc/hosts
	awk '!/$(DOMAINNAME)/' /etc/hosts > .tmp \
		&& cat .tmp > /etc/hosts \
		&& rm .tm
	sudo chmod 644 /etc/hosts

fclean: clean rmvolumes
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	docker image prune --force

re: fclean all

.PHONY: all clean fclean re hosts volumes rmvolumes up down start stop ls clean_hosts
