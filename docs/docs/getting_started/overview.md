---
sidebar_position: 1
---

# Overview

MijnBureau is a Kubernetes-native digital workplace suite designed for government and enterprise organizations.
Deploy secure, compliant, and self-hosted applications using our Infrastructure as Code approach with [Helmfile](https://helmfile.readthedocs.io/en/latest/).
Helmfile is used to generate and manage Kubernetes manifests, providing a declarative way to deploy complex application stacks.

## Environment driven configuration

MijnBureau supports multiple deployment environments.

### 🏠 Default environment

- **Purpose**: Baseline configuration used when no environment is specified
- **Includes**: All dependencies (databases, caches, object stores) and core applications (Grist, Ollama, Keycloak, Matrix Chat)
- **Configuration**: `helmfile/environments/default/`

### 🚀 Demo environment

- **Purpose**: Testing and evaluation
- **Includes**: All dependencies and core applications from the default environment, with support for configuration overrides
- **Configuration**: `helmfile/environment/demo/`

### 🏢 Production environment

- **Purpose**: Enterprise deployments
- **Requires**: Preconfigured external datastores
- **Configuration**: `helmfile/environment/production/`

## Overriding configuration

You can override variables set in the default environment by setting these values in:

```bash
./helmfile/environments/{environment}/mijnbureau.yaml.gotmpl
```

where `{environment}` can be the `demo` or `production` environment.

For example, to change the domainname in the production environment we overwrite the
`global.yaml.gotmpl` from the default environment in the file
`mijnbureau.yaml.gotmpl` in the producution environment by setting the following content:

```yaml
global:
  domain: "mijnbureau.icbr.prd1.gn2.quattro.rijksapps.nl"
```

This can be done for all variables in the default environment.

## How Helmfile works

A brief overview of the template generation workflow is as follows: setup environment, generate Kubernetes manifests and apply those manifests.
To deploy a specific environment `demo` with a custom namespace `your-custom-namespace`:

```bash
export MIJNBUREAU_MASTER_PASSWORD="your-secure-password"
helmfile -e demo -n your-custom-namespace apply
```
