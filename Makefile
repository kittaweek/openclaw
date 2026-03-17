# Makefile for OpenClaw Docker-only Management

# Ensure consistent shell behavior across bash and fish
SHELL := /bin/bash

# Define common compose command
COMPOSE := docker compose

# Default target
.DEFAULT_GOAL := help

.PHONY: help setup up down restart logs status cli login shell-gateway shell-cli build pull clean

help: ## Show this help message
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Run the automated Docker setup (interactive)
	bash docker-setup.sh

up: ## Start OpenClaw services in background
	$(COMPOSE) up -d

down: ## Stop and remove containers
	$(COMPOSE) down

restart: ## Restart OpenClaw gateway
	$(COMPOSE) restart openclaw-gateway

logs: ## Tail container logs
	$(COMPOSE) logs -f

status: ## View status of OpenClaw containers
	$(COMPOSE) ps

cli: ## Run OpenClaw CLI commands inside container (e.g. make cli cmd="config list")
	$(COMPOSE) run --rm openclaw-cli $(cmd)

login: ## Log in to messaging channels (WhatsApp, etc.) inside container
	$(COMPOSE) run --rm openclaw-cli channels login

shell-gateway: ## Enter the gateway container shell
	docker exec -it openclaw-gateway sh

shell-cli: ## Enter the CLI container shell
	docker exec -it openclaw-cli sh

build: ## Build or rebuild services
	$(COMPOSE) build

pull: ## Pull service images
	$(COMPOSE) pull

clean: ## [CAUTION] Stop services and remove configurations but KEEP workspace
	$(COMPOSE) down
	@echo "Note: Configuration at $(OPENCLAW_CONFIG_DIR) is preserved. Workspace at $(OPENCLAW_WORKSPACE_DIR) is preserved."
