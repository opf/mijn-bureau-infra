---
sidebar_position: 10
---

# Airgap

We have taking into account airgapped environment. Airgapped environments do not have internet access and need to prepare a few things. This documentation described what to do. Make sure you download everything bellow to a datastore so it can be moved to your airgapped environment.

## Download tools

Download helmfile and helm. Also download the needed plugins by helmfile

- helmfile: [documentation](https://helmfile.readthedocs.io/en/latest/#installation)
- helm: [documentation](https://helm.sh/docs/intro/install/>)
- helm-secrets: [documentation](https://github.com/jkroepke/helm-secrets)
- helm-diff: [documentation](https://github.com/databus23/helm-diff)
- helm-git: [documentation](https://github.com/aslafy-z/helm-git)
- helm-s3: [documentation](https://github.com/hypnoglow/helm-s3)

You will need more tools if you also want to test and develop MijnBureau but we assume you do not do that in airgapped environments.

## Download repo

Make sure you clone this repository:

```bash
git clone https://github.com/MinBZK/mijn-bureau-infra
```

## Download charts & containers

We prepared a script that tries to download all charts and containers used by mijnbureau.

```bash
./scripts/airgap_prepare.py
```
