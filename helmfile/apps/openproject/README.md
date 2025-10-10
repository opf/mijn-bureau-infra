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
│   OpenProject   │    │   PostgreSQL    │    │   Redis         │
│   Web + Worker  │◄──►│   (Database)    │    │   (Cache)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Ingress       │    │   Memcached     │    │   SMTP          │
│   (nginx)       │    │   (Cache)        │    │   (Email)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Configuration

### Environment-Specific Settings

#### Demo Environment
- **TLS**: Disabled for local development
- **Database**: Bundled PostgreSQL
- **SMTP**: Disabled
- **Resources**: Optimized for demo (2 CPU / 2Gi memory)
- **Security**: Relaxed for development
- **Authentication**: Simple admin login (no OIDC/SSO)

#### Production Environment
- **TLS**: Enabled with Let's Encrypt certificates
- **Database**: External PostgreSQL with SSL
- **SMTP**: Configured for email notifications
- **Resources**: Production-grade (4 CPU / 8Gi memory)
- **Security**: Strict security policies
- **Authentication**: OIDC/SSO integration with Keycloak

### Key Configuration Files

- `values.yaml.gotmpl` - Main OpenProject configuration
- `values-postgresql.yaml.gotmpl` - PostgreSQL database configuration
- `values-redis.yaml.gotmpl` - Redis cache configuration
- `helmfile-child.yaml.gotmpl` - Helmfile deployment configuration

## Deployment

### Prerequisites

1. **Kubernetes Cluster**: Running Kubernetes cluster with ingress controller
2. **Helmfile**: Installed and configured
3. **Environment Variables**: Set required environment variables
4. **Secrets**: Configure database and SMTP credentials

### Environment Variables

```bash
# Required for all environments
export MIJNBUREAU_MASTER_PASSWORD="your-secure-password"
export MIJNBUREAU_CREATE_NAMESPACES=true

# Production-specific (optional)
export OPENPROJECT_DB_HOST="your-db-host"
export OPENPROJECT_DB_PASSWORD="your-db-password"
export OPENPROJECT_SMTP_HOST="your-smtp-host"
export OPENPROJECT_SMTP_PASSWORD="your-smtp-password"
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

## Access Information

### Demo Environment
- **URL**: `http://openproject.mb.test`
- **Admin User**: `admin@example.com`
- **Admin Password**: `admin`
- **Database**: Bundled PostgreSQL

### Production Environment
- **URL**: `https://openproject.yourdomain.com`
- **Admin User**: Configured via secrets
- **Admin Password**: Configured via secrets
- **Database**: External PostgreSQL with SSL

## Configuration Options

### Database Configuration

#### Bundled PostgreSQL (Demo)
```yaml
postgresql:
  bundled: true
  auth:
    postgresPassword: "admin-password"
    username: "openproject"
    password: "user-password"
    database: "openproject"
```

#### External PostgreSQL (Production)
```yaml
postgresql:
  bundled: false
  connection:
    host: "db.example.com"
    port: "5432"
    database: "openproject"
    username: "openproject"
    password: "secure-password"
    ssl: true
    sslMode: "require"
```

### SMTP Configuration

```yaml
smtp:
  enabled: true
  host: "smtp.example.com"
  port: "587"
  protocol: "smtp"
  fromAddress: "noreply@example.com"
  username: "smtp-user"
  password: "smtp-password"
  tls:
    enabled: true
    force: true
    requireTransportSecurity: true
```

### Resource Configuration

#### Demo Environment
```yaml
resources:
  limits:
    cpu: "2"
    memory: "2Gi"
  requests:
    cpu: "500m"
    memory: "1Gi"
```

#### Production Environment
```yaml
resources:
  limits:
    cpu: "4"
    memory: "8Gi"
  requests:
    cpu: "1"
    memory: "2Gi"
```

## Security Features

