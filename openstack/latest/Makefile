NAME = spojer/openstack
VERSION = latest

.PHONY: all build tag_latest release clean builddoc

all: build push

build:
	docker build -t $(NAME):$(VERSION) .

push:
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME):$(VERSION)

clean:
	docker rmi $(NAME)
