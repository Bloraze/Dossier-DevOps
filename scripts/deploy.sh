#!/bin/bash

# Assurez-vous d'utiliser le daemon Docker de Minikube
eval $(minikube docker-env)

# Construire l'image Docker pour l'application nginx
echo "Construction de l'image Docker pour l'application nginx..."
docker build -t nginx-app:latest app/

# Créer les PVC pour SonarQube et Grafana
echo "Création des PersistentVolumeClaims..."
kubectl apply -f k8s/sonarqube/sonarqube-pvc.yaml
kubectl apply -f k8s/grafana/grafana-pvc.yaml

# Déployer SonarQube
echo "Déploiement de SonarQube..."
kubectl apply -f k8s/sonarqube/sonarqube-deployment.yaml
kubectl apply -f k8s/sonarqube/sonarqube-service.yaml

# Déployer Grafana
echo "Déploiement de Grafana..."
kubectl apply -f k8s/grafana/grafana-deployment.yaml
kubectl apply -f k8s/grafana/grafana-service.yaml

# Déployer l'application nginx
echo "Déploiement de l'application nginx..."
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/app-service.yaml

echo "Tous les services ont été déployés!"

# Afficher l'URL pour accéder à l'application
echo "Attente du démarrage des services..."
sleep 10

echo "URL de l'application web (Nginx):"
minikube service nginx-app-service --url

echo "URL de SonarQube:"
minikube service sonarqube-service --url

echo "URL de Grafana:"
minikube service grafana-service --url

echo "Les URL ci-dessus peuvent être utilisées pour accéder aux services depuis votre navigateur."
