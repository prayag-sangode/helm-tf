# Deploy and Monitor Redis on K8s

## Overview
This repository contains Terraform Helm code to deploy a Redis cluster and monitor it using Prometheus and Grafana.

## Prerequisites
Before applying the Terraform configurations, ensure you have the following installed:

1. **Terraform** – Install Terraform using the following script:
   ```sh
   curl -fsSL https://raw.githubusercontent.com/prayag-sangode/config-scripts/refs/heads/main/terraform/terraform-install-bin.sh | bash
   ```
2. **Kubectl** – Ensure you have `kubectl` installed and configured to interact with your Kubernetes cluster.
3. **Helm** – Install Helm to manage Kubernetes applications.
4. **Kubernetes Cluster** – A running Kubernetes cluster where Redis and monitoring components will be deployed.

## Deploying Redis Cluster
To deploy the Redis cluster using Terraform, execute:

```sh
terraform init
terraform apply -auto-approve
```

## Testing Deployment

### Verify `maxmemory` Configuration
1. Retrieve the Redis password:
   ```sh
   kubectl -n redis-cluster get secret redis-cluster -o yaml
   ```
2. Deploy a test pod:
   ```sh
   kubectl create deployment nginx-test-deployment --image=nginx
   ```
3. Access the pod:
   ```sh
   kubectl exec -it pod/nginx-test-deployment-<pod-id> -- /bin/bash
   ```
4. Install Redis CLI:
   ```sh
   apt-get update && apt-get install -y redis-tools
   ```
5. Connect to Redis:
   ```sh
   redis-cli -h redis-cluster-master.redis-cluster.svc.cluster.local -p 6379
   ```
6. Authenticate and check maxmemory:
   ```sh
   AUTH <password>
   OK
   CONFIG GET maxmemory
   ```

### Verify Metrics
Check Redis metrics using the following URL:
```
http://redis-cluster-metrics.redis-cluster.svc.cluster.local:9121/metrics
```

### Increase Load on Redis
Run the following benchmark test to simulate load:
```sh
redis-benchmark -h redis-cluster-master.redis-cluster.svc.cluster.local -p 6379 -a <password> -n 100000 -c 50
```

