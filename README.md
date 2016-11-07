# docker-osticket

docker project 🐳 for deploy customer support ticket system

## Get project


```bash
git clone https://github.com/cl3m3nt666/docker-osticket.git
```

## Start services

```bash
docker-compose up -d
```

## After install

```bash
$ docker exec -it dockerosticket_osticket_1 chmod 0644 /var/www/localhost/htdocs/include/ost-config.php

$ docker exec -it dockerosticket_osticket_1 rm -rf /var/www/localhost/htdocs/setup
```

## Removes services

```bash
docker-compose down
```
