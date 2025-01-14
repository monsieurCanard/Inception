# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: testeur <testeur@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/13 08:00:27 by inception         #+#    #+#              #
#    Updated: 2025/01/14 16:19:49 by testeur          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: 
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down -v

re:
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker-compose -f srcs/docker-compose.yml up --build

clean:
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker system prune -af --volumes

fclean: 
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker system prune -af --volumes
	sudo rm -rf /home/testeur/data/wordpress/*
	sudo rm -rf /home/testeur/data/mariadb/*

.PHONY: all re down clean