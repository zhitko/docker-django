# Django with Docker

## Environment

Docker containers:

* web
    * python:3.4
* nginx    
* postgres
    * postgres:9.4

## Docker commands

Base commands

```
Build containers:
> docker-compose build
Start containers:
> docker-compose up
or dettached
> docker-compose up -d --force-recreate && docker-compose logs
Stop and remove containers:
> docker-compose stop && docker-compose rm -fv
```