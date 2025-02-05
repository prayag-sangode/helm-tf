# Install NGINX Ingress Controller with Helm
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "ingress-nginx"
  create_namespace = true
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = [
    <<EOF
controller:
  service:
    type: LoadBalancer # Uses MetalLB for external IP allocation
EOF
  ]
}

