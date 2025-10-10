---
sidebar_position: 8
---

# OpenProject - Project Management

Project management system with Gantt charts, task tracking, and team collaboration.

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

- **Project Planning**: Gantt charts and work packages
- **Task Management**: Issue tracking and time tracking
- **Collaboration**: Team communication and file sharing
- **Reporting**: Project analytics and progress tracking

## Basic Usage

1. **Create Project**: Click "New Project" to start
2. **Add Tasks**: Create work packages (tasks, bugs, features)
3. **Track Progress**: Use Gantt charts and boards
4. **Collaborate**: Share files and communicate with team

## Troubleshooting

```bash
# Check status
kubectl get pods -n mijn-bureau | grep openproject

# Check logs
kubectl logs -n mijn-bureau -l app.kubernetes.io/name=openproject

# Restart if needed
kubectl rollout restart deployment/openproject-web -n mijn-bureau
```
