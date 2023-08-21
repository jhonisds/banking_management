
.DEFAULT_GOAL := help

ifeq (, $(shell which docker))
	$(error "docker is not installed, installation instructions in https://docs.docker.com/engine/installation/")
endif

ifeq (, $(shell which docker-compose))
	$(error "docker-compose is not installed, installation instructions in https://docs.docker.com/compose/install/")
endif

help:			## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


docker.services.start:	## Start services containers.
	docker-compose -f docker-compose.yml -p banking up -d

docker.services.stop:	## Stop services containers
	docker-compose -f docker-compose.yml -p banking stop

docker.services.logs:	## Show logs from services containers. Use opts=args for more options of docker-compose logs
	docker-compose -f docker-compose.yml -p banking logs
