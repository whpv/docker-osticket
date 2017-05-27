# docker-osticket

docker project 🐳 for deploy customer support ticket system

## Get project


```bash
git clone https://github.com/cl3m3nt666/docker-osticket.git
```

## 开启服务

```bash
docker-compose up -d
```

## 开始安装

访问浏览器地址，然后一步步安装，填写参数参考如下

```php
define('DBTYPE','mysql');
define('DBHOST','db');
define('DBNAME','osticket');
define('DBUSER','osticket');
define('DBPASS','PASSWORD');
```

## 删除文件

```bash
$ docker exec -it dockerosticket_osticket_1 chmod 0644 /var/www/localhost/htdocs/include/ost-config.php

$ docker exec -it dockerosticket_osticket_1 rm -rf /var/www/localhost/htdocs/setup
```

## 关闭服务

```bash
docker-compose down
```

## 拷贝配置（可选）

```
docker cp e24e9baf5ec0:/var/www/localhost/htdocs/include/ost-config.php ost-config.php
docker cp ./ost-config.php e24e9baf5ec0:/var/www/localhost/htdocs/include/ost-config.php
```
