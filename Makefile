.PHONY: test

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

test:
	#.PHONY: tests
	PYTHONPATH=. py.test --verbose -s
