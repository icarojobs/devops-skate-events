default: env prepare up key-generate npm-install npm-run-build fresh-seed
	@echo "--> Your environment is ready to use! Access http://localhost:8000 and enjoy it!"

.PHONY: env
env:
	@echo "--> Copying .env.example to .env file"
	@cp .env.example .env

.PHONY: prepare
prepare:
	@echo "--> Installing composer dependencies..."
	@sh ./bin/prepare.sh

.PHONY: up
up:
	@echo "--> Starting all docker containers..."
	@chmod -R 777 storage/
	@./vendor/bin/sail up --force-recreate -d
	@./vendor/bin/sail art migrate --force


.PHONY: key-generate
key-generate:
	@echo "--> Generating new laravel key..."
	@./vendor/bin/sail art key:generate

.PHONY:	npm-install
npm-install:
	@echo "--> Installing all node dependencies..."
	@./vendor/bin/sail npm install

.PHONY:	npm-run-build
npm-run-build:
	@echo "--> Building frontend assets..."
	@./vendor/bin/sail npm run build

.PHONY:	fresh-seed
fresh-seed:
	@echo "--> Building database mock structure..."
	@sleep 7
	@./vendor/bin/sail art migrate:fresh --seed

.PHONY:	down
down:
	@echo "--> Stopping all docker containers..."
	@./vendor/bin/sail down

.PHONY:	restart
restart:	down up

.PHONY: build
build:
	@echo "--> Building docker image..."
	@docker build -t mob2you/devops-skate-events/sail-8.4-app:latest .

.PHONY: build-no-cache
build-no-cache:
	@echo "--> Building docker image..."
	@docker build --no-cache -t mob2you/devops-skate-events:latest . --progress=plain

.PHONY: push
push:
	@echo "--> Sending docker built image to registry..."
	@docker push mob2you/devops-skate-events:latest
