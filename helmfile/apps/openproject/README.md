# OpenProject Application

This directory contains the OpenProject application configuration for MijnBureau infrastructure.

## Overview

OpenProject is a web-based project management system that provides comprehensive project management capabilities including:

- **Project Planning**: Gantt charts, work packages, and timeline management
- **Task Management**: Issue tracking, time tracking, and workflow management
- **Collaboration**: Team communication, file sharing, and document management
- **Reporting**: Project analytics, time reports, and progress tracking
- **Integration**: REST API, webhooks, and third-party integrations

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   OpenProject   │    │   PostgreSQL    │    │   Memcached     │
│   Web + Worker  │◄──►│   (Database)    │    │   (Cache)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Ingress       │    │   Redis         │    │   SMTP          │
│   (nginx)       │    │   (Cache)        │    │   (Email)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Configuration

### Environment-Specific Settings

#### Demo Environment
- **TLS**: Disabled for local development
- **Database**: Bundled PostgreSQL
- **SMTP**: Disabled
- **Resources**: Optimized for demo (4 CPU / 4Gi memory)
- **Security**: Relaxed for development
- **Authentication**: Simple admin login (no OIDC/SSO)
- **Persistence**: Disabled for demo simplicity

#### Production Environment
- **TLS**: Enabled with Let's Encrypt certificates
- **Database**: External PostgreSQL with SSL
- **SMTP**: Configured for email notifications
- **Resources**: Production-grade (4 CPU / 4Gi memory)
- **Security**: Strict security policies
- **Authentication**: OIDC/SSO integration with Keycloak
- **Persistence**: Enabled for data persistence

### Key Configuration Files

- `values.yaml.gotmpl` - Main OpenProject configuration
- `helmfile-child.yaml.gotmpl` - Helmfile deployment configuration

## Quick Start

### Prerequisites

1. **Kubernetes Cluster**: Running Kubernetes cluster with ingress controller
2. **Helmfile**: Installed and configured
3. **Environment Variables**: Set required environment variables

### Environment Variables

```bash
# Required for all environments
export MIJNBUREAU_MASTER_PASSWORD="your-secure-password"
export MIJNBUREAU_CREATE_NAMESPACES=true
```

### Deployment Commands

#### Demo Environment
```bash
# Deploy OpenProject only
helmfile -e demo -l name=openproject apply

# Deploy full demo environment
helmfile -e demo apply
```

#### Production Environment
```bash
# Deploy OpenProject only
helmfile -e production -l name=openproject apply

# Deploy full production environment
helmfile -e production apply
```

### Access Information

#### Demo Environment
- **URL**: `http://openproject.mb.test/`
- **Admin Login**:
  - Username: `admin@example.com`
  - Password: `admin123`

#### Production Environment
- **URL**: `https://openproject.yourdomain.com/`
- **Authentication**: OIDC/SSO via Keycloak

## Configuration Options

### Complete Values Reference

| Parameter | Description | Default | Demo | Production |
|-----------|-------------|---------|------|------------|
| `openproject.https` | Enable HTTPS | `false` | `false` | `true` |
| `openproject.admin_user.password` | Admin password | `admin123` | `admin123` | `secure-password` |
| `openproject.admin_user.name` | Admin display name | `Admin` | `Admin` | `Admin` |
| `openproject.admin_user.mail` | Admin email | `admin@example.com` | `admin@example.com` | `admin@yourdomain.com` |
| `openproject.seed_locale` | Default locale | `en` | `en` | `en` |
| `postgresql.bundled` | Use bundled PostgreSQL | `true` | `true` | `false` |
| `postgresql.image.registry` | PostgreSQL image registry | `registry-1.docker.io` | `registry-1.docker.io` | N/A |
| `postgresql.image.repository` | PostgreSQL image repository | `bitnamilegacy/postgresql` | `bitnamilegacy/postgresql` | N/A |
| `postgresql.image.tag` | PostgreSQL image tag | `17-debian-12` | `17-debian-12` | N/A |
| `memcached.enabled` | Enable Memcached | `true` | `true` | `true` |
| `memcached.image.tag` | Memcached image tag | `latest` | `latest` | `latest` |
| `smtp.enabled` | Enable SMTP | `false` | `false` | `true` |
| `persistence.assets.enabled` | Enable asset persistence | `true` | `false` | `true` |
| `resources.limits.cpu` | CPU limit | `4` | `4` | `8` |
| `resources.limits.memory` | Memory limit | `4Gi` | `4Gi` | `8Gi` |
| `resources.requests.cpu` | CPU request | `1` | `1` | `2` |
| `resources.requests.memory` | Memory request | `2Gi` | `2Gi` | `4Gi` |

