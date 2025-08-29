---
sidebar_position: 4
---

# Install

Before you can install MijnBureau you need to make sure you are connected to a Kubernetes. The following commands shows you which Kubernetes cluster you are connected to.

```bash
kubectl config current-context
```

## Set master password

Set the environment variable for the master password for deterministic secret generation.

```bash
export MIJNBUREAU_MASTER_PASSWORD="your-very-secure-password"
```

:::warning Password Security
This password generates most application secrets. Use a strong password and store it securely - you'll need it for future operations.
:::

## Set other variables

By default MijnBureau does not create a kubernetes namespace if it does not exist. you can change this by setting

```bash
export MIJNBUREAU_CREATE_NAMESPACES=true
```

### Deploy

To install mijnbureau you need to install and prepare helmfile and have helm available. To install [helmfile](https://helmfile.readthedocs.io/en/latest/#installation) and [helm](https://helm.sh/docs/intro/install/) check the documentation. Once installed initialize helmfile.

```bash
helmfile init
```

To install MijnBureau onto kubernetes execute `helmfile apply`.

```bash
helmfile -e <environment> apply
```

If you want to inspect the installation without deploying you can run

```bash
helmfile -e <environment> template
```

where `<environment>` can be the `demo` or `production` environment. if you do not specify the `-e <environment>` option MijnBureau will use the default environment.

there are many more helmfile commands that you can use, see the helmfile [documentation](https://helmfile.readthedocs.io/en/latest/#cli-reference)
