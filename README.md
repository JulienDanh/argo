# Argo KIND Cluster

This repository contains a simple configuration to start a Kubernetes cluster using KIND (Kubernetes IN Docker) with ArgoCD for GitOps and a sample FastAPI application.

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

1. **Make the scripts executable**:
   ```bash
   chmod +x start-cluster.sh install-argocd.sh deploy-app.sh
   ```

2. **Create and start the cluster**:
   ```bash
   ./start-cluster.sh create
   ```

3. **Install ArgoCD**:
   ```bash
   ./install-argocd.sh install
   ```

4. **Build and deploy the FastAPI app**:
   ```bash
   ./deploy-app.sh full
   ```

5. **Access the applications**:
   - **ArgoCD UI**: `./install-argocd.sh ui` then open http://localhost:8080
   - **FastAPI App**: `./deploy-app.sh forward` then open http://localhost:30000

## Available Commands

### Cluster Management (`start-cluster.sh`)
- `create` - Create a new cluster
- `start` - Start an existing cluster
- `stop` - Stop the cluster
- `delete` - Delete the cluster
- `restart` - Delete and recreate the cluster
- `status` - Show cluster status
- `info` - Show cluster information
- `help` - Show help message

### ArgoCD Management (`install-argocd.sh`)
- `install` - Install ArgoCD on the cluster
- `password` - Get the admin password
- `ui` - Start port forwarding for ArgoCD UI
- `status` - Show ArgoCD status
- `help` - Show help message

### FastAPI App Management (`deploy-app.sh`)
- `build` - Build Docker image
- `load` - Load image into KIND cluster
- `deploy` - Deploy with ArgoCD
- `manual` - Deploy manually (without ArgoCD)
- `full` - Build, load, and deploy with ArgoCD
- `status` - Show application status
- `forward` - Start port forwarding to app
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

## Using ArgoCD

After installing ArgoCD:

1. **Get the admin password**:
   ```bash
   ./install-argocd.sh password
   ```

2. **Start the UI**:
   ```bash
   ./install-argocd.sh ui
   ```

3. **Access ArgoCD UI**:
   - URL: http://localhost:8080
   - Username: `admin`
   - Password: (use the command above to get it)

4. **Check ArgoCD status**:
   ```bash
   ./install-argocd.sh status
   ```

## FastAPI Application

The repository includes a simple FastAPI application with basic endpoints.

### Application Structure
```
app/
├── main.py          # FastAPI application
├── requirements.txt # Python dependencies
└── Dockerfile      # Container configuration
```

### API Endpoints
- `GET /` - Hello World message
- `GET /health` - Health check endpoint

### Deployment Options

#### Option 1: Deploy with ArgoCD (Recommended)
```bash
./deploy-app.sh full
```
This will:
1. Build the Docker image
2. Load it into the KIND cluster
3. Create an ArgoCD application
4. ArgoCD will automatically deploy the app

#### Option 2: Deploy Manually
```bash
./deploy-app.sh build
./deploy-app.sh load
./deploy-app.sh manual
```

### Accessing the Application

After deployment, access the FastAPI app:

```bash
./deploy-app.sh forward
```

Then open http://localhost:30000 in your browser.

### Application Status

Check the application status:
```bash
./deploy-app.sh status
```

## GitOps Workflow

The FastAPI application is configured for GitOps with ArgoCD:

1. **Source**: The application manifests are in the `k8s/` directory
2. **ArgoCD Application**: Defined in `argocd-app.yaml`
3. **Automated Sync**: ArgoCD automatically syncs changes from the repository
4. **Self-Healing**: ArgoCD automatically corrects drift from the desired state

To update the application:
1. Make changes to the code or manifests
2. Commit and push to the repository
3. ArgoCD will automatically detect and apply the changes

## Cleanup

To clean up the cluster when you're done:

```bash
./start-cluster.sh delete
```

## Troubleshooting

- **Docker not running**: Make sure Docker Desktop is started
- **Port conflicts**: The configuration maps ports 80, 443, 30000, and 30001. Make sure these ports are available on your host
- **Permission issues**: Make sure the scripts are executable with `chmod +x start-cluster.sh install-argocd.sh deploy-app.sh`
- **ArgoCD not accessible**: Make sure port 8080 is available for the UI port forwarding
- **FastAPI app not accessible**: Make sure port 30000 is available for the app port forwarding

## Files

- `kind-config.yaml` - KIND cluster configuration
- `start-cluster.sh` - Management script for the cluster
- `install-argocd.sh` - ArgoCD installation and management script
- `deploy-app.sh` - FastAPI application deployment script
- `app/` - FastAPI application source code
- `k8s/` - Kubernetes manifests for the application
- `argocd-app.yaml` - ArgoCD application definition
- `README.md` - This documentation
