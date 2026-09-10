---
theme: default
title: "Talos + OpenTofu + Proxmox"
info: |
  Talos + OpenTofu + Proxmox : l'infra Kubernetes immuable, automatisée et sécurisée.
class: text-left
drawings:
  persist: false
transition: slide-left
mdc: true
---

<style>
:root {
  --paper: #ffffff;
  --ink: #23302e;
  --muted: #75817d;
  --sage: #7fa889;
  --sage-soft: #e7f0e8;
  --lavender: #8b7ac7;
  --lavender-soft: #eeeafa;
  --coral: #e88f72;
  --sand: #f4eadc;
  --line: rgba(35, 48, 46, .10);
}
.slidev-layout {
  position: relative;
  overflow: hidden;
  color: var(--ink);
  background: var(--paper);
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
}
.slidev-layout > * {
  position: relative;
  z-index: 1;
}
.slidev-layout h1 {
  color: var(--ink);
  font-size: 4.4rem;
  font-weight: 600;
  letter-spacing: -.018em;
  line-height: 1.15;
  text-wrap: balance;
  max-width: 86%;
}
.slidev-layout h2,
.slidev-layout h3 {
  color: var(--ink);
  font-size: 2.7rem;
  font-weight: 560;
  letter-spacing: -.01em;
  line-height: 1.3;
}
.slidev-layout h3 {
  font-size: 2.2rem;
}
.slidev-layout p,
.slidev-layout li,
.slidev-layout td {
  color: var(--ink);
  font-size: 1.75rem;
  line-height: 1.6;
}
.slidev-layout ul li,
.slidev-layout ol li {
  margin-bottom: .45rem;
}
.slidev-layout strong,
.slidev-layout b {
  color: var(--lavender);
}
.slidev-layout code {
  background: rgba(139, 122, 199, .10);
  color: var(--ink);
  border: 1px solid rgba(139, 122, 199, .22);
  border-radius: .45rem;
  padding: .08rem .35rem;
}
.slidev-layout pre {
  background: #27312f !important;
  color: #f8f5ef !important;
  border: 0;
  border-radius: 1.1rem;
  box-shadow: 0 18px 45px rgba(35, 48, 46, .12);
  font-size: 1.35rem;
  line-height: 1.6;
}
.slidev-layout table {
  overflow: hidden;
  border-radius: 1.2rem;
  background: rgba(255, 255, 255, .58);
  border: 1px solid rgba(35, 48, 46, .10);
  box-shadow: 0 18px 50px rgba(35, 48, 46, .08);
  font-size: 1.65rem;
}
.slidev-layout th {
  color: var(--ink);
  background: var(--sage-soft);
}
.slidev-layout td,
.slidev-layout th {
  border-color: rgba(35, 48, 46, .10);
}
.slidev-layout ul li::marker,
.slidev-layout ol li::marker {
  color: var(--sage);
  font-weight: 700;
}
.slidev-layout:first-child {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.talk-card {
  border: 1px solid rgba(35, 48, 46, .10);
  border-radius: 1.25rem;
  padding: 1.15rem 1.25rem;
  background: rgba(255, 255, 255, .58);
  box-shadow: 0 16px 42px rgba(35, 48, 46, .07);
  backdrop-filter: blur(8px);
}
.talk-kicker {
  color: var(--lavender);
  font-weight: 720;
  letter-spacing: .14em;
  text-transform: uppercase;
  font-size: 1.05rem;
}
.slidev-layout::after {
  content: "";
  position: absolute;
  right: 1.2rem;
  top: 1.2rem;
  width: 4rem;
  height: 4rem;
  background-image: url('/cloud-native-aix-marseille.webp');
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
  opacity: .78;
  padding: .35rem;
  border-radius: 1rem;
  background-color: rgba(255, 255, 255, .54);
  box-shadow: 0 10px 30px rgba(35, 48, 46, .08);
}
.title-logo {
  width: 10rem;
  height: 7rem;
  margin-bottom: 1.2rem;
  background-image: url('/cloud-native-aix-marseille.webp');
  background-size: contain;
  background-repeat: no-repeat;
  background-position: left center;
  padding: .4rem;
  border-radius: 1rem;
  background-color: rgba(255, 255, 255, .56);
  box-shadow: 0 12px 34px rgba(35, 48, 46, .08);
}
.family-photo {
  width: 30rem;
  height: 20rem;
  margin-top: 1.2rem;
  border-radius: 0;
  border: none;
  background-image: url('/family.jpg');
  background-size: contain;
  background-position: center;
  background-repeat: no-repeat;
  background-color: transparent;
  box-shadow: none;
}
.intro-grid {
  display: grid;
  grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
  gap: 2.4rem;
  align-items: start;
  margin-top: 0;
}
.intro-side {
  display: flex;
  flex-direction: column;
  gap: 3rem;
  min-height: 26rem;
}
.intro-where {
  margin-top: auto;
}
.name-faq {
  color: var(--muted);
  font-size: .62em;
  margin-left: .8rem;
  white-space: nowrap;
}
.links a {
  color: var(--sage);
  font-weight: 600;
  text-decoration: none;
}
.links a:hover {
  text-decoration: underline;
}
.intro-grid .family-photo {
  width: 100%;
  height: 17rem;
  background-position: left center;
}
.ask-slide {
  padding-top: 2.5rem;
}
.ask-slide h1 {
  margin-top: 0;
}
.ask-slide ul {
  margin-top: 2.4rem;
}
.text-center h1,
.text-center h2 {
  margin-left: auto;
  margin-right: auto;
}
.fake-qr {
  width: 150px;
  height: 150px;
  border: 8px solid var(--ink);
  border-radius: 1rem;
  background:
    linear-gradient(90deg, var(--ink) 14px, transparent 14px) 16px 16px / 38px 38px,
    linear-gradient(var(--ink) 14px, transparent 14px) 16px 16px / 38px 38px,
    conic-gradient(from 90deg, var(--ink) 90deg, #fffaf0 0 180deg, var(--ink) 0 270deg, #fffaf0 0) 0 0 / 24px 24px;
  image-rendering: pixelated;
  box-shadow: 0 18px 40px rgba(35, 48, 46, .12);
}
</style>

# Talos + OpenTofu + Proxmox

## L'infra Kubernetes immuable, automatisée et sécurisée

<!--
Objectif : annoncer une démo concrète. On part d'un Proxmox vide et on arrive à un cluster Kubernetes utilisable.
-->

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;
- avec des VMs Talos ;

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;
- avec des VMs Talos ;
- provisionnées par OpenTofu ;

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;
- avec des VMs Talos ;
- provisionnées par OpenTofu ;
- avec un CNI (Container Network Interface) : Cilium ;

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;
- avec des VMs Talos ;
- provisionnées par OpenTofu ;
- avec un CNI (Container Network Interface) : Cilium ;
- avec un ingress controller : Traefik ;

---

# Quoi ?

On va déployer un cluster Kubernetes :

- sur un serveur ProxmoxVE (Kimsufi @OVHcloud) ;
- avec des VMs Talos ;
- provisionnées par OpenTofu ;
- avec un CNI (Container Network Interface) : Cilium ;
- avec un ingress controller : Traefik ;
- avec une application web pour le fun.

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;

</div>
<div></div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;

</div>
<div></div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;
- ❤️ Kubernetes (Talos), GitOps, la sécurité ;

</div>
<div></div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;
- ❤️ Kubernetes (Talos), GitOps, la sécurité ;
- @home : infra hybride avec 2 chiens haute dispo et 2 tortues à latence élevée ;

<div class="family-photo" aria-label="Photo famille"></div>

</div>
<div></div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;
- ❤️ Kubernetes (Talos), GitOps, la sécurité ;
- @home : infra hybride avec 2 chiens haute dispo et 2 tortues à latence élevée ;

<div class="family-photo" aria-label="Photo famille"></div>

</div>
<div class="intro-side">
<div>

# Quand ?

- Le jour : Ops qui automatise l'infra, observe la prod, pour ne pas être réveillé la nuit ;

</div>
<div></div>
</div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;
- ❤️ Kubernetes (Talos), GitOps, la sécurité ;
- @home : infra hybride avec 2 chiens haute dispo et 2 tortues à latence élevée ;

<div class="family-photo" aria-label="Photo famille"></div>

</div>
<div class="intro-side">
<div>

# Quand ?

- Le jour : Ops qui automatise l'infra, observe la prod, pour ne pas être réveillé la nuit ;
- La nuit : ... ;

</div>
<div></div>
</div>
</div>

---
class: intro-slide
---

<div class="intro-grid">
<div>

# Qui ?

- Mikael Batard ;
- SRE @ CBA Informatique Libérale ;
- ❤️ Kubernetes (Talos), GitOps, la sécurité ;
- @home : infra hybride avec 2 chiens haute dispo et 2 tortues à latence élevée ;

<div class="family-photo" aria-label="Photo famille"></div>

</div>
<div class="intro-side">
<div>

# Quand ?

- Le jour : Ops qui automatise l'infra, observe la prod, pour ne pas être réveillé la nuit ;
- La nuit : ... ;

</div>
<div class="intro-where">

# Où ?

- Près d'Avignon
- LinkedIn : `linkedin.com/in/mbatard`
- Bluesky : `@mbatard.bsky.social`
- GitHub : `github.com/mbatard`
- Site : `calmops.fr`

</div>
</div>
</div>

---
class: ask-slide
---

# Et vous ?

---
class: ask-slide
---

# Et vous ?

- Qui utilise Proxmox ?

---
class: ask-slide
---

# Et vous ?

- Qui utilise Proxmox ?
- Qui utilise Terraform ou OpenTofu ?

---
class: ask-slide
---

# Et vous ?

- Qui utilise Proxmox ?
- Qui utilise Terraform ou OpenTofu ?
- Qui utilise Talos ?

---
class: ask-slide
---

# Et vous ?

- Qui utilise Proxmox ?
- Qui utilise Terraform ou OpenTofu ?
- Qui utilise Talos ?
- Qui opère Kubernetes on premise ?

---
class: ask-slide
---

# Et vous ?

- Qui utilise Proxmox ?
- Qui utilise Terraform ou OpenTofu ?
- Qui utilise Talos ?
- Qui opère Kubernetes on premise ?
- Qui maintient encore des nœuds Kubernetes manuellement ?

<!--
Faire participer la salle et ajuster la profondeur. Si peu de Talos, définir plus lentement. Si beaucoup de Terraform, aller plus vite sur OpenTofu.
-->

---

# Disclaimer

Ce talk montre une architecture concrète.

- mon exemple tourne sur Proxmox, mais Talos peut tourner ailleurs ;
- je montre OpenTofu parce que le workflow est déclaratif et rejouable ;
- OpenTofu peut être remplacé par un autre outil d'IaC ;
- Talos peut être remplacé par ... ;
- Ma démo, mes IP, mes domaines = utilisez les vôtres ;
- ⚠️ On va déployer une 'prod' lite et épurée.

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;
- Gratuit et pleinement fonctionnel, support entreprise disponible ;

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;
- Gratuit et pleinement fonctionnel, support entreprise disponible ;
- API complète → facilement automatisable avec OpenTofu ;

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;
- Gratuit et pleinement fonctionnel, support entreprise disponible ;
- API complète → facilement automatisable avec OpenTofu ;
- Alternative crédible à VMware depuis Broadcom ;

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;
- Gratuit et pleinement fonctionnel, support entreprise disponible ;
- API complète → facilement automatisable avec OpenTofu ;
- Alternative crédible à VMware depuis Broadcom ;
- Basé sur des standards Linux : Debian, KVM, Ceph… ;

---

# Pourquoi Proxmox ?

- Open source, largement adopté ;
- Gratuit et pleinement fonctionnel, support entreprise disponible ;
- API complète → facilement automatisable avec OpenTofu ;
- Alternative crédible à VMware depuis Broadcom ;
- Basé sur des standards Linux : Debian, KVM, Ceph… ;
- Simple à déployer et à administrer.

<div class="mt-8 text-sm opacity-70">
Info : Proxmox n'est pas requis pour utiliser Talos.
</div>

---

# Pourquoi des VMs ?

- pour une démo : je casse, je recrée, je rejoue ;

---

# Pourquoi des VMs ?

- pour une démo : je casse, je recrée, je rejoue ;
- pour l'automatisation : OpenTofu pilote Proxmox par API ;

---

# Pourquoi des VMs ?

- pour une démo : je casse, je recrée, je rejoue ;
- pour l'automatisation : OpenTofu pilote Proxmox par API ;
- pour mutualiser : Talos, Linux, Windows sur le même cluster ;

---

# Pourquoi des VMs ?

- pour une démo : je casse, je recrée, je rejoue ;
- pour l'automatisation : OpenTofu pilote Proxmox par API ;
- pour mutualiser : Talos, Linux, Windows sur le même cluster ;
- pour segmenter : qualif, démo, test, chacun son cluster Kubernetes ;

---

# Pourquoi des VMs ?

- pour une démo : je casse, je recrée, je rejoue ;
- pour l'automatisation : OpenTofu pilote Proxmox par API ;
- pour mutualiser : Talos, Linux, Windows sur le même cluster ;
- pour segmenter : qualif, démo, test, chacun son cluster Kubernetes ;
- et si besoin : Talos fonctionne aussi en bare metal.

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;
- Plan avant application ;

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;
- Plan avant application ;
- Reproductible & versionnable ;

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;
- Plan avant application ;
- Reproductible & versionnable ;
- Automatisable / CI-CD ;

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;
- Plan avant application ;
- Reproductible & versionnable ;
- Automatisable / CI-CD ;
- Écosystème de providers & modules ;

---

# Pourquoi OpenTofu ?

- Infrastructure déclarative ;
- Plan avant application ;
- Reproductible & versionnable ;
- Automatisable / CI-CD ;
- Écosystème de providers & modules ;
- Open source (Linux Foundation).

<div class="mt-8 text-sm opacity-70">
Info : OpenTofu n'est pas requis pour utiliser Talos.
</div>

---

# Bring your own stack

Proxmox + OpenTofu + Talos, c'est mon use case.

Les briques restent adaptables :

- Proxmox → VMware, Bare metal, Cloud, ... ;

---

# Bring your own stack

Proxmox + OpenTofu + Talos, c'est mon use case.

Les briques restent adaptables :

- Proxmox → VMware, Bare metal, Cloud, ... ;
- OpenTofu → Pulumi, Ansible, Puppet, Crossplane, ... ;

---

# Bring your own stack

Proxmox + OpenTofu + Talos, c'est mon use case.

Les briques restent adaptables :

- Proxmox → VMware, Bare metal, Cloud, ... ;
- OpenTofu → Pulumi, Ansible, Puppet, Crossplane, ... ;
- Talos → Talos ;

---

# Bring your own stack

Proxmox + OpenTofu + Talos, c'est mon use case.

Les briques restent adaptables :

- Proxmox → VMware, Bare metal, Cloud, ... ;
- OpenTofu → Pulumi, Ansible, Puppet, Crossplane, ... ;
- Talos → Talos ;
- Cilium → Flannel, Calico, ... avec adaptation de kube-proxy ;

---

# Bring your own stack

Proxmox + OpenTofu + Talos, c'est mon use case.

Les briques restent adaptables :

- Proxmox → VMware, Bare metal, Cloud, ... ;
- OpenTofu → Pulumi, Ansible, Puppet, Crossplane, ... ;
- Talos → Talos ;
- Cilium → Flannel, Calico, ... avec adaptation de kube-proxy ;
- Traefik → HAproxy, Envoy Gateway, Kong, ...

<div class="mt-8 text-lg opacity-80">
Talos n'impose pas une plateforme, il standardise le nœud Kubernetes.
</div>

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;
- Comptes locaux ;

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;
- Comptes locaux ;
- Shell root ;

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;
- Comptes locaux ;
- Shell root ;
- Paquets installables ;

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;
- Comptes locaux ;
- Shell root ;
- Paquets installables ;
- Configuration modifiable à la main ;

---

# Et sans Talos ?

Sur un OS classique, le nœud peut devenir un objet que l'on corrige à la main :

- SSH ouvert ;
- Comptes locaux ;
- Shell root ;
- Paquets installables ;
- Configuration modifiable à la main ;
- Drift invisible.

<!--
Insister sur le risque opérationnel, pas seulement sécurité. Le problème est la capacité à changer l'état d'un nœud hors process.
-->

---

# La dérive silencieuse

Une fois connecté, tout devient modifiable sans laisser de trace :

- Kubelet et container runtime → ce qui fait tourner les conteneurs ;

---

# La dérive silencieuse

Une fois connecté, tout devient modifiable sans laisser de trace :

- Kubelet et container runtime → ce qui fait tourner les conteneurs ;
- Certificats → l'identité du cluster ;

---

# La dérive silencieuse

Une fois connecté, tout devient modifiable sans laisser de trace :

- Kubelet et container runtime → ce qui fait tourner les conteneurs ;
- Certificats → l'identité du cluster ;
- Kernel et systemd → le système entier ;

---

# La dérive silencieuse

Une fois connecté, tout devient modifiable sans laisser de trace :

- Kubelet et container runtime → ce qui fait tourner les conteneurs ;
- Certificats → l'identité du cluster ;
- Kernel et systemd → le système entier ;
- Règles réseau → le pare-feu ;

---

# La dérive silencieuse

Une fois connecté, tout devient modifiable sans laisser de trace :

- Kubelet et container runtime → ce qui fait tourner les conteneurs ;
- Certificats → l'identité du cluster ;
- Kernel et systemd → le système entier ;
- Règles réseau → le pare-feu ;
- Des fichiers changés « juste pour tester ».

<div class="mt-8 text-sm opacity-70">
La dette technique devient une surface d'attaque.
Un risque, pas une fatalité : un cluster sur OS classique peut être impeccable.
</div>

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;
- Configuration déclarative et versionnable ;

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;
- Configuration déclarative et versionnable ;
- Bootstrap reproductible ;

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;
- Configuration déclarative et versionnable ;
- Bootstrap reproductible ;
- Upgrades Talos et Kubernetes ;

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;
- Configuration déclarative et versionnable ;
- Bootstrap reproductible ;
- Upgrades Talos et Kubernetes ;
- Health checks intégrés ;

---

# Pourquoi Talos ?

C'est un OS spécialisé pour Kubernetes qui apporte une expérience proche du K8s managé :

- API pour piloter les nœuds (et CLI dédiée : talosctl) ;
- Configuration déclarative et versionnable ;
- Bootstrap reproductible ;
- Upgrades Talos et Kubernetes ;
- Health checks intégrés ;
- Peu de colle maison autour du lifecycle.

<div class="mt-8 text-sm opacity-70">
Installable presque partout : Proxmox, VMware, bare metal, cloud, ...
</div>

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;
- Pas de SSH ni de shell interactif ;

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;
- Pas de SSH ni de shell interactif ;
- Configuration déclarative et auditable ;

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;
- Pas de SSH ni de shell interactif ;
- Configuration déclarative et auditable ;
- Système immuable ;

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;
- Pas de SSH ni de shell interactif ;
- Configuration déclarative et auditable ;
- Système immuable ;
- Base pensée pour les recommandations CIS ;

---

# Et côté sécurité ?

Il réduit la surface d'attaque du système hôte :

- Accès admin uniquement via API mTLS ;
- Pas de SSH ni de shell interactif ;
- Configuration déclarative et auditable ;
- Système immuable ;
- Base pensée pour les recommandations CIS ;
- Pod Security Admission activé par défaut : `Baseline` imposé, `Restricted` en warning/audit ;
- Conçu pour limiter le drift.

<div class="mt-8 text-sm opacity-70">
Sécurité by design
</div>

---

# Par contre ...

Il ne remplace pas une bonne hygiène de sécurité :

- Les NetworkPolicies ;
- La gestion des secrets ;
- Les scans d'images ;
- Le bon sens en production ;
- ...

---

# Architecture de la démo

```text
Serveur Proxmox
  |-- talos-cp-1    10.10.10.101
  |-- talos-cp-2    10.10.10.102
  |-- talos-cp-3    10.10.10.103
  |-- talos-wkr-1   10.10.10.111
  |-- VIP API       10.10.10.10
  `-- Traefik LB    10.10.10.200
```

---

# La démo en 5 étapes

```text
opentofu/talos/
  01-proxmox-talos/          # VMs + Talos + bootstrap K8s
  02-cilium-traefik/         # Cilium + Traefik via Helm/OpenTofu
  03-deploy-application/     # App whoami via OpenTofu/Kubernetes provider
  04-add-talos-worker-node/  # Ajout d'un worker Talos
  05-upgrade-talos-and-k8s/  # Upgrade Talos + Kubernetes
  scripts/                   # Runbook exécutable de démo
```

Les fichiers importants :

- `proxmox.tf` : VMs, disque, réseau, image Talos ;
- `talos.tf` : MachineConfig, bootstrap, kubeconfig ;
- `helm.tf` : Cilium et Traefik ;
- `parameters.auto.tfvars` : le scénario de démo ;
- `upgrade.env` : les versions cibles pour Talos et Kubernetes.

---

# Démo 1 : créer le cluster Kubernetes

```bash
./scripts/01-proxmox-talos.sh
```

On part d'un Proxmox vide et on arrive à un cluster Kubernetes utilisable.

Ce script fait :

- `tofu init`, `tofu plan`, `tofu apply` ;
- Création des VMs Proxmox ;
- Application des MachineConfigs Talos ;
- Bootstrap etcd/Kubernetes ;
- Export `~/.talos/config` et `~/.kube/config`.

<div class="mt-6 text-sm opacity-70">
Au début, `kubectl get nodes` peut être incomplet : le CNI arrive juste après.
</div>

---

# Démo 2 : ajouter un CNI et un ingress controller

```bash
./scripts/02-cilium-traefik.sh
```

Pourquoi en deux temps ?

Talos démarre Kubernetes sans CNI.

- `tofu init`, `tofu plan`, `tofu apply` ;
- Les composants sont installés via Helm ;
- Cilium remplace kube-proxy ;
- Cilium annonce l'IP LoadBalancer en L2 ;
- Traefik est exposé sur `10.10.10.200` ;
- CoreDNS est configuré pour se répartir sur plusieurs nœuds.

Commandes à montrer :

```bash
cilium status
kubectl get nodes -o wide
kubectl get pods,svc -n traefik-system -o wide
```

---

# Démo 3 : déployer une application

```bash
./scripts/03-deploy-application.sh
```

On peut déployer ce qu'on veut comme application.

On déploie :

- `tofu init`, `tofu plan`, `tofu apply` ;
- Namespace `whoami` ;
- Deployment `whoami`, 3 réplicas ;
- Service ClusterIP ;
- IngressRoute Traefik ;
- Host `demo-meetup.calmops.fr`.

---

# Démo 4 : ajouter un nœud worker

```bash
./scripts/04-add-talos-worker-node.sh
```

Ajouter un nœud, c'est une commande.

Ce script :

- `tofu init`, `tofu plan`, `tofu apply` ;
- Crée la VM Proxmox du nouveau worker ;
- Réutilise les secrets Talos du cluster ;
- Applique la MachineConfig worker ;
- Vérifie l'arrivée du nœud.

---

# Démo 5 : mettre à jour Talos + Kubernetes

```bash
./scripts/05-upgrade-talos.sh
./scripts/05-upgrade-k8s.sh
```

Créer c'est bien, gérer le cycle de vie c'est mieux.

- `talosctl upgrade -n <NODE_IP> --image <TALOS_IMAGE> --preserve` ;
- `talosctl -n <NODE_IP> upgrade-k8s --to <K8S_VERSION>` ;
- Paramètres dans `05-upgrade-talos-and-k8s/upgrade.env` ;
- `05-upgrade-talos.sh` met à jour `talosctl`, puis lance `talosctl upgrade` ;
- `05-upgrade-k8s.sh` met à jour `kubectl`, puis lance `talosctl upgrade-k8s` ;
- Vérification avec `talosctl health` et `kubectl get nodes`.

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;
- Secrets hors repo ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;
- Secrets hors repo ;
- Supervision, logs, alerting ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;
- Secrets hors repo ;
- Supervision, logs, alerting ;
- Politique d'upgrade ;

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;
- Secrets hors repo ;
- Supervision, logs, alerting ;
- Politique d'upgrade ;
- PRA documenté et testé.

---

# Et maintenant si on veut mettre en prod ?

Je ne mettrais pas exactement cette démo en prod telle quelle.

En production, il faut ajouter :

- Un vrai cluster Proxmox ;
- Sauvegarde et test de restauration etcd ;
- Gestion distante du state OpenTofu ;
- Secrets hors repo ;
- Supervision, logs, alerting ;
- Politique d'upgrade ;
- PRA documenté et testé.
- ...

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.
2. OpenTofu rend le déploiement rejouable, auditable et versionnable.

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.
2. OpenTofu rend le déploiement rejouable, auditable et versionnable.
3. Proxmox donne une plateforme simple et API-friendly pour ce use case.

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.
2. OpenTofu rend le déploiement rejouable, auditable et versionnable.
3. Proxmox donne une plateforme simple et API-friendly pour ce use case.
4. Les VMs rendent les clusters éphémères et faciles à multiplier.

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.
2. OpenTofu rend le déploiement rejouable, auditable et versionnable.
3. Proxmox donne une plateforme simple et API-friendly pour ce use case.
4. Les VMs rendent les clusters éphémères et faciles à multiplier.
5. Sécurisé by design ne veut pas dire sécurisé sans discipline.

---

# Ce qu'il faut retenir

1. Talos réduit le drift et la surface d'attaque des nœuds Kubernetes.
2. OpenTofu rend le déploiement rejouable, auditable et versionnable.
3. Proxmox donne une plateforme simple et API-friendly pour ce use case.
4. Les VMs rendent les clusters éphémères et faciles à multiplier.
5. Sécurisé by design ne veut pas dire sécurisé sans discipline.
6. Pour l'équipe : moins de corrections manuelles, des upgrades cadrés, moins de logique maison autour du lifecycle Kubernetes.

---

# Liens : docs

<div class="grid grid-cols-2 gap-8 text-sm">
<div>

## Talos

- <span class="links">[Docs officielles](https://www.talos.dev)</span>
- <span class="links">[Image Factory](https://factory.talos.dev)</span>
- <span class="links">[Talos sur Proxmox](https://www.talos.dev/latest/talos-guides/install/virtualized-platforms/proxmox/)</span>

## IaC

- <span class="links">[OpenTofu](https://opentofu.org)</span>
- <span class="links">[Provider Proxmox](https://registry.opentofu.org/providers/bpg/proxmox/latest/docs)</span>
- <span class="links">[Provider Talos](https://registry.opentofu.org/providers/siderolabs/talos/latest/docs)</span>

</div>
<div>

## Add-ons

- <span class="links">[Cilium](https://cilium.io)</span>
- <span class="links">[Traefik](https://traefik.io)</span>

</div>
</div>

---

# Liens : pour aller plus loin

<div class="grid grid-cols-2 gap-8 text-sm">
<div>

## Talos

- <span class="links">[Un cluster de production en un éclair · Quentin Joly](https://www.youtube.com/watch?v=b0ts3lyJAdY)</span>
- <span class="links">[Blog · Quentin Joly](https://une-tasse-de.cafe/)</span>
- <span class="links">[Talos, Docker multi-cluster · Rémi Verchère](https://www.vrchr.fr/posts/2025/11/24/talos-docker-multi-cluster/)</span>

</div>
<div>

## Kubernetes

- <span class="links">[50 nuances de Kubernetes · Denis Germain](https://50ndk.zwindler.fr/)</span>
- <span class="links">[101 ways to deploy Kubernetes · Denis Germain](https://zwindler.github.io/101-ways-to-deploy-kubernetes/)</span>

## Stack complète

- <span class="links">[Proxmox + OpenTofu + Talos as code · Julien Hommet](https://j.hommet.net/proxmox-opentofu-talos-kubernetes-as-code/)</span>

</div>
</div>

---

<div class="text-center">

# Merci !

## Des questions ?

</div>

<div class="mt-6 grid grid-cols-2 gap-8 text-center">
  <div>
    <img src="/slides-qr.png" class="mx-auto" style="width: 11rem; border-radius: 1rem; box-shadow: 0 10px 30px rgba(35,48,46,.12);" alt="QR code Slides">
    <div class="mt-4 text-2xl font-bold">Slides</div>
  </div>
  <div>
    <img src="/sources-qr.png" class="mx-auto" style="width: 11rem; border-radius: 1rem; box-shadow: 0 10px 30px rgba(35,48,46,.12);" alt="QR code Sources">
    <div class="mt-4 text-2xl font-bold">Sources</div>
  </div>
</div>
