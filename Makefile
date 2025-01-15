# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: testeur <testeur@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/13 08:00:27 by inception         #+#    #+#              #
#    Updated: 2025/01/15 15:20:26 by testeur          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: 
	docker-compose -f ./srcs/docker-compose.yml up --build

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

restart:
	docker-compose -f ./srcs/docker-compose.yml stop
	docker-compose -f srcs/docker-compose.yml start

re:
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker-compose -f srcs/docker-compose.yml up --build

build:
	docker-compose -f ./srcs/docker-compose.yml build

build-no-cache:
	docker-compose -f ./srcs/docker-compose.yml build --no-cache

up:
	docker-compose -f ./srcs/docker-compose.yml up

clean:
	docker-compose -f ./srcs/docker-compose.yml down -v

fclean: 
	docker-compose -f ./srcs/docker-compose.yml down -v
	docker system prune -af --volumes

.PHONY: all re down clean