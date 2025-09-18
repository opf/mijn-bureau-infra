# OpenProject

This directory contains the Helm configuration for OpenProject, a project management and collaboration tool.

## Overview

OpenProject is deployed using the official OpenProject Helm chart from [charts.openproject.org](https://charts.openproject.org). The deployment includes:

- **OpenProject**: The main application
- **PostgreSQL**: Database backend
- **Memcached**: Caching layer

## Configuration

The OpenProject deployment is configured through the following files:

- `helmfile-child.yaml.gotmpl`: Main helmfile configuration
- `values.yaml.gotmpl`: OpenProject application values
- `values-postgresql.yaml.gotmpl`: PostgreSQL database values
- `values-memcached.yaml.gotmpl`: Memcached cache values

## Features

- **OIDC Authentication**: Integrated with Keycloak for single sign-on
- **Persistent Storage**: Data persistence across pod restarts
- **Network Policies**: Secure communication between components
- **Auto-scaling**: Horizontal Pod Autoscaler support
- **TLS/SSL**: Secure ingress with proper certificate management
- **Monitoring Ready**: Health checks and metrics endpoints

## Access

- **URL**: `https://openproject.kubernetes.local`
- **Demo Environment**: `helmfile -e demo apply`
- **Production Environment**: `helmfile -e production apply`

## Components

### OpenProject Web
- Main application server
- Handles HTTP requests
- Serves the web interface

### OpenProject Worker
- Background job processing
- Handles asynchronous tasks
- Processes notifications and reports

### OpenProject Cron
- Scheduled tasks
- Maintenance operations
- Data cleanup

### PostgreSQL
- Primary database
- Stores all application data
- Configured with proper security

### Memcached
- Caching layer
- Improves performance
- Session storage

## Security

- Network policies restrict communication
- TLS encryption for all external communication
- OIDC integration with Keycloak
- Non-root containers
- Read-only root filesystems
- Security contexts applied

## Monitoring

- Health checks for all components
- Metrics endpoints available
- Logging configured
- Resource limits and requests set
