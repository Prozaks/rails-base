# Rails Base

## Introducción

Base Rails 6 + Postgres + Docker

## Stack

* Ruby 2.7.1
* Rails 6.0.2

## Como iniciar el proyecto

### Requisitos

* Docker
* Docker Compose

### Crear volumen para almacenar las gems instaladas

```
docker volume create --name base-gems
```

### Build de los distintos containers

```
docker-compose build
```

### Bundle Install

```
docker-compose run app bundle install
```

### Crear base de datos

```
docker-compose run app bin/rails db:create
docker-compose run app bin/rails db:migrate
```

### Iniciar los servicios

```
docker-compose up
```