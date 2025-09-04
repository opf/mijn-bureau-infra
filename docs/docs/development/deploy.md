---
sidebar_position: 5
---

# Deploy

In this part we describe how you can deploy mijnBureau to a test kubernetes so you can verify your changes.

## KIND

We use Kubernetes in Docker to test MijnBureau locally. [KIND Documentatino](https://kind.sigs.k8s.io)

Once your install KIND you can create a cluster simply with:

```bash
kind create cluster
```

When you are done with the cluster you can delete it

```bash
kind delete cluster
```

## deploy

To deploy MijnBureau to your kind cluster you need to set a variable

```bash
export MIJNBUREAU_MASTER_PASSWORD="your-very-secure-password"
```

Before you install MijnBureau you need to make sure you are connected to the correct Kubernetes. The following commands shows you which Kubernetes cluster you are connected to.

```bash
kubectl config current-context
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
