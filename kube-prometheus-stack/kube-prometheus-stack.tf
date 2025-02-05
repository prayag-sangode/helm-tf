# Install Kube-Prometheus Stack with Helm (Prometheus, Grafana, Alertmanager)
resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    <<EOF
prometheus:
  service:
    type: LoadBalancer
  persistence:
    enabled: true
    size: 8Gi

grafana:
  adminPassword: admin123 # Set Grafana admin password here
  service:
    type: LoadBalancer
  persistence:
    enabled: true
    size: 8Gi

alertmanager:
  enabled: true
  service:
    type: LoadBalancer
  persistence:
    enabled: true
    size: 8Gi
EOF
  ]
}

