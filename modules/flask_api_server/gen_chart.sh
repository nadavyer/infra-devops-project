#!/bin/bash

# Set script to exit on any errors.
set -e

# Variables
CHART_NAME="flask-api-server-chart"
APP_NAME="flask-api-server"
DOCKER_REPO="your-docker-repo"  # Replace with your Docker repository
IMAGE_TAG="latest"
NAMESPACE="default"  # Kubernetes namespace you wish to deploy to

# Create a Helm chart
echo "Creating Helm chart..."
helm create $CHART_NAME

# Update values.yaml for the Helm chart
echo "Configuring Helm chart..."
cat <<EOF > $CHART_NAME/values.yaml
replicaCount: 1

image:
  repository: $DOCKER_REPO/$APP_NAME
  tag: $IMAGE_TAG
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 5000  # Flask default port

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

nodeSelector: {}

tolerations: []

affinity: {}

env: []  # Add your environment variables here if needed
EOF

# Update templates or any other configurations as needed
# For example, you might customize deployment.yaml or service.yaml further here if required

# Deploy the chart to Kubernetes
echo "Deploying Helm chart to Kubernetes..."
helm upgrade --install $APP_NAME ./$CHART_NAME --namespace $NAMESPACE

# Display the status of the deployment
echo "Getting deployment status..."
kubectl rollout status deployment/$APP_NAME --namespace $NAMESPACE

echo "Helm chart deployment complete!"