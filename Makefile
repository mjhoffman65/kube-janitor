.PHONY: test docker push

IMAGE            ?= mjhoffman65/kube-janitor
VERSION          ?= evict
TAG              ?= $(VERSION)

default: docker

test:
	pipenv run flake8
	pipenv run coverage run --source=kube_janitor -m py.test
	pipenv run coverage report

docker: 
	docker build --build-arg "VERSION=$(VERSION)" -t "$(IMAGE):$(TAG)" .
	@echo 'Docker image $(IMAGE):$(TAG) can now be used.'

push: docker
	docker push "$(IMAGE):$(TAG)"
	docker tag "$(IMAGE):$(TAG)" "$(IMAGE):latest"
	docker push "$(IMAGE):latest"
