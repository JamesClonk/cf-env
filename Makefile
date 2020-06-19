.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse HEAD)

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

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
