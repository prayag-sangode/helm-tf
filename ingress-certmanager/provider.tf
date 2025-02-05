# Define Kubernetes and Helm providers
provider "kubernetes" {
  config_path = "~/.kube/config" # Path to your kubeconfig file
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

