---
sidebar_position: 8
---

# Security

Security is a top priority for MijnBureau. We have implemented several measures to ensure the platform is secure. This document outlines the steps we have taken and provides recommendations for enhancing security further.

---

## Infrastructure Code

MijnBureau primarily uses vendor-provided products deployed to Kubernetes using infrastructure-as-code (IaC). To ensure security best practices are followed:

- **Policies**: Security policies in the `/policy/` folder validate our IaC against best practices.
- **Manual Scans**: Every few months, we manually scan our infrastructure code using tools like [Checkov](https://www.checkov.io/) and [Kube-score](https://kube-score.com/) to identify areas for improvement.
- **Strict Development**: During development, MijnBureau is deployed on OpenShift with the `restricted` Security Context Constraint (SCC). This SCC denies access to all host features and requires pods to:
  - Be run with a UID allocated to the namespace.
  - Use an SELinux context allocated to the namespace.

  The `restricted` SCC is the most restrictive and secure option. It is used by default for authenticated users. For more details, refer to our blog post.

---

## Containers

Containers can introduce security vulnerabilities. Here’s how we address container security:

- **Base Containers**: We use containers provided by the maintainers of the tools we deploy.
- **Configurability**: Containers in MijnBureau are configurable, allowing you or us to patch vulnerabilities as needed.
- **Future Plans**: We plan to implement a pipeline to continuously scan all default containers in MijnBureau and actively track CVEs.
- **Pull Policy**: MijnBureau always sets the pull policy to `Always` to ensure the latest container images are used.

---

## Pod Security

Kubernetes provides robust security features for pods. To enhance pod security:

- **Pod Security Admission**: Kubernetes administrators should enable [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/#pod-security-admission-labels-for-namespaces). MijnBureau recommends using the `enforce` mode for the strictest security.
- **Security Standards**: We have defined security standards in `helmfile/environments/default/security.yaml.gotmpl`. These include strict security rules, which can be adjusted if necessary.

---

## AppArmor

Kubernetes supports AppArmor profiles to enhance container security. We recommend enabling AppArmor profiles for your workloads.

---

## Container Runtime Sandbox

To further secure containers, consider enabling a container runtime sandbox like [gVisor](https://gvisor.dev/).

---

## Security Monitoring

For additional security, you can install monitoring tools on your Kubernetes nodes. Tools like [Falco](https://falco.org/) can help detect and respond to security events.

---

## Network Policies

MijnBureau assumes a `DenyAll` network policy is active. To secure your network:

- Add a `DenyAll` network policy to all namespaces where MijnBureau is installed.
- Use Kubernetes [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) to control traffic flow between pods.

---
