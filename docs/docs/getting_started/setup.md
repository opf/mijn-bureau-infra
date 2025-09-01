---
sidebar_position: 3
---

# Setup

To setup MijnBureau and install it on Kubernetes you first need to clone the [repository](https://github.com/MinBZK/mijn-bureau-infra) or download a [release](https://github.com/MinBZK/mijn-bureau-infra/releases).

to clone we assume you know how to use git

```bash
git clone https://github.com/MinBZK/mijn-bureau-infra
```

If you download a release you need to extract the tar

```bash
tar -xzvf mijnbureau.tar.gz
```

Once you have the software on your machine, you can start configuring the application.

## Configuration

MijnBureau supports multiple deployment environments. It is recommended to use the Demo or Production environment because it allows for easy overwrite of configuration and prevent conflicts once you update to a newer version of MijnBureau.

### 🏠 Default environment

- **Purpose**: Used by default if no environment is specified by the user
- **Includes**: Core applications excluding external data stores
- **Configuration**: `helmfile/environments/default/`

We recommend not using the default environment. If you use it, it is configured similarly as the production environment.

### 🚀 Demo environment

- **Purpose**: Testing and evaluation
- **Includes**: Core application including external datastores like caches, databases and object stores
- **Configuration**: `helmfile/environment/demo/`

The demo environment includes all datastores for convenient testing and evaluation like databases, caches and object store. However, it does not have backup and restore capabilities build-in. Make sure to add Backup and restore features if you need it for your use-case.

### 🏢 Production environment

- **Purpose**: Enterprise deployments
- **Requires**: Core applications excluding external data stores

- **Configuration**: `helmfile/environment/production/`

For a production setup you will need to setup a database (PostgreSQL), a cache (Redis) and an object store (Minio) and connect the applications in MijnBureau. Make sure to setup backup & restore procedures, disaster recovery and persistent volume claim backups.

### Overriding configuration

By default mijnbureau uses all configurations from the default environment. These can be found here:

```bash
./helmfile/environments/default/<file>.gotmpl
```

Many files exist, all of them configure a part of mijnBureau. You can go through all the files and see if you want to change settings.

You can override settings by copying partial content from the default environment files and paste that into the mijnbureau.yaml.gotmpl. You can find the mijnbureau.yaml.gotmpl file here

```bash
./helmfile/environments/{environment}/mijnbureau.yaml.gotmpl
```

where `{environment}` can be the `demo` or `production` environment.

For example, to change the DomainName in the production environment we overwrite specific variables from
`./helmfile/environments/default/global.yaml.gotmpl` by adding them to
`./helmfile/environments/production/mijnbureau.yaml.gotmpl` by setting the following content:

```yaml
global:
  domain: "mijnbureau.mydomain.com"
```

This overwriting can be done for all variables found in the default environment. You can also chose to split mijnbureau.yaml.gotmpl into more files to make it more managable.
