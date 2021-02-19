# Week 3 Task

Week 3 task is to demonstrate the understanding of virtualization and containerization.

# What is virtualization?

Virtualization is the technology that creates an abstraction layer over computer hardware that allows the physical hardware elements (CPU cores, memory, disk) of a single computer to be divided into  multiple virtual computers. It has its own Guest OS, Kernel, process, drivers etc. Popular virtualization platforms include VMWare, SOlarWInds Virtualization Manager, Citrix, Oracle, Mirosoft, Amazon etc


# What is containerization ?
Containerization is a technology that virtualizes the OS. It abstracts the host operating system and makes containerized applications portable and able to run uniformly and consistently cross any platform or cloud. Containerization involves packaging up software code and all its dependencies so that it can run uniformly and consistently on any infrastructure.

# Benefits of containerization
* Agility
* Portability
* Fault isolation
* Speed
* Efficiency
* Ease of managemnt
* Security

The major difference between virtual machines and containers is that containers do not bundle in a copy of the operating system. Instead, the contianer runtime engine is istalled on the host system's operating system.

The most popular container platform is Docker and I will do a brief introduction.
Docker was introduced in 2013 to build and share containarized apps from desktop, to the cloud. Docker provides the ability to package and run an application in a loosely isolated environment called a container.

# Interesting and basic concepts to know
* Docker daemon - Listens for Docker API requests and manages docker objects such as images, containers, networks and volumes.
* Docker client (docker) - The primary way many users interact with Docker. 
* Docker registries - A place to store Docker images. Docker Hub is a public registry that anyone can use.
* Docker image - a read-only template with instructions for creating a Docker container. You can create your own images or use those created by others and published in a registry.
* Dockerfile - A set of instructions that Docker follows to create the necessary docker image. 
* Container - A runnable instance of an image. It is a single short lived instance of one task, process or application. A container can be created, started, stopped, moved or deleted using the Docker API or CLI.
* Docker Compose - Provides a way to deploy, coordinate or orchestrate multiple containers. The Docker Compose file is usually written in YAML format.

Now that we have explained some basic Docker concepts, time to move to the practical stuff.

# Task for the Week

THis week's task is to write a Docker Compose file to deploy any application with a Database. This will consists of a container hosting the NodeJS application and another container for the mySQL database. In essense, we will be working with two different containers and to this, we will need Docker Compose. These containers will be pushed to the Cloud.

### Create a NodeJS application

* Created a simple NodeJS application by running the commands ```npm init -y``` and ```npm i express```
* Created a index.js file with the NodeJS server code.
* Confirmed that the server is up and running by using the command ``` node index.js ```

### Add MYSQL database connection
* installed MYSQL using the command ```npm i mysql``` and ``npm i dotenv``` to store our database credentials without exposing it to git.

* created a database connection to our application in index.js file.

### Create Docker Compose file

As we discussed above, Docker Compose is used to deploy or orchestrate multiple containers. In our case, the database and the application will be in 2 different isolated containers. Docker Compose files are written in YAML format.
* Run ```touch docker-compose.yaml ``` to create the Docker Compose file.

* We will add the code below in the docker-compose.yaml file
```
version: "3.8"

services:
  backend:
    image: node:12-alpine
    command: sh -c "npm install && node index.js"
    working_dir: /app
    volumes:
      - ./:/app
    environment:
      DB_HOST: db
      DB_PORT:     "${DB_PORT}"
      DB_USER:     "${DB_USER}"
      DB_PASSWORD: "${DB_PASS}"
      DB_NAME:     "${DB_NAME}"
    ports:
      - "5000:5000"
    depends_on:
      - db # Wait until database service is loaded

  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: "${DB_ROOT_PASS}"
      MYSQL_DATABASE: "${DB_NAME}"
      MYSQL_USER:     "${DB_USER}"
      MYSQL_PASSWORD: "${DB_PASS}"
```

The ***docker-compose.yaml*** file contains 2 services; ***backend*** representing the NodeJS application and ***db*** for the database. 

* To start the services, we use the command ``` docker-compose up -d``` which starts the services in the backgroud. It will pull the respective images and create the containers. 

![docker-compose up](week3/images/docker-composeup.PNG)
* TO verify that the application is running, use ```curl localhost:5000``` or ```docker-compose logs -f ``` to watch the deployment output.
![application running](week3/images/applicationupandrunning.PNG)
### Upload the containers to the Cloud

We will upload to the application to Docker HUb.

* First, sign into https://hub.docker.com and create a repository. You can choose to make it public or private.

* Tag the repository by using the command ``` docker tag <exisitng-image> <docker-username/<repo-name>```

* Push to Docker hub using the command - ```docker push <docker-username>/<repo-name>```

* Link to DOcker Repository - https://hub.docker.com/repository/docker/chiamakaobitube/scacloudschool-week3