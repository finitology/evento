APP_NAME = evento
PKG = ./...

BIN_DIR = bin
BIN_PATH = $(BIN_DIR)/$(APP_NAME)

IMAGE_NAME = $(APP_NAME):dev

all: build

build:
	@mkdir -p $(BIN_DIR)
	go build -o $(BIN_PATH) cmd/$(APP_NAME)/main.go

run:
	go run cmd/$(APP_NAME)/main.go

test:
	go test $(PKG) -v -cover

fmt:
	go fmt $(PKG)

lint:
	go vet $(PKG)

clean:
	rm -rf $(BIN_DIR)

docker-build:
	docker build -f Dockerfile.dev -t $(IMAGE_NAME) .

docker-run:
	docker run -p 8080:8080 $(IMAGE_NAME)

.PHONY: all build run test fmt lint clean docker-build docker-run
