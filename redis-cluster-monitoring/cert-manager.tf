
# Install Cert-Manager with Helm
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  values = [
    <<EOF
installCRDs: true # Automatically install CRDs required by Cert-Manager
EOF
  ]
}

