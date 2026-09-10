resource "kubernetes_namespace_v1" "whoami" {
  metadata {
    name = "whoami"
  }
}

resource "kubernetes_deployment_v1" "whoami" {
  metadata {
    name      = "whoami"
    namespace = kubernetes_namespace_v1.whoami.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "whoami"
      }
    }

    template {
      metadata {
        labels = {
          app = "whoami"
        }
      }

      spec {
        container {
          name  = "whoami"
          image = "traefik/whoami"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "whoami" {
  metadata {
    name      = "whoami"
    namespace = kubernetes_namespace_v1.whoami.metadata[0].name
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "whoami"
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_manifest" "whoami_ingressroute" {
  manifest = {
    apiVersion = "traefik.io/v1alpha1"
    kind       = "IngressRoute"

    metadata = {
      name      = "whoami"
      namespace = kubernetes_namespace_v1.whoami.metadata[0].name
    }

    spec = {
      entryPoints = [
        "web"
      ]

      routes = [
        {
          match = "Host(`demo-meetup.calmops.fr`)"
          kind  = "Rule"

          services = [
            {
              name = kubernetes_service_v1.whoami.metadata[0].name
              port = 80
            }
          ]
        }
      ]
    }
  }
}
