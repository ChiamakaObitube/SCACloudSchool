# Week 4 Task

Week 4 task is to demonstrate the understanding of web servers such as Apache and Nginx. However, the main focus was on Nginx.

This week's task is a follow-up on last week's learnings on virtualization and containerization with Docker and Docker Compose. 

### What is NGINX ?
According to its official documentation, NGINX is an open source software for web serving, reverse proxying, caching, load balancing, media streaming and more. It is a lightweight, high-performance web server designed for high-traffic use cases such as serving static content like HTML and media files.

Configuration options in NGINX  are called directives. Directives are dividied into blocks and contexts. All NGINX configuration files are located in the /etc/nginx directory. 
Depending on your installation source, you’ll find an example configuration file at /etc/nginx/conf.d/default.conf or etc/nginx/sites-enabled/default

Some of NGINX contexts include main context, http context, location context, server context. mail context. SOome of these contexts can be nested into another. For example, the location context can be nested into the server context.

### The Task
Using Docker-Compose, configure and deploy an nginx application that routes to two applications running also in docker. This will be achieved through reverse proxying.
* Specifications: Using nginx location directive,
/django -> should route to  app1 
/nest -> should route to app2

App1 and App2 consists of a Django application and a NestJS application running on ports 8000 and 5000 respectively.

* Clone and create the repositories.
App1 is available [here](https://github.com/raccoonyy/django-sample-for-docker-compose.git) and App2 is available [here.](https://github.com/kyhsa93/nestjs-rest-example.git)
* Create a docker-compose.yml file in the root directory that will contain the nginx application. Copy and paste the contents below.
``` version: '3'
services:
  nginx:
    restart: always
    build: ./nginx/
    ports:
      - '8080:80'
```
The ports have been remapped to make nginx available on port 8080 on the host machine.
* Configure the containers to talk with each other. Since the applications will be built using different compose, create a network using the command ```docker network create app```. 
Modify the docker compose files for each of the repos and the nginx docker-compose file to include this snippet at the bottom.
```
networks:
 default:
   external:
     name: app
```
* Create a directory and a sub directory named ***nginx*** and ***sites-enabled*** that will contain the NGINX configuration files. CD into the ***sites-enabled*** directory and create a file ***nginx.conf***

* Copy and paste the contents below into the nginx.conf file.
```
  server {
  listen 80;
  server_name localhost;
  access_log /var/log/nginx/nginx.conf.log;
  charset utf-8;

  location /django {
    proxy_pass http://django:8000/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }

  location /nest {
    proxy_pass http://nest:5000/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
```
Because we want to be able to access the two applications like this /django and /nest respectively, we have  created and nested 2 location contexts for the different applications inside the server context. And since the applications are available on the same network created earlier, we use proxy_pass to configure the applications to be available using simple identifiable names to access the django  and nest applications originally available on port 8000 and port 5000 respectively.

* Start the applications
Run ```docker-compose up -d``` in each of the foldersto start the applications. 
Please note that the applications need to be up and running first before bringing up the Nginx service.

* Verify the configuration.
If there are no errors, the container applications using these urls http://localhost:8080/django and http://localhost:8080/nest respectively.

![http://localhost:8080/django](/week4/images/django.png)

![http://localhost:8080/nest](/week4/images/nest.png)