FROM ubuntu:18.04                                                                                                                                                                                                  

RUN apt update && apt install -y python3 && apt install -y python3-pip docker.io && DEBIAN_FRONTEND=noninteractive apt install -y tzdata && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN pip3 install flask-restful==0.3.7 uwsgi==2.0.17.1

RUN mkdir -p /etc/j4j/J4J_DockerSpawner

RUN adduser --disabled-password --gecos '' dockerspawner

RUN chown dockerspawner:dockerspawner /etc/j4j/J4J_DockerSpawner

COPY --chown=dockerspawner:dockerspawner ./app /etc/j4j/J4J_DockerSpawner/app

COPY --chown=dockerspawner:dockerspawner ./app.py /etc/j4j/J4J_DockerSpawner/app.py

COPY --chown=dockerspawner:dockerspawner ./scripts /etc/j4j/J4J_DockerSpawner

COPY --chown=dockerspawner:dockerspawner ./uwsgi.ini /etc/j4j/J4J_DockerSpawner/uwsgi.ini

WORKDIR /etc/j4j/J4J_DockerSpawner

CMD /etc/j4j/J4J_DockerSpawner/start.sh
