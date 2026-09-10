# Talos + OpenTofu + Proxmox : l'infra Kubernetes immuable, automatisée et sécurisée

## 📋 Résumé

A l'heure où l'IA facilite considérablement la compromission d'une infrastructure, laisser un cluster Kubernetes tourner sur un OS généraliste n'est plus une dette technique, c'est un risque opérationnel concret.
 
SSH ouvert, système modifiable à la main, configuration jamais auditée : autant de vecteurs d'attaque qui s'accumulent sans que personne ne s'en aperçoive.
 
**Talos Linux** change radicalement l'approche : un OS **immuable**, sans shell, sans SSH, piloté exclusivement par API, conçu spécifiquement pour faire tourner Kubernetes de façon sécurisée. Entièrement déclarative et versionnable, la configuration de chaque nœud est auditable et ne peut pas dériver.

Même si votre infrastructure est déjà automatisée avec Ansible, Puppet ou une solution managée, Talos apporte une expérience proche du Kubernetes managé, mais déployable sur votre propre stack, sans vous enfermer dans Proxmox, OpenTofu ou un cloud provider.
 
Dans ce talk, on va construire ensemble, de zéro, un cluster sous Talos, déployé sur **Proxmox** et entièrement automatisé avec **OpenTofu**. On verra concrètement en quoi Talos diffère d'une installation vanilla, pourquoi c'est sécurisé by design, et comment cette approche change le quotidien d'une équipe.
 
Ce talk s'adresse à toute personne qui opère ou souhaite opérer des clusters Kubernetes en production, et qui veut aller plus loin dans la sécurisation de son infrastructure.

## 🎤 Informations pratiques

| Critère | Valeur |
|---|---|
| **Niveau** | Intermédiaire |
| **Durée** | 45 min – 1 h |
| **Format** | Talk + démo live |
| **Langue** | Français |

## ✅ Pré-requis

- Connaître les concepts de base de Kubernetes (nodes, pods, control plane)
- Etre à l'aise avec la ligne de commande Linux
- Notions de base en infrastructure (VM, réseau) sont un plus

## 🗂️ Structure du repo

```
.
├── slides/
│   ├── slides.md              # Présentation Slidev (source)
│   ├── slides-standalone.html # Version HTML autonome, sans build
│   ├── public/                # QR codes, logos, images
│   └── dist/                  # Build statique (slidev build)
├── opentofu/
│   └── talos/
│       ├── .env               # Token API Proxmox, kubeconfig, talosconfig
│       ├── 01-proxmox-talos/          # VMs + Talos + bootstrap K8s
│       ├── 02-cilium-traefik/         # Cilium + Traefik via Helm
│       ├── 03-deploy-application/     # Application whoami
│       ├── 04-add-talos-worker-node/  # Ajout d'un worker
│       ├── 05-upgrade-talos-and-k8s/  # Paramètres d'upgrade Talos/Kubernetes
│       └── scripts/                   # Runbook démo (01-05), teardown (31-33), prerequisites
```

## 🖥️ Slides en ligne

- **Slides** : https://talks.calmops.fr/talk-talos-opentofu-proxmox_2026_CloudNativeAixMarseille.html
- **Sources** : https://github.com/mbatard/talk-talos-opentofu-proxmox

## 🚀 Lancer les slides

### Option 1 — Slidev (développement)

```bash
cd slides
npm install
npm run dev
```

> Requiert Node.js >= 20.12.0

### Option 2 — Version HTML autonome

Ouvrir directement `slides/slides-standalone.html` dans un navigateur, aucune dépendance ni build requis.

### Option 3 — Build statique

```bash
cd slides
npm install
npm run build    # génère slides/dist
npm run preview
```

## 🔧 Stack utilisée

| Outil | Version | Usage |
|---|---|---|
| [Talos Linux](https://www.talos.dev) | v1.9+ | OS Kubernetes immuable |
| [OpenTofu](https://opentofu.org) | v1.12+ | IaC |
| [Provider Proxmox (bpg)](https://registry.opentofu.org/providers/bpg/proxmox/latest/docs) | latest | Automatisation Proxmox |
| [Provider Talos (siderolabs)](https://registry.opentofu.org/providers/siderolabs/talos/latest/docs) | latest | Gestion des nœuds Talos |
| [Cilium](https://cilium.io) | latest | CNI |
| [Traefik](https://traefik.io) | latest | Ingress controller |
| [Proxmox](https://www.proxmox.com) | v8+ | Hyperviseur |
| [Slidev](https://sli.dev) | latest | Slides |

## 🎬 La démo

### Architecture

```
Serveur Proxmox
  |-- talos-cp-1    10.10.10.101
  |-- talos-cp-2    10.10.10.102
  |-- talos-cp-3    10.10.10.103
  |-- talos-wkr-1   10.10.10.111
  |-- VIP API       10.10.10.10
  `-- Traefik LB    10.10.10.200
```

### Le runbook en 5 étapes

Les scripts sont dans `opentofu/talos/scripts/` :

```bash
./scripts/01-proxmox-talos.sh         # VMs + Talos + bootstrap Kubernetes
./scripts/02-cilium-traefik.sh        # Cilium + Traefik via Helm
./scripts/03-deploy-application.sh    # Application whoami
./scripts/04-add-talos-worker-node.sh # Ajout d'un worker Talos
./scripts/05-upgrade-talos.sh         # Upgrade Talos
./scripts/05-upgrade-k8s.sh           # Upgrade Kubernetes
```

### Nettoyage

```bash
./scripts/31-remove-application.sh
./scripts/32-remove-cilium-traefik.sh
./scripts/33-remove-proxmox-talos.sh
```

### Prérequis machine

Des scripts de préparation sont disponibles dans `opentofu/talos/scripts/prerequisites/` : installation de `opentofu`, `talosctl`, `kubectl`, `helm`, `cilium-cli`, `k9s`, `jq`, création du token API Proxmox, alias dans `.bashrc`.

## 🔗 Pour aller plus loin

- [Slides en ligne](https://talks.calmops.fr/talk-talos-opentofu-proxmox_2026_CloudNativeAixMarseille.html)
- [Sources du talk (GitHub)](https://github.com/mbatard/talk-talos-opentofu-proxmox)
- [talos.dev](https://www.talos.dev) — Documentation officielle Talos
- [factory.talos.dev](https://factory.talos.dev) — Image Factory (extensions)

## 👤 Auteur

**Mikael Batard** — SRE @ CBA Informatique Libérale

💼 [linkedin.com/in/mbatard](https://www.linkedin.com/in/mbatard/)

🦋 [@mbatard.bsky.social](https://bsky.app/profile/mbatard.bsky.social)

🐙 [github.com/mbatard](https://github.com/mbatard)

🌐 [calmops.fr](https://calmops.fr)
