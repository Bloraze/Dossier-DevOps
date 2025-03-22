#!/bin/bash

# Démarrer Minikube
echo "Démarrage de Minikube..."
minikube start --driver=docker --memory=4096 --cpus=2

# Activer les addons utiles
echo "Activation des addons..."
minikube addons enable ingress
minikube addons enable metrics-server
minikube addons enable dashboard

# Configurer Docker pour utiliser le daemon Docker de Minikube
echo "Configuration de Docker pour utiliser le daemon Docker de Minikube..."
eval $(minikube docker-env)

echo "Configuration de Minikube terminée!"
echo "Vous pouvez maintenant construire votre image et déployer votre application."
echo "Pour accéder au tableau de bord Kubernetes: minikube dashboard"
