#!/usr/bin/env bash

# This script create a kind cluster with nginx ingress controller and self-signed certificate for local testing.
# Usage: $0 [-d] [-k domain]
#   -d: delete the kind cluster after creation
#   -k: domain for the self-signed certificate (default: kubernetes.local

# Default values
DOMAIN="kubernetes.local"
NAME="mijnbureau"

# Parse options
while getopts "d:" opt; do
  case $opt in
    d)
      DOMAIN="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-d domain]"
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

# Check if Helmfile is installed
if ! command -v openssl &> /dev/null; then
  echo "Openssl could not be found. Please install it."
  exit 1
fi

if [ "$(uname)" == "Darwin" ]; then
  OS="macOS"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  OS="Linux"
else
  echo "Unsupported OS"
  exit 1
fi

echo "Creating kind cluster ..."
if ! kind create cluster --name mijnbureau --config kind/config-nginx.yaml > /dev/null 2>&1; then
  printf -- "${RED}FAILED: Error deploying kubernetes"
  exit 1
fi

echo "Switching to kind cluster ..."
if ! kubectl cluster-info --context kind-mijnbureau > /dev/null 2>&1; then
  printf -- "${RED}FAILED: Error switching to kind cluster"
  exit 1
fi

# install nginx
echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.13.2/deploy/static/provider/cloud/deploy.yaml > /dev/null 2>&1

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# check if ${DOMAIN}.crt exists
if [ -f "${DOMAIN}.crt" ]; then
  echo "Certificate ${DOMAIN}.crt already exists, skipping generation."
else
  echo "Certificate ${DOMAIN}.crt does not exist, generating new certificate."

  echo "Generating certificate..."
  # generate self-signed certificate for domain

  openssl req -x509 -newkey rsa:2048 -days 3650 \
    -noenc -keyout ${DOMAIN}.key -out ${DOMAIN}.crt \
    -subj "/C=NL/ST=Zuid-Holland/L=The Hague/O=MijnBureau/OU=DevOps/CN=${DOMAIN}/emailAddress=admin@${DOMAIN}" \
    -addext "subjectAltName=DNS:${DOMAIN},DNS:*.${DOMAIN},IP:127.0.0.1"  \
    -addext "basicConstraints=CA:FALSE" \
    -addext "keyUsage=digitalSignature,keyEncipherment" \
    -addext "extendedKeyUsage=serverAuth,clientAuth" > /dev/null 2>&1
  openssl x509 -in ${DOMAIN}.crt -outform der -out ${DOMAIN}.der

  if [ "$OS" == "Linux" ]; then
    sudo cp ${DOMAIN}.crt /usr/local/share/ca-certificates/${DOMAIN}.crt
    sudo update-ca-certificates
  elif [ "$OS" == "macOS" ]; then
    echo "You use macOS, you might need to add the certificate to your keychain manually:
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ${DOMAIN}.crt"
  fi
fi

kubectl create secret tls kind-tls \
  --cert=${DOMAIN}.crt \
  --key=${DOMAIN}.key -n ingress-nginx > /dev/null 2>&1

# set nginx as default ingress controller
kubectl patch ingressclass nginx -p '{"metadata": {"annotations":{"ingressclass.kubernetes.io/is-default-class":"true"}}}'

# change configmap for ingress nginx
# kubectl patch configmap ingress-nginx-controller -n ingress-nginx --type merge -p '{"data": {"force-ssl-redirect": "true"}}' > /dev/null 2>&1
kubectl patch configmap ingress-nginx-controller -n ingress-nginx --type merge -p '{"data": {"allow-snippet-annotations": "true"}}' > /dev/null 2>&1
kubectl patch configmap ingress-nginx-controller -n ingress-nginx --type merge -p '{"data": {"annotations-risk-level": "Critical"}}' > /dev/null 2>&1

# change deployment to add default certificate
kubectl patch deployment ingress-nginx-controller -n ingress-nginx --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--default-ssl-certificate=ingress-nginx/kind-tls"}]' > /dev/null 2>&1

echo "Please edit your /etc/hosts file and add the following lines:"
echo "127.0.0.1 id.${DOMAIN}"
echo "127.0.0.1 id-admin.${DOMAIN}"
echo "127.0.0.1 grist.${DOMAIN}"
echo "127.0.0.1 nextcloud.${DOMAIN}"
echo "127.0.0.1 chat.${DOMAIN}"
echo "127.0.0.1 matrix.${DOMAIN}"
echo "127.0.0.1 <other>.${DOMAIN}"

# install gateway API
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml

echo "Kind cluster ready for use, Execute the following command to install MijnBureau:"
echo "helmfile -e demo apply --skip-refresh"

echo "To autocreate namespace run:"
echo "export MIJNBUREAU_CREATE_NAMESPACES=true"
