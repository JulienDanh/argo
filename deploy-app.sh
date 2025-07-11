#!/bin/bash

# FastAPI App Deployment Script
CLUSTER_NAME="argo-cluster"
APP_NAME="fastapi-app"

# Function to check if Docker is running
check_docker() {
    if ! docker info &>/dev/null; then
        echo "ERROR: Docker is not running. Please start Docker first."
        exit 1
    fi
}

# Function to check if cluster is running
check_cluster() {
    if ! kind get clusters | grep -q "$CLUSTER_NAME"; then
        echo "ERROR: Cluster '$CLUSTER_NAME' does not exist. Create it first with: ./start-cluster.sh create"
        exit 1
    fi
}

# Function to build Docker image
build_image() {
    echo "Building Docker image for FastAPI app..."
    cd app
    docker build -t $APP_NAME:latest .
    cd ..
    echo "Docker image built successfully!"
}

# Function to load image into KIND cluster
load_image() {
    echo "Loading Docker image into KIND cluster..."
    kind load docker-image $APP_NAME:latest --name $CLUSTER_NAME
    echo "Image loaded into cluster successfully!"
}

# Function to deploy with ArgoCD
deploy_with_argocd() {
    echo "Deploying application with ArgoCD..."
    
    # Set kubectl context
    kubectl config use-context "kind-$CLUSTER_NAME"
    
    # Apply ArgoCD application
    kubectl apply -f argocd-app.yaml
    
    echo "ArgoCD application created!"
    echo "Check ArgoCD UI to see the deployment status"
}

# Function to deploy manually (without ArgoCD)
deploy_manual() {
    echo "Deploying application manually..."
    
    # Set kubectl context
    kubectl config use-context "kind-$CLUSTER_NAME"
    
    # Apply Kubernetes manifests
    kubectl apply -k k8s/
    
    echo "Application deployed manually!"
}

# Function to show application status
show_status() {
    echo "Application status:"
    kubectl get pods -n $APP_NAME
    echo ""
    echo "Services:"
    kubectl get svc -n $APP_NAME
    echo ""
    echo "Ingress:"
    kubectl get ingress -n $APP_NAME
}

# Function to port forward to the app
port_forward() {
    echo "Starting port forward to FastAPI app..."
    echo "App will be available at: http://localhost:30000"
    echo "Press Ctrl+C to stop"
    kubectl port-forward svc/fastapi-app-service -n $APP_NAME 30000:80
}

# Function to show help
show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     - Build Docker image"
    echo "  load      - Load image into KIND cluster"
    echo "  deploy    - Deploy with ArgoCD"
    echo "  manual    - Deploy manually (without ArgoCD)"
    echo "  full      - Build, load, and deploy with ArgoCD"
    echo "  status    - Show application status"
    echo "  forward   - Start port forwarding to app"
    echo "  help      - Show this help message"
}

# Main script logic
main() {
    case "${1:-help}" in
        "build")
            check_docker
            build_image
            ;;
        "load")
            check_docker
            check_cluster
            load_image
            ;;
        "deploy")
            check_cluster
            deploy_with_argocd
            ;;
        "manual")
            check_cluster
            deploy_manual
            ;;
        "full")
            check_docker
            check_cluster
            build_image
            load_image
            deploy_with_argocd
            ;;
        "status")
            check_cluster
            show_status
            ;;
        "forward")
            check_cluster
            port_forward
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# Run main function with all arguments
main "$@" 