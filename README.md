# Nutrition Label Service API running inside docker.

This is one half of the complete docker container for setting up Nutrition Facts Label API (contains PostgreSQL and associates). This server can respond to requests from any postgres client on port 5432. This best suites development purposes.

It contains nutrition fact label sr26 plain sql data.

This is a sample Nutrition Facts Label API (PostgreSQL) container used to test Nutrition Facts Lable Generator from [http://nuts.globalfoodbook.net](http://nuts.globalfoodbook.net) use on [http://globalfoodbook.com](http://globalfoodbook.com)


To build this gfb server run the following command:

```bash
$ docker pull globalfoodbook/nls-pg
```

This will run on a default port of 5432.

To change the PORT for this run the following command:

```bash
$ docker run --name=nls-pg --detach=true --publish=5432:5432--env POSTGRES_PASSWORD=${POSTGRES_PASSWORD} _service --env NUT_PG_DSN="postgres://ikennaokpala:${POSTGRES_PASSWORD}@${POSTGRES_IP}/nutrition_development?sslmode=disable" nls-pg
```

To run the server and expose it on port 5432 of the host machine, run the following command:

```bash
$ docker run --name=nls-pg --detach=true --publish=5432:5432 globalfoodbook/nls-pg
```

# NB:

## Before pushing to docker hub

## Login

```bash
$ docker login
```

## Build

```bash
$ cd /to/docker/directory/path/
$ docker build -t <username>/<repo>:latest .
```

## Push to docker hub

```bash
$ docker push <username>/<repo>:latest
```


IP=`docker inspect gfb | grep -w "IPAddress" | awk '{ print $2 }' | head -n 1 | cut -d "," -f1 | sed "s/\"//g"`
HOST_IP=`/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

DOCKER_HOST_IP=`awk 'NR==1 {print $1}' /etc/hosts` # from inside a docker container


# Contributors

* [Ikenna N. Okpala](http://ikennaokpala.com)
