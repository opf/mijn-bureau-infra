---
sidebar_position: 6
---

# Secrets

Sensitive values (like database passwords) can be securely stored for MijnBureau using helm-secrets. You can store secrets in different ways. Some companies use secret managers like hashicorp vault or encryption tools like [SOPS](https://getsops.io/) or vals. We have added secrets handling into account for MijnBureau. We prepared SOPS with a example file. The same can be done for Vals

```bash
./helmfile/environments/{environment}/example.secrets.yaml
```

## SOPS

In this part we describe how to use SOPS. First install [SOPS](https://getsops.io/) and [AGE](https://github.com/FiloSottile/age)

1. Generate an [Age](https://github.com/FiloSottile/age) key pair:

```bash
age-keygen -o mykey.txt
```

2. Update .sops.yaml:
   Replace the sample age: entry with your public key.

3. Encrypt a file:

add some values in the example.secrets.yaml and encrypt it.

```bash
helm secrets encrypt -i ./helmfile/environments/{environment}/example.secrets.yaml
```

4. Decrypt for local use:

```bash
export SOPS_AGE_KEY_FILE=./mykey.txt
helm secrets decrypt -i ./helmfile/environments/{environment}/example.secrets.yaml
```

5. Use with helmfile

```bash
export MIJNBUREAU_MASTER_PASSWORD=changethis
export SOPS_AGE_KEY_FILE=./mykey.txt
helmfile template
helmfile apply
```
