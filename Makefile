.PHONY: build
build:
	- docker image rm masnathan/unbound-arm:0.0.4 --force
	docker build -t masnathan/unbound-arm:0.0.4 .
	docker tag masnathan/unbound-arm:0.0.4 masnathan/unbound-arm:latest

.PHONY: deploy
deploy: build
		- docker rm -f unbound
		docker run --name=unbound -it -d --dns=1.1.1.1 --dns=1.0.0.1 -p 30053:53/udp -p 30053:53 -p 8953:8953 --restart always masnathan/unbound-arm:0.0.4

.PHONY: push
push: build
		docker push masnathan/unbound-arm:0.0.4
