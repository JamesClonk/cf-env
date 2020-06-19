.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse HEAD)

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: login
## login: login to docker hub
login:
	@export PATH="$$HOME/bin:$$PATH"
	@echo $$DOCKER_PASS | docker login -u $$DOCKER_USER --password-stdin

.PHONY: build
## build: build docker image
build:
	@export PATH="$$HOME/bin:$$PATH"
	pack build jamesclonk/cf-env:${COMMIT_SHA} --builder heroku/buildpacks:18

.PHONY: publish
## publish: build and publish docker image
publish:
	@export PATH="$$HOME/bin:$$PATH"
	pack build jamesclonk/cf-env:${COMMIT_SHA} --builder heroku/buildpacks:18 --publish
	docker pull jamesclonk/cf-env:${COMMIT_SHA}
	docker tag jamesclonk/cf-env:${COMMIT_SHA} jamesclonk/cf-env:latest
	docker push jamesclonk/cf-env:latest

.PHONY: run
## run: run docker image
run:
	@export PATH="$$HOME/bin:$$PATH"
	docker run --rm --env PORT=8080 -p 8080:8080 jamesclonk/cf-env:${COMMIT_SHA}

.PHONY: setup
## setup: setup environment
setup:
	@export PATH="$$HOME/bin:$$PATH"
	./setup.sh
