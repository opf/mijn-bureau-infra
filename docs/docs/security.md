---
sidebar_position: 8
---

# Security

Security is very important for MijnBureau. We have added great efforts to make our tool secure. Here we describe what we did, and what you can do to make MijnBureau even more secure.

## Infra code

MijnBureau is mainly using products from vendors and deploying them to kubenetes with Infra code. Therefore it is important to add security rules to the infra code so that we can check if we conform to security best practices.

We created policies in the /policy/ folder that check security rules on our infra code.

We also scan our infra code manually every few months with tools like checkov and kube-score to see if we need to refine our policies.

## Containers

Containers can contain security vulnerabilities. We currently use the containers provides by the maintainers that create the tools we use. But we made the containers configurable in MijnBureau so you or we can easily patch a container if we find a vulnerability that needs fixing.

In the future we plan to create a pipeline to continuously scan all default containers in mijnbureau and track the CVEs actively.

In MijnBureau we always set the pull policy to Always.

## Pod Security

Kubernetes added allot of effort to add security and it easy to add for your kubernetes administators. Please read the kubernetes [documentation](https://kubernetes.io/docs/concepts/security/pod-security-admission/#pod-security-admission-labels-for-namespaces) to enable pod security admission. The enforce mode it the most strict one and is recommended by MijnBureau.

we also create standards to influence security for mijnbureau. these can be found in `helmfile/environments/default/security.yaml.gotmpl`. We have set strict security rules but you change it if needed.

## AppArmor

Kubernetes supports AppArmor profiles

## Container runtime sandbox

To make container even more secure you could enabled gvisor as one of the container runtime sandboxes.

## Security monitoring

You could enable or install security monitoring tools on yoru kubernetes nodes like Falco.

## Network Policies

Kubernetes support network policies. MijnBureau assumes a DenyAll network policy to be active. It is recommended that you add a deny-all network policy to all namespaces where mijnbureau is installed.
