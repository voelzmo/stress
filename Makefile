TAG?=dev
REGISTRY?=voelzmo

docker:
	BUILDER=$(shell docker buildx create --use)
	docker buildx build --platform=linux/amd64,linux/arm64 -t ${REGISTRY}/stress:${TAG} --push .
	docker buildx rm ${BUILDER}

.PHONY: docker
