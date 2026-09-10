resource "helm_release" "cilium" {
  name       = "cilium"
  namespace  = "kube-system"

  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.20.1"

  values = [
    file("${path.module}/helm/cilium-values.yaml")
  ]

  wait    = true
  timeout = 600
}

resource "helm_release" "traefik" {
  name             = "traefik"
  namespace        = "traefik-system"
  create_namespace = true

  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "41.4.0"

  values = [
    file("${path.module}/helm/traefik-values.yaml")
  ]

  wait    = true
  timeout = 600

  depends_on = [
    helm_release.cilium,
    kubernetes_manifest.cilium_lb_pool,
    kubernetes_manifest.cilium_l2_policy
  ]
}
