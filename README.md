# Mijn Bureau

`MijnBureau` is a collaboration suite. This repo is the deployment Automation Mijn Bureau.

> [!IMPORTANT]
> This is still a prototype

## Overview

MijnBureau is a Kubernetes based, open-source and cloud-native digital workplace suite. It is designed to be able to replace Functional components by your own hosted solution like the identity management and portal which often already exist in organisations.

MijnBureau currently features the following functional main components:

| Function          | Functional Component | Component Version                                                  | Upstream Documentation                                        | LICENSE    |
| ----------------- | -------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------- | ---------- |
| Identity Provider | Keycloak             | [26.2.4](https://github.com/keycloak/keycloak/releases/tag/26.2.4) | [documentation](https://www.keycloak.org/documentation)       | Apache-2.0 |
| Chat              | Element synapse      | [v1.129](https://github.com/element-hq/synapse/tree/v1.129.0)      | [documentation](https://element-hq.github.io/synapse/latest/) | AGPL-3.0   |
| Notes             | Docs                 | [v3.2.1](https://github.com/suitenumerique/docs/tree/v3.2.1)       |                                                               | MIT        |
| AI LLM            | Ollama               | [v0.7.0](https://github.com/ollama/ollama/tree/v0.7.0)             | [documentation](https://ollama.com/)                          | MIT        |

## Requirements

MijnBureau is a Kubernetes-only solution and requires an existing Kubernetes (K8s) cluster. You also need Domain

## Getting started

We use [helmfile](https://helmfile.readthedocs.io/en/latest/) to generate all kubernetes manifest. before you can generate the manifest you need to install [helm](https://helm.sh/) and [helm-secrets](https://github.com/jkroepke/helm-secret). The helmfile entrypoint is the [helmfile.yaml](helmfile.yaml).

to generate all manifest use the following command in the base directory

```bash
helmfile template 
```

For more detailed information see [MijnBureau docs](https://minbzk.github.io/mijn-bureau/)

## Commit rules

We use the [gitmoji](https://gitmoji.dev/) commit convention with the following scopes: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

## License

Licensed under the EUPL-1.2 license
