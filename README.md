# Terraform Helm Repository

## Overview
This repository contains Terraform Helm configurations to deploy various components in a Kubernetes cluster. The following modules are available:

1. **Ingress & Cert-Manager** - Deploys Nginx Ingress Controller and Cert-Manager for managing ingress and SSL certificates.
2. **Kube-Prometheus-Stack** - Deploys Prometheus, Grafana, and Alertmanager for cluster monitoring.
3. **Redis Cluster & Monitoring** - Deploys a Redis cluster along with monitoring setup.
4. **Redis Cluster** - Deploys a standalone Redis cluster without monitoring.

## Prerequisites
Before deploying any module, ensure the following tools are installed:

1. **Terraform** – Install Terraform using the following script:
   ```sh
   curl -fsSL https://raw.githubusercontent.com/prayag-sangode/config-scripts/refs/heads/main/terraform/terraform-install-bin.sh | bash
   ```
2. **Kubectl** – Ensure `kubectl` is installed and configured for your Kubernetes cluster.
3. **Helm** – Install Helm for managing Kubernetes applications.
4. **A Running Kubernetes Cluster** – Make sure you have a working Kubernetes cluster.

## Deployment Instructions
Each folder contains Terraform configurations for different components. Navigate to the required folder and deploy using Terraform.

### 1. Deploy Ingress & Cert-Manager
```sh
cd ingress-certmanager
terraform init
terraform apply -auto-approve
```

### 2. Deploy Kube-Prometheus-Stack
```sh
cd kube-prometheus-stack
terraform init
terraform apply -auto-approve
```

### 3. Deploy Redis Cluster with Monitoring
```sh
cd redis-cluster-monitoring
terraform init
terraform apply -auto-approve
```

### 4. Deploy Redis Cluster (Standalone)
```sh
cd redis-cluster
terraform init
terraform apply -auto-approve
```

## Verification
After deploying, verify the components using `kubectl`:

### Check Installed Helm Releases
```sh
helm list -A
```

### Verify Pods
```sh
kubectl get pods -A
```

## Cleanup
To remove a deployed component, navigate to the respective directory and run:
```sh
terraform destroy -auto-approve
```

