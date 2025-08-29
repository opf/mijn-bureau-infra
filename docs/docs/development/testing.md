---
sidebar_position: 4
---

# Testing

In this part we describe the testing of MijnBureau. We create a secure and high quality product which means we try to test important part and always try to improve this. In the `./scripts/` directory you will find script that increase quality and security. If you pass the scripts you will probably also pass the CI/CD (although not guaranteed).

## Formatting

We have strict formatting rules that are enforced by prettier. you can run ./scripts/format.sh to format all your changes.

## Linting

We have strict linting that er enforced by gitlint and helmfile. you can run ./scripts/lint.sh to lint all your changes.

## pre-commit

We use pre-commit to check general rules before committing. You can run pre-commit on the repo

```bash
pre-commit run --all
```

## Policy

We have policies that check if you adhere to the ADRs. This is done by conftest. you can run ./scripts/policy.sh to check all your changes. if you are interested in all the policies we have you can find the policies in the ./policy folder.

## Testing

We have developed a testing system for helmfile to check if all charts have a high enough quality and implemented important variables. You can run ./scripts/test.sh to test all your changes.
