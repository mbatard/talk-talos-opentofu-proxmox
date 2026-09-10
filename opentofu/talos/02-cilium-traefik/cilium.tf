resource "kubernetes_manifest" "cilium_lb_pool" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumLoadBalancerIPPool"

    metadata = {
      name = "traefik"
    }

    spec = {
      blocks = [
        {
          start = var.traefik_loadbalancer_ip
          stop  = var.traefik_loadbalancer_ip
        }
      ]
    }
  }

  depends_on = [
    helm_release.cilium
  ]
}

resource "kubernetes_manifest" "cilium_l2_policy" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumL2AnnouncementPolicy"

    metadata = {
      name = "traefik"
    }

    spec = {
      serviceSelector = {
        matchLabels = {
          "app.kubernetes.io/name" = "traefik"
        }
      }

      interfaces = [
        "^eth0$"
      ]

      externalIPs     = false
      loadBalancerIPs = true
    }
  }

  depends_on = [
    helm_release.cilium
  ]
}
