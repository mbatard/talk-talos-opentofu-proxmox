terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "3.3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "3.2.1"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
