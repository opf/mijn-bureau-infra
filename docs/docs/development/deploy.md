---
sidebar_position: 5
---

# Deploy MijnBureau

This guide explains how to deploy MijnBureau to a test Kubernetes cluster, allowing you to verify your changes.

---

## KIND: Kubernetes in Docker

We use Kubernetes in Docker (KIND) to test MijnBureau locally. Refer to the [KIND Documentation](https://kind.sigs.k8s.io) for installation instructions.

### Create a KIND Cluster

To create a local Kubernetes cluster using KIND, run:

```bash
kind create cluster
```

### Delete the KIND Cluster

When you are done testing, delete the cluster with:

```bash
kind delete cluster
```

---

## Deploy MijnBureau

### Set Master Password

Set the master password for deterministic secret generation:

```bash
export MIJNBUREAU_MASTER_PASSWORD="your-very-secure-password"
```

### Verify Kubernetes Connection

Ensure you are connected to the correct Kubernetes cluster. Check the current context with:

```bash
kubectl config current-context
```

### Install MijnBureau

To deploy MijnBureau to your Kubernetes cluster, execute:

```bash
helmfile -e <environment> apply
```

Replace `<environment>` with the desired environment, such as `demo` or `production`. If you do not specify the `-e <environment>` option, MijnBureau will use the default environment.

### Inspect Installation

If you want to inspect the installation without deploying, use:

```bash
helmfile -e <environment> template
```

---

## Additional Helmfile Commands

Helmfile provides many additional commands for managing your deployment. Refer to the [Helmfile CLI Reference](https://helmfile.readthedocs.io/en/latest/#cli-reference) for more details.
