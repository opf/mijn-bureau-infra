---
applyTo: "**/*.rego"
---

## Rego Policy Instructions for Kubernetes

This project uses [Conftest](https://www.conftest.dev/) with [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) to enforce security and compliance for Kubernetes manifests. The policies are located in `policy/` and the tests for them are in `tests/`.

### Guiding Principles

1.  **Deny by Default**: Policies should be written to `deny` insecure or non-compliant configurations. A successful test run has zero `deny` violations.
2.  **Security First**: The primary goal is to enforce security best practices. New policies should consider the security implications of a configuration.
3.  **Configuration Compliance**: Policies also ensure that the values configured in Helmfiles are correctly propagated to the final Kubernetes manifests.

### Writing a New Policy

When adding a new policy, follow these steps:

1.  **Create a `deny` rule**: All rules should start with `deny contains msg if { ... }`.
2.  **Target Specific Kinds**: Always scope your rule to specific Kubernetes resource `kind`s (e.g., `input.kind in {"Deployment", "StatefulSet"}`).
3.  **Write Clear Messages**: The `msg` should be descriptive and, if possible, use `sprintf` to include the name of the resource that is in violation. Example from `policy/containers.rego`:
    ```rego
    deny contains msg if {
      input.kind in {"Deployment", "StatefulSet", "DaemonSet", "Job", "Pod"}
      some i
      container := input.spec.template.spec.containers[i]
      container.securityContext.privileged == true
      msg := sprintf("Container '%s' is running in privileged mode", [container.name])
    }
    ```

### Key Security & Compliance Areas

Focus on policies that enforce the following:

- **Workload Security**:
  - **No Root Users**: Containers must not run as root (`runAsNonRoot: true`, `runAsUser` > 0).
  - **Immutable Filesystems**: Root filesystems should be read-only (`readOnlyRootFilesystem: true`).
  - **No Privilege Escalation**: `allowPrivilegeEscalation: false`.
  - **Restricted Capabilities**: Drop `ALL` capabilities and only add back what is necessary.
  - **No Privileged Containers**: `privileged: false`.
- **Resource Management**:
  - All containers must have CPU and memory `requests` and `limits` defined.
- **Image Security**:
  - Disallow the `:latest` tag.
  - Only allow images from trusted registries.
- **Networking**:
  - Disallow `hostNetwork`, `hostPort`, `hostPID`.
  - Enforce `NetworkPolicy` usage.
- **Storage**:
  - Disallow `hostPath` volumes.
- **Configuration Propagation**:
  - Ensure that global settings from `helmfile/environments/**/*.yaml` are correctly templated into the manifests. For example, a global domain name should appear in all Ingress resources.
