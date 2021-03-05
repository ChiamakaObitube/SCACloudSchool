# Week 5 Task

Week 5 task is to demonstrate the understanding of cloud computing technologies and continuous integration and deployment of an application to Heroku.

For this task, I have decided to use Github Actions to deploy a NodeJS application to Heroku.

## Continuous Integration and Continuous Deployment

Continuous Integration and Continuous Deployment are two of the pillars that make up the broader DevOps practices. Continuous integration is the practice where developers integrate code into a shared repository and each integrated code is checked through automated builds and tests. This is done to prevent introducing errors and bugs into the code. Continuous Deployment is the automated process of deploying the integrated code to production.

## Github Actions
GitHub Actions is a CI tool that allows you to automate tasks within your software development cycle right from your GitHub repository. GitHub Actions uses workflows to build the code and run your tests based on events  which can be scheduled (a push event to the repository) or when an external event occurs using the repository dispatch webhook.
A workflow is an automated procedure that you add to your repository. Workflows are made up of one or more jobs and can be scheduled or triggered by an event. The workflow can be used to build, test, package, release, or deploy a project on GitHub.
 Workflow contains jobs which are a set of steps that can be executed on the same runner.

 A step is an individual task that can run commands in a job. A step can be either an action or a shell command. Each step in a job executes on the same runner, allowing the actions in that job to share data with each other.

 Actions are standalone commands that are combined into steps to create a job. Actions are the smallest portable building block of a workflow
GitHub Actions uses YAML syntax to define the events, jobs, and steps. These YAML files are stored in your code repository, in a directory called .github/workflows.

## Prerequisites
* GitHub Account
* Heroku Account
* Dockerized NodeJS application hosted in a GitHub repository.

### Step 1: Test and confirm that application working locally.

Clone the repository ```git clone https://github.com/ChiamakaObitube/devyapp.git

### Step 2: Create an application on Heroku
#### Step 3: Generate an Heroku API key.
Because we want to automate the deployment of our application to Heroku, we need an API key to login to the Heroku container registry. We can use the Heroku CLI to create an authorization token (OAuth token) by using the command ```heroku authorizations:create```.

This will create a long-lived user authorization, whose token can be used to authenticate the Heroku CLI in our workflow.

This token will be stored as a GitHub secret and referenced in our workflow as an environment variable. The GitHUb secret can be found in the repository settings.

![github secret](/week5/images/githubsecret.png)

### Step 4: Create the GitHub workflow file
Each GitHub repository has an Actions Tab which we can use to setup our continuous integration workflow. The workflow file is hosted in the *.github/workflows* directory of your repository. Copy and add the code below in the yaml file. 

```
name: Node.js CI

on:
  push:
    branches: [ master ]

jobs:
  build:

    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [10.x, 12.x, 14.x, 15.x]
        # iSee supported Node.js release schedule at https://nodejs.org/en/about/releases/

    steps:
    - uses: actions/checkout@v2
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v1
      with:
        node-version: ${{ matrix.node-version }}
    - run: npm ci
    - run: npm run build --if-present
    - run: npm test --if-present
    - name: Login to Heroku Container registry
      env:
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      run: heroku container:login
    - name: Build and push
      env: 
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      run: heroku container:push -a devyapp web
    - name: Release
      env: 
        HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      run: heroku container:release -a devyapp web

        
```
The workflow defines 1 job **build** with 5 steps. 
* The first step ***checkout*** fetches the contents of the repository to $GITHUB_WORKSPACE, an environment variable that maps to /home/runner/work on the runner. 
* The second step includes a matrix strategy that builds and tests our code with four Node.js versions:builds our application on the different NodeJS versions. If you don't specify a Node.js version, GitHub uses the environment's default Node.js version. This step also installs the dependencies needed to run the application. Using npm ci installs the versions in the package-lock.json or npm-shrinkwrap.json file and prevents updates to the lock file. 
* The third step logs into the Heroku container registry using the HEROKU_API_KEY set in the Github secrets and referenced in our workflow as an environment variable.

* The fourth and fifth steps builds and releases our application to our Heroku app **devyapp** which was created earlier.

Workflow syntax gives us the ability to filter on branches, and files, as well as GitHub webhook events. For our application, we have defined our workflow to be triggered if there is a push event on the master branch. 

The workflow will be triggered once a code change has been commited and pushed to the master branch. It can take a few minutes for the deployment to be completed.

We can verify that our Heroku application is running by navigating to the URL of the app we created - https://devyapp.herokuapp.com/ 

![devyapp running on Heroku](/week5/images/herokuapp.png)