TAG      ?= $(shell git rev-parse HEAD)
IMAGE    ?= quay.io/steigr/seafile

image:
	docker build --tag="$(IMAGE):$(TAG)" .

push: image
	docker push "$(IMAGE):$(TAG)"

release:
	@TAG="$(shell git describe --tags)" make image push
	@TAG="latest" make image push