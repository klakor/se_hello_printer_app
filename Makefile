.PHONY: test
.DEFAULT_GOAL := test
USERNAME=klakor
SERVICE_NAME=hello-world-printer
MY_DOCKER_NAME=$(SERVICE_NAME)
TAG=$(USERNAME)/hello-world-printer

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

test:
	PYTHONPATH=. py.test --verbose -s

test_smoke:
	curl -s -o /dev/null -w "%{http_code}" --fail 127.0.0.1:5000

test_cov:
	PYTHONPATH=. py.test --verbose -s --cov=.

test_xunit:
	PYTHONPATH=. py.test --verbose -s --cov=. --cov-report xml --junit-xml=test_results.xml

docker_build:
	docker build -t $(MY_DOCKER_NAME) .

docker_run: docker_build
	docker run \
			--name $(SERVICE_NAME)-dev \
			-p 5000:5000 \
			-d $(MY_DOCKER_NAME)

docker_stop:
	docker stop $(SERVICE_NAME)-dev

docker_push: docker_build
	@docker login --username $(USERNAME) --password ${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;