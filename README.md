# Ubuntu 18.04 and PHP7.3
The image contains Ubuntu 18.04 as base image. Upon this, PHP 7.3 with Apache 2 are built up.

## Using Dockerfile
If you want to customize the build process, you need to edit the **Dockerfile** in this repo.

### Building docker image
Once you are the Dockerfile directory, run following command to build image:
``` bash
docker build . -t ubuntu-18-04_php7-3
```
Once the successful building upon the image, you need to create the container. I preferably use Ubuntu machine as host machine and put all my PHP codes under `/var/www/html`. Within the container, the Apache's serving directory is `/var/www/html`.

``` bash
docker run -it -p 8080:80 -v /var/www/html:/var/www/html ubuntu-18-04_php7-3 bash
```
Here we are mapping port 80 within the container to 8080 outside i.e., host. You need to access serving web address using port 8080.
As soon as you hit this command, you are redirected to docker container. There you first need to start Apache using following command:
``` bash
sudo service apache2 start
```
The password for sudo is `ser_123`.

Once done, head towards web browser and hit below url:
``` anchor
http://localhost:8080/
```
### Using existing docker image
If you are not customizing Dockerfile, you can directly pull the built image from docker hub using following command:
``` bash
docker pull sanjayabc1234/ubuntu-php7.3
```

To create docker container, you need to use:
``` bash
docker run -it -p 8080:80 -v /var/www/html:/var/www/html sanjayabc1234/ubuntu-php7.3 bash
```
Again you need to start Apache to start the server.

## Using Database MySQL
The `mysqli` driver is already loaded. You need to pull the mysql container and use it for application development.

``` bash
docker pull mysql
```
Instruction for usage is given [here](https://hub.docker.com/_/mysql).

## Using Phpmyadmin
``` bash
docker pull phpmyadmin/phpmyadmin
```
Instruction for usage is given [here](https://hub.docker.com/r/phpmyadmin/phpmyadmin).