### Security Context
- **Non-root containers**: All containers run as non-root user (1000)
- **Read-only filesystem**: Production containers use read-only root filesystem
- **Capability dropping**: All unnecessary capabilities are dropped
- **Privilege escalation**: Disabled

### Network Security
- **Network policies**: Restrict network access between components
- **TLS encryption**: All traffic encrypted in production
- **Security headers**: HSTS, X-Frame-Options, and other security headers

### Data Security
- **Encrypted storage**: Database and cache connections encrypted
- **Secret management**: All secrets stored in Kubernetes secrets
- **Backup encryption**: Production backups are encrypted

## Monitoring and Observability

### Metrics
- **Application metrics**: OpenProject performance metrics
- **Resource metrics**: CPU, memory, and storage usage
- **Database metrics**: PostgreSQL performance metrics

### Logging
- **Structured logging**: JSON-formatted logs in production
- **Log levels**: Configurable log levels (debug, info, warn, error)
- **Log aggregation**: Centralized logging with ELK stack

### Health Checks
- **Liveness probes**: Ensure application is running
- **Readiness probes**: Ensure application is ready to serve traffic
- **Startup probes**: Handle slow startup times

## Backup and Recovery

### Backup Configuration
```yaml
backup:
  enabled: true
  schedule: "0 2 * * *"  # Daily at 2 AM
  retention: "30d"
  storage:
    type: "s3"
    bucket: "openproject-backups"
    region: "us-west-2"
```

### Recovery Process
1. **Database restore**: Restore PostgreSQL database from backup
2. **Assets restore**: Restore OpenProject assets from backup
3. **Configuration restore**: Restore application configuration
4. **Verification**: Verify application functionality

## Troubleshooting

### Common Issues

#### Pod Startup Issues
```bash
# Check pod status
kubectl get pods -n mijn-bureau -l app.kubernetes.io/name=openproject

# Check pod logs
kubectl logs -n mijn-bureau -l app.kubernetes.io/name=openproject

# Check pod events
kubectl describe pod -n mijn-bureau -l app.kubernetes.io/name=openproject
```

#### Database Connection Issues
```bash
# Check database connectivity
kubectl exec -it openproject-postgresql-0 -n mijn-bureau -- psql -U openproject -d openproject -c "SELECT 1;"

# Check database logs
kubectl logs openproject-postgresql-0 -n mijn-bureau
```

#### Ingress Issues
```bash
# Check ingress status
kubectl get ingress -n mijn-bureau

# Check ingress events
kubectl describe ingress openproject -n mijn-bureau
```

### Performance Optimization

#### Resource Tuning
- **CPU limits**: Adjust based on workload
- **Memory limits**: Monitor memory usage and adjust
- **Storage**: Use fast SSD storage for production

#### Database Optimization
- **Connection pooling**: Configure appropriate pool sizes
- **Indexing**: Ensure proper database indexing
- **Maintenance**: Regular database maintenance tasks

## Maintenance

### Updates
- **Application updates**: Update OpenProject version
- **Database updates**: Update PostgreSQL version
- **Security updates**: Apply security patches

### Monitoring
- **Health checks**: Regular health check monitoring
- **Performance monitoring**: Monitor application performance
- **Security monitoring**: Monitor for security issues

## Support

### Documentation
- [OpenProject Official Documentation](https://www.openproject.org/docs/)
- [OpenProject Helm Chart](https://github.com/opf/helm-charts/)
- [OpenProject Installation Guide](https://www.openproject.org/docs/installation-and-operations/installation/helm-chart/)

### Community
- [OpenProject Community Forum](https://community.openproject.org/)
- [OpenProject GitHub](https://github.com/opf/openproject)
- [OpenProject Slack](https://openproject-slack.herokuapp.com/)

## License

OpenProject is licensed under the GNU General Public License v3.0. See the [OpenProject License](https://github.com/opf/openproject/blob/main/LICENSE) for details.
