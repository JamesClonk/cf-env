.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse --short HEAD)

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: build
## build: build docker image
build:
	echo "build"

.PHONY: publish
## publish: publish docker image
publish:
	echo "publish"

.PHONY: setup
## setup: setup environment
setup:
	echo "setup"
