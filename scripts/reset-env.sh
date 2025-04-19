#!/bin/bash

echo "🛑 Suppression du cluster Minikube..."
minikube delete --all --purge

echo "🐳 Connexion à l’environnement Docker de Minikube..."
eval $(minikube docker-env)

echo "🗑 Suppression des images Docker dans Minikube..."
docker rmi -f $(docker images -q) 2>/dev/null || true

echo "🧹 Nettoyage des volumes inutilisés ..."
docker volume prune -f

echo "🧼 Suppression des certificats et config Minikube..."
rm -rf ~/.minikube
rm -rf ~/.kube

echo "✅ Environnement propre ! Tu peux relancer ./setup-minikube.sh"
