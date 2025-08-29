---
sidebar_position: 2
---

# Intro

Here we describe the development process and tools of MijnBureau. We hope this help you to get an easy way of working on MijnBureau

## Getting started

If you have an idea or want to make some changes you will need to create a PullRequest on the github repo of mijnbureau. If the change is significant or adds a new component it is recommended to first start a [Issue](https://github.com/MinBZK/mijn-bureau-infra/issues) on the github repo where you can discuss the change. This helps prevent you spending allot of time one something, and get a PR declined for some architecture or business reasons.

You can fork the [MijnBureau repository](https://github.com/MinBZK/mijn-bureau-infra) and create a branch. Once the branch is finished you can create a PR on the [github repo](https://github.com/MinBZK/mijn-bureau-infra/pulls).

## Tools

To make development easy for new developers we created 'DevContainers'. This is a container that includes all required tools for you to develop the applications.

To start a devcontainer in vscode read [the manual](https://code.visualstudio.com/docs/devcontainers/containers).

You can also choose to not use devcontainers and install all required tools on your machine. The two most important tools are

- [Helmfile](https://helmfile.readthedocs.io/)
- [Helm](https://helm.sh/)

You may need other tools if you want to run the tests and check if you adhere to the policies.

- Python3 (for gitlint)
- node & npm (for prettier formatting)
- [conftest](https://www.conftest.dev/) (for policy testing with rego language)
- [regal](https://github.com/StyraInc/regal/) for policy editing
- [kubeconform](https://github.com/yannh/kubeconform) (for testing)

## Helmfile

helmfile has plugins that it needs. These can be installed with

```
helmfile init
```
