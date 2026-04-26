# Talos + OpenTofu + Proxmox : l'infra Kubernetes immutable, automatisée et sécurisée

## 📋 Résumé

À l'heure où l'IA facilite considérablement la compromission d'une infrastructure, laisser un cluster Kubernetes tourner sur un OS généraliste n'est plus une dette technique, c'est un risque opérationnel concret.

SSH ouvert, système modifiable à la main, configuration jamais auditée : autant de vecteurs d'attaque qui s'accumulent sans que personne ne s'en aperçoive.

Talos Linux change radicalement l'approche : un OS immutable, sans shell, sans SSH, piloté exclusivement par API, conçu spécifiquement pour faire tourner Kubernetes de façon sécurisée. Entièrement déclarative et versionnable, la configuration de chaque nœud est auditable et ne peut pas dériver (que vous veniez d'une infra managée, d'un Ansible bien rodé ou d'un cluster vanilla). La migration est simple, la dette créée est quasi nulle, et Talos reste flexible : il s'installe partout, cloud comme on-premise, et s'intègre à votre stack existante.

Dans ce talk, on démarre from-scratch avec Talos (quelques commandes suffisent) avant de voir comment aller plus loin avec votre propre outillage. OpenTofu et Proxmox seront nos exemples du jour, mais l'approche est la même avec Terraform, Pulumi, Ansible, AWS ou bare metal : bring your own stack.

On verra concrètement en quoi Talos diffère d'une installation vanilla, pourquoi c'est sécurisé by design, et comment cette approche change le quotidien d'une équipe.

Ce talk s'adresse à toute personne qui opère ou souhaite opérer des clusters Kubernetes en production, et qui veut aller plus loin dans la sécurisation de son infrastructure.

## 🎤 Informations pratiques

| Critère | Valeur |
|---|---|
| **Niveau** | Intermédiaire |
| **Durée** | 30 minutes |
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
│   └── slides.md          # Présentation Slidev
├── demo/
│   ├── opentofu/          # Code OpenTofu (Proxmox + Talos provider)
│   └── talos-config/      # Exemples de machineconfig Talos
└── scripts/
    └── demo.sh            # Script demo-magic
```

## 🚀 Lancer les slides

```bash
cd slides
npm install
npm run dev
```

> Requiert Node.js >= 20.12.0

## 🔧 Stack utilisée

| Outil | Version | Usage |
|---|---|---|
| [Talos Linux](https://www.talos.dev) | v1.9+ | OS Kubernetes immutable |
| [OpenTofu](https://opentofu.org) | v1.12+ | IaC |
| [Proxmox](https://www.proxmox.com) | v8+ | Hyperviseur |
| [Slidev](https://sli.dev) | latest | Slides |
| [demo-magic](https://github.com/paxtonhare/demo-magic) | latest | Démo live |

## 🔗 Pour aller plus loin

- [talos.dev](https://www.talos.dev) — Documentation officielle Talos
- [factory.talos.dev](https://factory.talos.dev) — Image Factory (extensions)
- [calmops.fr](https://calmops.fr) — Mon blog

## 👤 Auteur

**Mikael Batard** — SRE @ CBA Informatique Libérale

💼 [linkedin.com/in/mbatard](https://www.linkedin.com/in/mbatard/)

🦋 [@mbatard.bsky.social](https://bsky.app/profile/mbatard.bsky.social)

🐙 [github.com/mbatard](https://github.com/mbatard)

🌐 [calmops.fr](https://calmops.fr)
