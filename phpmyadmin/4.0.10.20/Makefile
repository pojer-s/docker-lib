NAME = pojers/phpmyadmin
VERSION = 4.0.10.20

.PHONY: all build tag_latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) .

release:
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)

clean:
	docker rmi $(NAME):$(VERSION)
