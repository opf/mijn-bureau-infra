---
sidebar_position: 2
---

# Prerequisites

MijnBureau has minimal prerequisites, requiring only a Kubernetes cluster and some essential tools.

---

## ☸️ Kubernetes Cluster

### Minimum Requirements

- A [CNCF certified](https://www.cncf.io/training/certification/software-conformance/) Kubernetes or [Haven](https://haven.commonground.nl/) compliant Kubernetes.
- AMD64 platform.
- A LoadBalancer.
- An ingress controller: Nginx or HAProxy (OpenShift).

> Note: Currently, MijnBureau supports only the Nginx and HAProxy ingress controllers. Additional controllers can be added if needed.

### Kubernetes Resources

MijnBureau simplifies resource setup with a global size parameter that adjusts resource usage for all components. Below is the expected resource usage based on the size parameter. For precise calculations, use the `./script/predicted_resources.py` script. Note that these values may vary as new components are added.

#### Resource Usage by Size

| Size        | Environment | CPU Requested | CPU Limits | Memory Requested | Memory Limits |
| ----------- | ----------- | ------------- | ---------- | ---------------- | ------------- |
| **nano**    | Demo        | 1.5 cores     | 2.4 cores  | 3.5 GiB          | 6.2 GiB       |
|             | Production  | 0.8 cores     | 1.4 cores  | 2.6 GiB          | 4.9 GiB       |
| **micro**   | Demo        | 3.1 cores     | 4.9 cores  | 4.9 GiB          | 8.3 GiB       |
|             | Production  | 1.4 cores     | 2.3 cores  | 3.1 GiB          | 5.6 GiB       |
| **small**   | Demo        | 5.9 cores     | 9.0 cores  | 7.7 GiB          | 12.5 GiB      |
|             | Production  | 2.4 cores     | 6.2 cores  | 3.2 GiB          | 12.5 GiB      |
| **medium**  | Demo        | 5.9 cores     | 9.0 cores  | 13.3 GiB         | 21.0 GiB      |
|             | Production  | 2.4 cores     | 3.8 cores  | 6.1 GiB          | 10.2 GiB      |
| **large**   | Demo        | 11.4 cores    | 17.3 cores | 24.6 GiB         | 37.9 GiB      |
|             | Production  | 4.4 cores     | 6.8 cores  | 10.2 GiB         | 16.4 GiB      |
| **xlarge**  | Demo        | 11.4 cores    | 33.6 cores | 35.8 GiB         | 71.7 GiB      |
|             | Production  | 4.4 cores     | 12.8 cores | 14.3 GiB         | 18.7 GiB      |
| **2xlarge** | Demo        | 11.4 cores    | 66.8 cores | 35.8 GiB         | 139.3 GiB     |
|             | Production  | 4.4 cores     | 24.8 cores | 14.3 GiB         | 53.2 GiB      |

---

## 🛠️ Tools

To install MijnBureau on Kubernetes, you need the following tools:

- **Helmfile**: Used to generate Kubernetes manifests. [Installation Guide](https://helmfile.readthedocs.io/en/latest/#installation)
- **Helm**: [Installation Guide](https://helm.sh/docs/intro/install/)

### Secrets Management

If you plan to store secrets like credentials, we recommend using an encryption tool or secret manager. This documentation uses SOPS, but you can choose another tool based on your organization’s needs:

- **SOPS**: [Documentation](https://getsops.io/)
- **AGE**: [Documentation](https://github.com/FiloSottile/age)

---

## 🌐 Domain Configuration

MijnBureau is primarily a browser-based suite. You will need a domain or subdomain you control to make the tool accessible to users.
