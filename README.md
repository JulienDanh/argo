# Argo KIND Cluster

This repository contains a simple configuration to start a Kubernetes cluster using KIND (Kubernetes IN Docker).

## Prerequisites

Before using this configuration, make sure you have the following installed:

- **Docker**: Make sure Docker is running on your system
- **KIND**: Install KIND using one of the following methods:
  - **macOS**: `brew install kind`
  - **Linux**: 
    ```bash
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/
    ```
  - **Windows**: `choco install kind`
- **kubectl**: Install kubectl to interact with the cluster

## Quick Start

1. **Make the script executable**:
   ```bash
   chmod +x start-cluster.sh
   ```

2. **Create and start the cluster**:
   ```bash
   ./start-cluster.sh create
   ```

3. **Verify the cluster is running**:
   ```bash
   ./start-cluster.sh status
   ```

4. **Get cluster information**:
   ```bash
   ./start-cluster.sh info
   ```

## Available Commands

The `start-cluster.sh` script provides the following commands:

- `create` - Create a new cluster
- `start` - Start an existing cluster
- `stop` - Stop the cluster
- `delete` - Delete the cluster
- `restart` - Delete and recreate the cluster
- `status` - Show cluster status
- `info` - Show cluster information
- `help` - Show help message

## Cluster Configuration

The cluster is configured with:

- **Single control-plane node** for simplicity
- **Port mappings** for common services (80, 443, 30000, 30001)
- **Ingress-ready** node labels for easy ingress controller setup
- **Systemd cgroup** support for better container runtime compatibility

## Using the Cluster

Once the cluster is created, you can:

1. **Set the kubectl context**:
   ```bash
   kubectl config use-context kind-argo-cluster
   ```

2. **Deploy applications**:
   ```bash
   kubectl apply -f your-manifest.yaml
   ```

3. **Access the cluster**:
   ```bash
   kubectl cluster-info
   ```

## Cleanup

To clean up the cluster when you're done:

```bash
./start-cluster.sh delete
```

## Troubleshooting

- **Docker not running**: Make sure Docker Desktop is started
- **Port conflicts**: The configuration maps ports 80, 443, 30000, and 30001. Make sure these ports are available on your host
- **Permission issues**: Make sure the script is executable with `chmod +x start-cluster.sh`

## Files

- `kind-config.yaml` - KIND cluster configuration
- `start-cluster.sh` - Management script for the cluster
- `README.md` - This documentation
