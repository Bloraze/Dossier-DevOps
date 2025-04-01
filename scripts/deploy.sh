#!/bin/bash

# Assurez-vous d'utiliser le daemon Docker de Minikube
eval $(minikube docker-env)

# Construire l'image Docker pour l'application nginx
echo "🔧 Construction de l'image Docker pour l'application nginx..."
docker build -t nginx-app:latest app/

# Créer les PVC pour SonarQube, Grafana et Prometheus
echo "📦 Création des PersistentVolumeClaims..."
kubectl apply -f k8s/sonarqube/sonarqube-pvc.yaml
kubectl apply -f k8s/grafana/grafana-pvc.yaml
kubectl apply -f k8s/prometheus/prometheus-pvc.yaml

# Créer le ConfigMap nécessaire à Grafana
echo "⚙️  Application de la configuration Grafana (datasources)..."
kubectl apply -f k8s/grafana/grafana-datasource.yaml

# Déployer SonarQube
echo "🚀 Déploiement de SonarQube..."
kubectl apply -f k8s/sonarqube/sonarqube-deployment.yaml
kubectl apply -f k8s/sonarqube/sonarqube-service.yaml

# Déployer Grafana
echo "🚀 Déploiement de Grafana..."
kubectl apply -f k8s/grafana/grafana-deployment.yaml
kubectl apply -f k8s/grafana/grafana-service.yaml

# Déployer Prometheus
echo "🚀 Déploiement de Prometheus..."
kubectl apply -f k8s/prometheus/prometheus-config.yaml
kubectl apply -f k8s/prometheus/prometheus-deployment.yaml
kubectl apply -f k8s/prometheus/prometheus-service.yaml

# Déployer l'application nginx
echo "🚀 Déploiement de l'application nginx..."
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/app-service.yaml

echo "✅ Tous les services ont été déployés !"

# Attente que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 60

kubectl port-forward svc/nginx-app-service 8080:80 &
kubectl port-forward svc/grafana-service 3000:3000 &
kubectl port-forward svc/prometheus-service 9090:9090 &
kubectl port-forward svc/sonarqube-service 9000:9000 &

echo ""
echo "Accédez aux services via:"
echo "- Application web (Nginx): http://localhost:8080/"
echo "- Grafana: http://localhost:3000/ (admin/admin)"
echo "- Prometheus: http://localhost:9090/"
echo "- SonarQube: http://localhost:9000/ (admin/admin)"

# Afficher l'état des pods
echo ""
echo "📊 État actuel des pods:"
kubectl get pods