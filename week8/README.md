Week 8 Tasks

Week 8 task is to demonstrate the understanding of using Kubernetes for container orchestration.

## What is Kubernetes

Kubernetes is described as a portable, extensible, open-source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. Kubernetes is originally a project from Google which was open-sourced in 2014.

## What can Kubernetes do?
To understand the capabilities of Kubernetes, let us explore containers. Containers are a good way to bundle or application and its dependencies without the underlying hardware. With containers, the container runtime engine is installed on the host system's operating system. This makes containers lightweight and is portable accross many platforms and operating systems.

In a typical production environment, we would be deploying our applications accross multiple containers and how do we ensure the administration of these multiple containers to ensure that our application is running without downtime.

Kubernetes provides you with a framework to run distributed systems resiliently. It takes care of scaling and failover for your application, provides deployment patterns, and more. For example, Kubernetes can easily manage a canary deployment for your system.

### Benefits of Kubernetes
* It is open source
* It can be used to deploy any application.
* It is self healing.
* It is portable and flexible
* It helps to control and automate deployments and update of distributed applications.

### Basic Kubernetes Components
* Cluster- The cluster is a set of physical/virtual machines or servers where all Kubernetes components, capabilities, and workloads are configured. A cluster consists of a set of worker machines, called nodes, that run containerized applications. Every cluster has at least one worker node. The worker node(s) host the Pods that are the components of the application workload. A cluster can also have a master and a worker node.
* Node - A worker machine in Kubernetes
* Pod - A pod represents a set of running containers in a cluster.
* kubectl - The command line tool to run Kubernetes.
* Service -  A Service is a load balancer for a collection of Pods.
* Deployment - A Deployment provides declarative updates for Pods and ReplicaSets.

### Week 8 Task

This week's taks is to deploy a PHP application with Kubernetes.
For this, we will need a dockerized PHP application, kubectl and minikube.

Minikube is a local Kubernetes environment that allows us create and manage Kubernetes cluster(s).
#### Step 1: Install Minikube, Docker and Kubectl

#### Step 2: Create a Cluster
    Run ```minikube start```

#### Step 3: Create a Deployment
 * The dockerized image has been pushed to Docker Hub and available at chiamakaobitube/kubernetes-php.
 * Run ```nano deployment.yaml``` to create  deployment file.
 * Copy and paste the below

 ```
deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubernetes-php
spec:
  selector:
    matchLabels:
      run: kubernetes-php
  template:
    metadata:
      labels:
        run: kubernetes-php
    spec:
      containers:
        - name: demo
          image: chiamakaobitube/kubernetes-php
          ports:
            - containerPort: 80
          env:
            - name: APP_KEY
              value: base64:cUPmwHx4LXa4Z25HhzFiWCf7TlQmSqnt98pnuiHmzgY=
```
* Submit the Deployment to the Cluster
```kubectl apply -f deployment.yaml```

#### Step 4: Check if the application is running
``` kubectl get pods```

#### Step 5: Expose the App
* We will create a Service to expose the app on a static IP address such that if the application is updated or redeployed, the IP will not change. 
```kubectl expose pods kubernetes-php --type=NodePort --port=80```

* To verify that the service was created.
```kubectl get services```

#### Step 6: Scale the App
* At this moment, we have just a single instance of our application running. We want to have a t least 3 instances of our application running at all time. 
```kubectl scale --replicas=3 deployment/kubernetes-php```
* To confirm this , run ```kubectl get deployments.pods```
Now our application is running in 3 instances.


