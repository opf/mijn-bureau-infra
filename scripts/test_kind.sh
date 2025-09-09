#!/usr/bin/env bash

# This script tests Helm templates using Conftest policy validation
# Usage: $0 [-e environment] [-s secret]

# Default values
ENVIRONMENT="demo"
SECRET=""
DELETE="false"

# Parse options
while getopts "e:s:d" opt; do
  case $opt in
    e)helmfile -e "$ENVIRONMENT" apply --skip-refresh -n "$NAMESPACE"
      ENVIRONMENT="$OPTARG"
      ;;
    s)
      SECRET="$OPTARG"
      ;;
    d)
      DELETE="true"
      ;;
    *)
      echo "Usage: $0 [-p path] [-e environments] [-s secret] [-n namespace] [-d]"
      exit 1
      ;;
  esac
done

# Check if kind is installed
if ! command -v kind &> /dev/null; then
  echo "kind could not be found. Please install it. For more information visit https://kind.sigs.k8s.io/docs/user/quick-start/"
  exit 1
fi

# Check if Helmfile is installed
if ! command -v helmfile &> /dev/null; then
  echo "helmfile could not be found. Please install it. For more information visit https://helmfile.readthedocs.io/en/latest/#installation"
  exit 1
fi

# Check if Helmfile is installed
if ! command -v kubectl &> /dev/null; then
  echo "kubectl could not be found. Please install it. For more information visit https://kubernetes.io/docs/tasks/tools/"
  exit 1
fi

if ! kind create cluster --name nginx-cluster --config kind/config-nginx.yaml; then
  printf -- "${RED}FAILED: Error deploying kubernetes"
  exit 1
fi

if ! kubectl cluster-info --context kind-nginx-cluster; then
  printf -- "${RED}FAILED: Error switching to kind cluster"
  exit 1
fi
# install nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.13.2/deploy/static/provider/cloud/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# install gateway API
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml

# Make parsed values readonly to prevent accidental modification
readonly ENVIRONMENT
readonly SECRET
export MIJNBUREAU_MASTER_PASSWORD=test
export MIJNBUREAU_CREATE_NAMESPACES=true
export SOPS_AGE_KEY="$SECRET"

tmpdir=$(mktemp -d)
cp -r . "${tmpdir}/mijnbureau"
cd "${tmpdir}/mijnbureau" || exit 1

rm -f "helmfile/environments/${ENVIRONMENT}/"*.yaml.gotmpl
cp -f "kind/config-nginx-mijnbureau.yaml" "helmfile/environments/${ENVIRONMENT}/mijnbureau.yaml.gotmpl"


if ! helmfile -e "$ENVIRONMENT" apply --skip-refresh --quiet; then
  printf -- "${RED}FAILED: Error deploying helmfile to kubernetes"
  exit 1
fi

## todo:
# test ingress and api-gateway settings

if [ "$DELETE" = "true" ]; then
  kind delete cluster --name nginx-cluster
fi
