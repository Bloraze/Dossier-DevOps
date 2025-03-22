# Projet Kubernetes avec Nginx, Prometheus, Grafana et SonarQube

Ce projet déploie une stack d'observabilité complète sur Kubernetes (Minikube) comprenant une application web Nginx, SonarQube pour l'analyse de code, Prometheus pour la collecte de métriques et Grafana pour la visualisation.

## Table des matières

- [Prérequis](#prérequis)
- [Architecture du projet](#architecture-du-projet)
- [Installation et déploiement](#installation-et-déploiement)
- [Accès aux services](#accès-aux-services)
- [Configuration des services](#configuration-des-services)
- [Utilisation des tableaux de bord](#utilisation-des-tableaux-de-bord)
- [Résolution des problèmes courants](#résolution-des-problèmes-courants)
- [Sécurité](#sécurité)
- [Nettoyage](#nettoyage)

## Prérequis

- **Docker** (version 20.10.0 ou supérieure recommandée)
- **kubectl** (version 1.24.0 ou supérieure)
- **Minikube** (version 1.25.0 ou supérieure)
- Au moins 6 Go de RAM disponible pour l'environnement Minikube
- 10 Go d'espace disque libre

Vérifiez vos installations:
```bash
docker --version
kubectl version --client
minikube version
```

## Architecture du projet

```
max-project/
├── app/                        # Application web de démonstration
│   ├── index.html              # Interface utilisateur simple
│   └── Dockerfile              # Configuration de l'image Nginx
├── k8s/                        # Manifestes Kubernetes
│   ├── app-deployment.yaml     # Déploiement de l'application
│   ├── app-service.yaml        # Service pour l'application
│   ├── grafana/                # Configuration Grafana
│   │   ├── grafana-datasource.yaml
│   │   ├── grafana-deployment.yaml
│   │   ├── grafana-pvc.yaml
│   │   └── grafana-service.yaml
│   ├── prometheus/             # Configuration Prometheus
│   │   ├── prometheus-config.yaml
│   │   ├── prometheus-deployment.yaml
│   │   ├── prometheus-pvc.yaml
│   │   └── prometheus-service.yaml
│   └── sonarqube/              # Configuration SonarQube
│       ├── sonarqube-deployment.yaml
│       ├── sonarqube-pvc.yaml
│       └── sonarqube-service.yaml
└── scripts/                    # Scripts d'automatisation
    ├── deploy.sh               # Déploiement des services
    └── setup-minikube.sh       # Configuration de l'environnement
```

## Installation et déploiement

### 1. Configuration de Minikube

```bash
cd scripts
chmod +x setup-minikube.sh
./setup-minikube.sh
```

Ce script:
- Démarre un cluster Minikube avec 4 Go de RAM et 2 CPUs
- Active les addons Ingress, Metrics Server et Dashboard
- Configure l'environnement Docker pour utiliser le daemon Docker de Minikube

### 2. Déploiement des services

```bash
chmod +x deploy.sh
./deploy.sh
```

Ce script:
- Construit l'image Docker de l'application Nginx
- Crée les Persistent Volume Claims nécessaires
- Déploie Prometheus, Grafana et SonarQube
- Configure les datasources Prometheus pour Grafana
- Déploie l'application Nginx
- Affiche les URLs pour accéder aux services

## Accès aux services

Après le déploiement, vous pouvez accéder aux services via:

```bash
# Obtenir les URLs des services
minikube service nginx-app-service --url   # Pour l'application web
minikube service sonarqube-service --url   # Pour SonarQube
minikube service grafana-service --url     # Pour Grafana
minikube service prometheus-service --url  # Pour Prometheus
```

Vous pouvez également ouvrir le tableau de bord Kubernetes:
```bash
minikube dashboard
```

## Configuration des services

### Nginx
- Sert une page web simple avec des liens vers les autres services

### SonarQube
- **URL**: http://<minikube-ip>:<port-sonarqube>
- **Identifiants par défaut**: admin/admin
- **Configuration**: Utilisez l'interface web pour ajouter vos projets et configurer l'analyse de code

### Prometheus
- **URL**: http://<minikube-ip>:<port-prometheus>
- **Configuration**: Les cibles de scraping sont définies dans `prometheus-config.yaml`
- **Exploration**: Utilisez l'interface Prometheus pour exécuter des requêtes PromQL

### Grafana
- **URL**: http://<minikube-ip>:<port-grafana>
- **Identifiants par défaut**: admin/admin
- **Sources de données**: Prometheus est déjà configuré comme source de données
- **Tableaux de bord**: Importez des tableaux de bord existants ou créez les vôtres

## Utilisation des tableaux de bord

### Grafana

1. Connectez-vous à l'interface Grafana avec les identifiants `admin/admin`
2. Vous serez invité à changer le mot de passe par défaut (recommandé)
3. Pour importer des tableaux de bord Kubernetes:
   - Cliquez sur `+ > Import` dans le menu latéral
   - Entrez l'ID `315` pour le tableau de bord Kubernetes
   - Sélectionnez la source de données Prometheus
   - Cliquez sur `Import`
4. Pour créer des alertes:
   - Configurez un canal de notification (Menu `Alerting > Notification channels`)
   - Ajoutez des règles d'alerte à vos tableaux de bord

## Résolution des problèmes courants

### Images Docker non disponibles
```bash
# Vérifiez que vous utilisez le daemon Docker de Minikube
eval $(minikube docker-env)
# Reconstruisez l'image
docker build -t nginx-app:latest app/
```

### Persistent Volume Claims en attente
```bash
# Vérifiez l'état des PVCs
kubectl get pvc
# Si bloqués en "Pending", vérifiez la capacité de stockage disponible
minikube ssh -- df -h
```

### Services inaccessibles
```bash
# Vérifiez l'état des pods
kubectl get pods
# Consultez les logs pour diagnostiquer les problèmes
kubectl logs <nom-du-pod>
```

## Sécurité

Cet environnement est conçu pour le développement local et n'implémente pas toutes les bonnes pratiques de sécurité nécessaires en production:

- Les mots de passe par défaut sont utilisés (modifiez-les en production)
- Les données persistantes ne sont pas chiffrées
- Les communications ne sont pas sécurisées par TLS

Pour un déploiement en production, consultez les guides de sécurité spécifiques à chaque service.

## Nettoyage

Pour arrêter et supprimer l'environnement:

```bash
# Supprimer les déploiements individuels (optionnel)
kubectl delete -f k8s/

# OU supprimer complètement le cluster Minikube
minikube delete
```

## Ressources additionnelles

- [Documentation Kubernetes](https://kubernetes.io/docs/)
- [Documentation Prometheus](https://prometheus.io/docs/)
- [Documentation Grafana](https://grafana.com/docs/)
- [Documentation SonarQube](https://docs.sonarqube.org/)