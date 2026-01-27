# Fully Automated Cloud Deployment with Terraform and Docker

## Project Overview

This repository demonstrates a production-grade DevOps workflow for deploying a globally accessible application using AWS EC2, Terraform, Docker, Linux automation, and MongoDB Atlas.

The primary objective is to achieve a zero-manual, reproducible deployment pipeline in which infrastructure provisioning and application startup occur automatically after every `terraform apply`.

---

## Key DevOps Objectives

* Automate infrastructure provisioning using Infrastructure as Code (Terraform)
* Containerize application services using Docker for portability and consistency
* Enable automatic service startup on EC2 using user data scripts
* Implement stateless compute with persistent cloud-based storage
* Ensure public and global accessibility of the deployed application
* Support a destroy → apply → redeploy workflow with no manual intervention

---

## DevOps Tools and Technologies

| Category               | Tools               |
| ---------------------- | ------------------- |
| Cloud Provider         | AWS EC2             |
| Infrastructure as Code | Terraform           |
| Containerization       | Docker              |
| Automation             | EC2 User Data       |
| Operating System       | Linux (Ubuntu)      |
| Database               | MongoDB Atlas       |
| Networking             | AWS Security Groups |
| Version Control        | Git and GitHub      |

---

## High-Level Architecture

```
GitHub Repository
      ↓
Terraform Provisioning (IaC)
      ↓
AWS EC2 Instance Creation
      ↓
Docker Installation
      ↓
Docker Image Pull
      ↓
Container Auto-Run
      ↓
Application Available Globally
```

---

## Repository Structure

```
project-root/
│
├── terraform/        # Infrastructure as Code files
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── security.tf
│
├── docker/           # Docker build configuration
│   └── Dockerfile
│
├── app/              # Full application source code
│
├── .env.example      # Environment variable template
├── .gitignore        # Git ignore rules
└── README.md         # Project documentation
```

---

## Automated Deployment Workflow

### Step 1 — Build Docker Image

```bash
docker build -t realcode:02 .
```

### Step 2 — Push Image to Docker Hub

```bash
docker tag realcode:latest sjmandal/realcode:02
docker push sjmandal/realcode:02
```

### Step 3 — Provision Infrastructure Using Terraform

```bash
cd terraform
terraform init
terraform apply
```

### Step 4 — Access the Application

```
http://EC2_PUBLIC_IP:3000
```

---

## EC2 User Data Automation Script

The following script ensures Docker installation, image pulling, and automatic container startup on every EC2 launch:

```bash
#!/bin/bash
set -e

apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker

docker pull sjmandal/realcode:02

docker rm -f realcode || true

docker run -d -p 80:3000 -e NODE_ENV=production -e MONGO_URL="mongodb+srv://sjmandal2415_db_user:sjmandal2415_db_user@cluster0.iq6pvqp.mongodb.net/?appName=Cluster0" --name realcode sjmandal/realcode:02
```

---

## Major Challenges Encountered and Solutions

### Issue: Application Not Accessible Publicly

**Cause:** Server bound to localhost only

**Resolution:**

```
hostname = "0.0.0.0"
```

---

### Issue: Real-Time Synchronization Failed Across Devices

**Cause:** Client socket was configured to connect to localhost

**Resolution:**

```
io(window.location.origin)
```

---

### Issue: MongoDB Atlas Connection Failures

| Root Cause                        | Resolution                  |
| --------------------------------- | --------------------------- |
| Environment variables not loading | Proper dotenv configuration |
| Authentication failures           | Credential reset            |
| IP restrictions                   | Whitelisted 0.0.0.0/0       |

---

### Issue: Docker Image Not Updating After Code Changes

**Resolution:** Rebuilt and repushed Docker images before deployment

---

### Issue: Terraform Rebuild Reset Server Configuration

**Resolution:** Implemented Docker auto-start via EC2 user data

---

## Demonstrated DevOps Capabilities

* Infrastructure as Code and automated provisioning
* Fully reproducible deployments with zero manual configuration
* Container lifecycle management using Docker
* Secure cloud networking and firewall configuration
* Stateless compute with persistent managed database
* Production-ready automation workflows

---

## Project Summary

Designed and deployed a fully automated cloud infrastructure using Terraform and Docker on AWS EC2. Implemented containerized application deployment with automatic startup, persistent cloud database integration, and globally accessible services using Infrastructure as Code principles.

---

## Potential Future Enhancements

* CI/CD pipeline implementation using GitHub Actions
* HTTPS enablement with custom domain integration
* Load balancing and auto-scaling using AWS services
* Monitoring and observability with Prometheus and Grafana

---

## Author

SJ Mandal
