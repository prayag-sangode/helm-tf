resource "helm_release" "redis-cluster" {
  name             = "redis-cluster"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "redis"
  version          = "20.7.0"
  namespace        = "redis-cluster"
  create_namespace = true
  depends_on = [helm_release.kube_prometheus_stack]

  values = [
    <<-EOT
    master:
      persistence:
        enabled: false
      resources:
        limits:
          cpu: 150m
          ephemeral-storage: 1Gi
          memory: 192Mi
        requests:
          cpu: 100m
          ephemeral-storage: 50Mi
          memory: 128Mi
      extraFlags:
        - "--maxmemory 153600000"
        - "--maxmemory-policy allkeys-lru"

    replica:
      persistence:
        enabled: false
      resources:
        limits:
          cpu: 150m
          ephemeral-storage: 1Gi
          memory: 192Mi
        requests:
          cpu: 100m
          ephemeral-storage: 50Mi
          memory: 128Mi
      extraFlags:
        - "--maxmemory 153600000"
        - "--maxmemory-policy allkeys-lru"

    metrics:
      enabled: true
      serviceMonitor:
        enabled: true
        namespace: "monitoring"  # Ensure this matches your Prometheus namespace
        interval: 30s
        scrapeTimeout: 10s
        port: http-metrics
        additionalLabels:
          release: "kube-prometheus-stack"
    EOT
  ]
}
