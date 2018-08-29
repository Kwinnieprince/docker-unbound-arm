VERSION         := $(shell version)
NEXT_VERSION    := $(shell version increment 0.0.1)

.PHONY: build
build:
	- docker image rm "masnathan/unbound-arm:$(VERSION)" --force
	- docker image rm "masnathan/unbound-arm:$(NEXT_VERSION)" --force
	docker build -t "masnathan/unbound-arm:$(NEXT_VERSION)" .
	docker tag "masnathan/unbound-arm:$(NEXT_VERSION)" masnathan/unbound-arm:latest

.PHONY: deploy
deploy: build
	- docker rm -f unbound
	docker run --name=unbound -it -d --dns=1.1.1.1 --dns=1.0.0.1 -p 30053:53/udp -p 30053:53 -p 8953:8953 --restart always masnathan/unbound-arm:$(NEXT_VERSION)

.PHONY: push
push: tag build
	docker push masnathan/unbound-arm:$(NEXT_VERSION)
	docker push masnathan/unbound-arm:latest

.PHONY: tag
tag:
	git tag $(NEXT_VERSION)
	git push --tags

