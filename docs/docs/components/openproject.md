---
sidebar_position: 10
---

# OpenProject

Project management system for MijnBureau.

## Quick Start

```bash
# Deploy OpenProject
export MIJNBUREAU_MASTER_PASSWORD="demo-password"
export MIJNBUREAU_CREATE_NAMESPACES=true
helmfile -e demo -l name=openproject apply
```

## Access

- **URL**: `http://openproject.mb.test/`
- **Login**: `admin@example.com` / `admin123`

## Features

- Project planning with Gantt charts
- Task management and time tracking
- Team collaboration and file sharing
- Project reporting and analytics

## Troubleshooting

```bash
# Check status
kubectl get pods -n mijn-bureau | grep openproject

# Check logs
kubectl logs -n mijn-bureau -l app.kubernetes.io/name=openproject

# Restart if needed
kubectl rollout restart deployment/openproject-web -n mijn-bureau
```
