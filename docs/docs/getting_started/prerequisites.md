---
sidebar_position: 2
---

# Prerequisites

MijnBureau does not have many prerequisites except for a Kubernetes cluster.

## ☸️ Kubernetes Cluster

Minimal Kubernetes cluster requirements:

- A [CNCF certified Kubernetes](https://www.cncf.io/training/certification/software-conformance/) installation.
- AMD64 platform
- A LoadBalancer
- A ingress controller: Nginx or HAProxy-openshift

Currently MijnBureau only supports the Nginx and HAProxy ingress controller but more can be added if needed.

### Kubernetes resources

We tried to make resource setup easy and have a global size parameter that changes the resources used for all components of MijnBureau. Bellow a list of expected resource usage depending on the size parameter. The resource usage bellow are for the default settings. If you want to enable/disable components and recalculate the resource usage you can use the ./script/predicted_resources.py. Since we are still adding components and not updating these values every time they might be slightly off.

#### nano

For demo environment

- CPU requested 1.5 cores
- CPU Limits 2.4 cores
- Memory requested 3.5 GiB
- Memory requested 6.2 GiB

For production environment

- CPU requested 0.800 cores
- CPU Limits 1.4 cores
- Memory requested 2.6 GiB
- Memory requested 4.9 GiB

#### micro

For demo environment

- CPU requested 3.1 cores
- CPU Limits 4.9 cores
- Memory requested 4.9 GiB
- Memory requested 8.3 GiB

For production environment

- CPU requested 1.4 cores
- CPU Limits 2.3 cores
- Memory requested 3.1 GiB
- Memory requested 5.6 GiB

#### small

For demo environment

- CPU requested 5.9 cores
- CPU Limits 9.0 cores
- Memory requested 7.7 GiB
- Memory requested 12.5 GiB

For production environment

- CPU requested 2.4 cores
- CPU Limits 6.2 cores
- Memory requested 3.2 GiB
- Memory requested 12.5 GiB

#### medium

For demo environment

- CPU requested 5.9 cores
- CPU Limits 9.0 cores
- Memory requested 13.3 GiB
- Memory requested 21.0 GiB

For production environment

- CPU requested 2.4 cores
- CPU Limits 3.8 cores
- Memory requested 6.1 GiB
- Memory requested 10.2 GiB

#### large

For demo environment

- CPU requested 11.4 cores
- CPU Limits 17.3 cores
- Memory requested 24.6 GiB
- Memory requested 37.9 GiB

For production environment

- CPU requested 4.4 cores
- CPU Limits 6.8 cores
- Memory requested 10 2 GiB
- Memory requested 16.4 GiB

#### xlarge

For demo environment

- CPU requested 11.4 cores
- CPU Limits 33.6 cores
- Memory requested 35.8 GiB
- Memory requested 71.7 GiB

For production environment

- CPU requested 4.4 cores
- CPU Limits 12.8 cores
- Memory requested 14.3 GiB
- Memory requested 8.7 GiB

#### 2xlarge

For demo environment

- CPU requested 11.4 cores
- CPU Limits 66.8 cores
- Memory requested 35.8 GiB
- Memory requested 139.3 GiB

For production environment

- CPU requested 4.4 cores
- CPU Limits 24.8 cores
- Memory requested 14.3 GiB
- Memory requested 53.2 GiB

## 🛠️ Tools

To install MijnBureau on Kubernetes you need some tools. We use Helmfile to generate all the Kubernetes manifests but you could also use Flux or ArgoCD with some small edits. To use Helmfile you will need to install:

- [Helmfile](https://helmfile.readthedocs.io/en/latest/#installation)
- [Helm](https://helm.sh/docs/intro/install/)

If you plan to store secrets like credentials, we recommend using a encryption tool or secret manager. In this documentation we will use sops, but there are many more that you could consider. It depends on your organization what is best.

- [SOPS](https://getsops.io/)
- [age](https://github.com/FiloSottile/age)

## 🌐 Domain Configuration

Since MijnBureau as mainly a browser based suite, you will need a domain or subdomain you control so the tool can be made available to users.
