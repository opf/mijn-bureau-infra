# OpenProject Application

OpenProject is a web-based project management system for MijnBureau infrastructure.

## Quick Start

### Demo Environment

```bash
# Deploy OpenProject
helmfile -e demo -l name=openproject apply

# Access: http://openproject.mb.test/
# Login: admin@example.com / admin123
```

### Production Environment

```bash
# Deploy OpenProject
helmfile -e production -l name=openproject apply

# Access: https://openproject.yourdomain.com/
# Authentication: OIDC/SSO via Keycloak
```

## Configuration

### Environment Variables

```bash
export MIJNBUREAU_MASTER_PASSWORD="your-secure-password"
export MIJNBUREAU_CREATE_NAMESPACES=true
```

### Key Settings

| Environment | Database            | TLS      | SMTP     | Resources   |
| ----------- | ------------------- | -------- | -------- | ----------- |
| Demo        | Bundled PostgreSQL  | Disabled | Disabled | 4 CPU / 4Gi |
| Production  | External PostgreSQL | Enabled  | Enabled  | 8 CPU / 8Gi |

## Files

- `values.yaml.gotmpl` - Main OpenProject configuration
- `helmfile-child.yaml.gotmpl` - Helmfile deployment configuration

## Troubleshooting

```bash
# Check pod status
kubectl get pods -n mijn-bureau | grep openproject

# Check logs
kubectl logs -n mijn-bureau -l app.kubernetes.io/name=openproject
```

## Documentation

- [OpenProject Official Docs](https://www.openproject.org/docs/)
- [OpenProject Helm Chart](https://github.com/opf/helm-charts)
