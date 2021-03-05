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

### Step 2: Create the GitHub workflow.

```
name: Node.js CI

on:
  push:
    branches: [ master ]
  pull_request:
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

  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: SSH and deploy node app
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.HOST }}
        username: ${{ secrets.USERNAME }}
        key: ${{ secrets.KEY }}
        port: ${{ secrets.PORT }}
        
        script: |
          cd ~/devyapp
          git pull origin master
          npm install --production
          pm2 restart all
        
```
The workflow is set to run