# Overview

This repository aims to simplify seting up [localstack](https://github.com/localstack/localstack) on a Mac or Linux distribution. Once localstack is installed, you can use the provided Terraform scripts to setup some basic infrastructure to test on your local system. More Terraform resources will be added in the future!

## Prerequisites

The `setup.sh` script makes extensive use of [Homebrew](https://brew.sh/) to install dependencies and packages and to run localstack. This script will attempt to install Homebrew for you if desired. Otherwise, install [Homebrew](https://brew.sh/) manually.

## Installation

To begin your local setup, clone this repository and cd into your newly cloned repository.

```
git@github.com:dhollerbach/examples.localstack.git

cd examples.localstack/
```

### Step 1: Install Localstack and DevOps Tools

To install localstack and its associated DevOps tools, run the following script:

```
./scripts/setup.sh
```

DevOps Tools Installed:
- awscli
- docker
- terraform

This script will install localstack, a few DevOps tools, and start localstack in the current Terminal. Upon successful completion, you will be prompted for your password If you ever lose your localstack connection - like if you close your terminal - you can reestablish the connection by opening a new terminal and running the following command:

```
localstack start
```

### Step 2: Run Terraform

To run Terraform against localstack, make sure your AWS provider is using the local endpoints recommended by localstack, http://localhost:4566. run the following commands:

```
cd terraform/

terraform init

terraform apply
```

### Step 3: Test Lambda

This repository creates an example lambda when Terraform is run. To test this lambda, run the following the script:

```
./scripts/test.sh
```

## Delete Localstack Environment

To delete your localstack environment, simple close the terminal running localstack or use `CMD + c`. Be sure to delete any Terraform files created during the process if you no longer want them.