### Database Configuration

#### Bundled PostgreSQL (Demo)
```yaml
postgresql:
  bundled: true
  image:
    registry: "registry-1.docker.io"
    repository: "bitnamilegacy/postgresql"
    tag: "17-debian-12"
```

#### External PostgreSQL (Production)
```yaml
postgresql:
  bundled: false
  connection:
    host: "your-db-host"
    port: 5432
    database: "openproject"
    username: "openproject"
    password: "your-password"
```

### SMTP Configuration

#### Demo (Disabled)
```yaml
smtp:
  enabled: false
```

#### Production (Enabled)
```yaml
smtp:
  enabled: true
  host: "smtp.yourdomain.com"
  port: 587
  protocol: "smtp"
  from_address: "noreply@yourdomain.com"
  tls:
    enabled: true
    force: true
    require_transport_security: true
  username: "smtp-user"
  password: "smtp-password"
```

### Resource Configuration

#### Demo Environment
```yaml
resources:
  limits:
    cpu: "4"
    memory: "4Gi"
  requests:
    cpu: "1"
    memory: "2Gi"
```

#### Production Environment
```yaml
resources:
  limits:
    cpu: "8"
    memory: "8Gi"
  requests:
    cpu: "2"
    memory: "4Gi"
```

## Security Features

- **Security Context**: Non-root containers with restricted capabilities
- **Network Security**: Network policies for pod-to-pod communication
- **Data Security**: Encrypted secrets and secure database connections
- **Authentication**: OIDC/SSO integration for production environments

## Monitoring and Observability

- **Health Checks**: Built-in health endpoints for monitoring
- **Logging**: Structured logging for troubleshooting
- **Metrics**: Resource usage and performance metrics
- **Backup**: Database backup and recovery procedures

## Version Compatibility

| OpenProject Chart | OpenProject Version | Kubernetes | Helm |
|-------------------|---------------------|------------|------|
| 11.0.0 | 16.4.1 | 1.20+ | 3.0+ |

### Breaking Changes

- **Chart 11.0.0**: Requires Kubernetes 1.20+ and Helm 3.0+
- **Security Context**: Demo environment requires specific security context configuration
- **Image Registry**: Updated to use `registry-1.docker.io` for PostgreSQL images

## Troubleshooting

### Common Issues

1. **Pods not starting**: Check if ingress controller is running
2. **Database connection**: Verify PostgreSQL pod is running
3. **Memory issues**: Increase resource limits if needed
4. **Image pull errors**: Check image registry access
5. **Security context errors**: Ensure proper security context for demo environment
6. **PVC issues**: Check if persistent volume claims are bound

### Useful Commands

```bash
# Check pod status
kubectl get pods -n mijn-bureau | grep openproject

# Check logs
kubectl logs -n mijn-bureau -l app.kubernetes.io/name=openproject

# Check ingress
kubectl get ingress -n mijn-bureau

# Check services
kubectl get svc -n mijn-bureau | grep openproject

# Check PVC status
kubectl get pvc -n mijn-bureau

# Check events
kubectl get events -n mijn-bureau --sort-by='.lastTimestamp'
```

### Debug Mode

To enable debug logging, add to your values:

```yaml
openproject:
  debug: true
  log_level: debug
```

## Official Documentation

- **OpenProject Official Docs**: [https://www.openproject.org/docs/](https://www.openproject.org/docs/)
- **OpenProject Helm Chart**: [https://github.com/opf/helm-charts](https://github.com/opf/helm-charts)
- **Kubernetes Installation**: [https://www.openproject.org/docs/installation-and-operations/installation/kubernetes/](https://www.openproject.org/docs/installation-and-operations/installation/kubernetes/)

## Support

For issues and questions, please refer to the main MijnBureau documentation or create an issue in the repository.
