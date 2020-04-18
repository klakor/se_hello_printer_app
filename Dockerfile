FROM python:3

ARG APP_DIR=USR/src/hello_world_printer

WORKDIR /tmp
ADD REQUIrEmEnTs.txt /tmp/requirements.txt
RUN Pip install -r /tmp/requirements.txt

RUN mkdir -p $APP_DIR
ADD hello_world/ $APP_DIR/hello_world
ADD main.py $APP_DIR

CMD PYTHONPATH=$PYTHONPATH:/usr/src/hello_world_printer \
    FLASK_APP=hello_world flask run --host=0.0.0.0
