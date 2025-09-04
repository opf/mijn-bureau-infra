---
sidebar_position: 3
---

# Add Component

In this part of the documentation we describe how to add a new component. We describe this because we made some architectural decisions that impact how implement new components.

## Template

For new components we have a template that we use. You need to copy this template if you want to add a new component and make sure you implement the relevant options in this template for your component. The template can be found in the [github repository](https://github.com/MinBZK/mijn-bureau-infra/tree/main/template).

The template needs to be copied to `./helmfile/apps/<yourapp>/charts/<yourapp>`

## Charts

You are not allowed to reference external charts that are not maintained by bitnami. If you want an external chart, you will need to copy the template and port parts of the chart into the template.

## Flexibility & Consistency

We want to keep MijnBureau flexible and consistent. If you create a new component you will need to adhere to certain rules and need to implement specific variables that we use in every chart to keep the mijnbureau suite consistent and flexibel.

In short this means you basically need to use the variables in `./helmfile/environments/default/*.yaml.gotmpl` when logical.

More explicitly this means

1. Make resources used by containers flexibel `./helmfile/environments/default/resource.yaml.gotmpl`
2. Make the charts used by helm flexibel `./helmfile/environments/default/chart.yaml.gotmpl`
3. Make the containers used by helm flexibel `./helmfile/environments/default/container.yaml.gotmpl`
4. Make the PVC configurable `./helmfile/environments/default/pvc.yaml.gotmpl`
5. Implement the container and pod security `./helmfile/environments/default/security.yaml.gotmpl`
6. Make it possible to disable your component `./helmfile/environments/default/application.yaml.gotmpl`
7. Make use of the authorization OIDC variables `./helmfile/environments/default/authentication.yaml.gotmpl`
8. Implement autocaling features `./helmfile/environments/default/autoscaling.yaml.gotmpl`
9. Add switches for demo environment that deploys all required datastores.
10. Make the datastores configurable in the cache.yaml.gotmpl, database.yaml.gotmpl and objectstore.yaml.gotmpl
11. use the `./helmfile/environments/default/global.yaml.gotmpl` variables where logical
12. use the `./helmfile/environments/default/ai.yaml.gotmpl` variables where logical
13. use the `./helmfile/environments/default/cluster.yaml.gotmpl` where logical

## OpenID Connect

All the new tools we add that are user facing need to have OpenID connect available for authentication. Preferable it also needs to support backchannel logout.

## SCIM

We currently do not have SCIM support but plan to add this in the near future.

## Network Policies

Since MijnBureau is used in kubernetes environments with a default deny network policy you will need to create all network policies explicitly.

If you want to test, this is an example of a default deny network policy for kubernetes

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```
