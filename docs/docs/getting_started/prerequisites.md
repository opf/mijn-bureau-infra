---
sidebar_position: 2
---

# Prerequisites

MijnBureau does not have many prerequisites except for a Kubernetes cluster.

## ☸️ Kubernetes Cluster

Minimal Kubernetes cluster requirements:

- A [CNCF certified Kubernetes](https://www.cncf.io/training/certification/software-conformance/) installation.
- Resources
  - cpu: 5 cores
  - memory: 128GB
  - diskspace: 200GB
- AMD64 platform
- A LoadBalancer
- A ingress controller: Nginx or HAProxy-openshift

Currently MijnBureau only supports the Nginx and HAProxy ingress controller but more can be added if needed.

## 🛠️ Tools

To install MijnBureau on Kubernetes you need some tools. We use Helmfile to generate all the Kubernetes manifests but you could also use Flux or ArgoCD with some small edits. To use Helmfile you will need to install:

- [Helmfile](https://helmfile.readthedocs.io/en/latest/#installation)
- [Helm](https://helm.sh/docs/intro/install/)

If you plan to store secrets like credentials, we recommend using a encryption tool or secret manager. In this documentation we will use sops, but there are many more that you could consider. It depends on your organization what is best.

- [SOPS](https://getsops.io/)
- [age](https://github.com/FiloSottile/age)

## 🌐 Domain Configuration

Since MijnBureau as mainly a browser based suite, you will need a domain or subdomain you control so the tool can be made available to users.
