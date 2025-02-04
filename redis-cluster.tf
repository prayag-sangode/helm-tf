resource "helm_release" "redis-cluster" {
  name             = "redis-cluster"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart           = "redis"
  version          = "20.7.0"
  namespace        = "redis-cluster"
  create_namespace = true

  values = [
    <<-EOT
    master:
      persistence:
        enabled: false

    replica:
      persistence:
        enabled: false

    metrics:
      enabled: true

      serviceMonitor:
        enabled: true
        port: http-metrics
        namespace: "monitoring"
        labels:
          release: "kube-prometheus-stack"
    EOT
  ]
}

