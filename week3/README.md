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
* Docker iamge - a read-only template with instructions for creating a Docker container. You can create your own images or use those created by others and published in a registry.
* Dockerfile - A set of instructions that Docker follows to create the necessary docker image. 
* Container - A runnable instance of an image. It is a single short lived instance of one task, process or application. A container can be created, started, stopped, moved or deleted using the Docker API or CLI.
* Docker Compose - Provides a way to deploy, coordinate or orchestrate multiple containers.
