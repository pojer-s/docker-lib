NAME = spojer/doctl
VERSION = latest

.PHONY: all build tag_latest release

all: build

build:
	test -d doctl || git clone https://github.com/digitalocean/doctl.git
	cd doctl && docker build -t $(NAME):$(VERSION) .

push:
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)

clean:
	docker rmi $(NAME):$(VERSION)
	rm -rf doctl
