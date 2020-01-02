.PHONY: help

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`
BUILD ?= `git rev-parse --short HEAD`

ORG := $(if $(ORG),$(ORG),$("kitplummer"))

help:
	@echo "$(APP_NAME):$(APP_VSN)-$(BUILD)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker image
	docker build --build-arg APP_NAME=$(APP_NAME) \
  --build-arg APP_VSN=$(APP_VSN) \
  -t $(ORG)/$(APP_NAME):$(APP_VSN)-$(BUILD) \
  -t $(ORG)/$(APP_NAME):latest .

run: ## Run the app in Docker
	docker run \
	-e LEI_CRITICAL_CONTRIBUTOR_LEVEL=1 \
  --expose 4000 -p 4000:4000 \
  --rm -d $(ORG)/$(APP_NAME):latest

publish: ## Push the artifact out
##	echo $(DOCKER_PASSWORD) | docker login -u $(DOCKER_USERNAME) --password-stdin
	docker push $(ORG)/$(APP_NAME):$(APP_VSN)-$(BUILD)
	docker push $(ORG)/$(APP_NAME):latest
