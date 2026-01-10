# Typing game

## Static Website Deployment with Terraform, Ansible, Docker, and Cloudflare

This project demonstrates a complete Infrastructure-as-Code (IaC) and CI/CD workflow to deploy a static website using **Terraform**, **Ansible**, **Docker**, and **Cloudflare Load Balancing** on **Google Cloud Platform (GCP)**.

The website files are served by **Nginx** running in Docker containers on two GCP virtual machines, fronted by a **Cloudflare Load Balancer** for high availability.

---

### Architecture Overview

- **Static website** served from the `./nginx/dist` directory
- **Dockerized Nginx** image to serve the static files. Both VMs pull the image from Docker Hub and launch the container
- **2 GCP VM instances** as backend endpoints
- **Cloudflare Load Balancer** distributing traffic across VMs
- **Terraform** for provisioning all infrastructure
- **Ansible** for VM configuration and application deployment
- **GitHub Actions** for CI/CD automation

---

### Project Structure

```text
.
├── ansible/
│   ├── playbook.yml        # Main Ansible playbook. Used to configure the VMs to run the Nginx container
├── terraform/
│   ├── main.tf             # Core infrastructure resources
│   ├── locals.tf           # Terraform locals
│   ├── lb.tf               # Cloudflare load balancer configuration
│   ├── providers.tf        # Defines providers (google and cloudflare)
│   ├── variables.tf        # Terraform variables
│   ├── vm.tf               # Define VMs configuration
│   ├── vpc.tf              # Define VPC configuration
│   └── outputs.tf          # Terraform outputs
├── nginx/
|   ├── dist/               # Compiled static website files. The Typing Game was inspired from [HuXn-WebDev's HTML-CSS-JavaScript-100-Projects repository](https://github.com/HuXn-WebDev/HTML-CSS-JavaScript-100-Projects/tree/main/86.%20Typing%20Game).
│   ├── Dockerfile          # Nginx Docker image definition
│   └── nginx.conf          # Nginx configuration
├── .github/workflows/
│   ├── build-image.yml     # Build & push Docker image
│   └── deploy.yml          # Terraform & Ansible deployment
├── .gitignore              
└── README.md
```
