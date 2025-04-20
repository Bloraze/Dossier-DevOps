# 📁 Dossier-DevOps (Infrastructure & Scripts)

## 🛠️ Présentation du projet

Ce dépôt contient l'infrastructure complète du projet **DevOps local** :
- Fichiers Kubernetes (YAML),
- Scripts shell d’automatisation,
- Application web de démonstration (HTML + Dockerfile).

Il fonctionne de pair avec le dépôt GitLab suivant, qui contient la partie CI/CD :  
🔗 [CI/CD GitLab](https://gitlab.com/Bloraze/CI-CD)

---

## 💻 Environnement conseillé

- 🌧️ **Système recommandé** : Ubuntu (natif ou via [WSL](https://learn.microsoft.com/fr-fr/windows/wsl/) sur Windows)
- 🧠 **Éditeur conseillé** : [Visual Studio Code](https://code.visualstudio.com/) avec l’extension *Remote - WSL* ou un terminal intégré

---

## ⚙️ Installation automatique

Tous les prérequis sont installables via les scripts fournis :

### 🧬 1. Installer les outils nécessaires (Docker, Minikube, kubectl, etc.)
```bash
chmod +x scripts/install-prerequis.sh
./scripts/install-prerequis.sh
```

### 🧬 2. Installer les outils de validation (hadolint, yamllint, tidy, etc.)
```bash
chmod +x scripts/install-prepred.sh
./scripts/install-prepred.sh
```

---

## 🚀 Mise en route

### 🔹 Étape 1 : Cloner les deux dépôts
```bash
git clone https://github.com/Bloraze/Dossier-DevOps.git
git clone https://gitlab.com/Bloraze/CI-CD.git
```

### 🔹 Étape 2 : Lancer et configurer Minikube
```bash
cd Dossier-DevOps
chmod +x scripts/setup-minikube.sh
./scripts/setup-minikube.sh
```

### 🔹 Étape 3 : Déployer tous les services
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

### 🔹 Étape 4 (optionnel) : Réinitialiser l’environnement
```bash
chmod +x scripts/reset-env.sh
./scripts/reset-env.sh
```

---

## ✅ Résultat attendu

Une fois le projet lancé, vous pouvez accéder à l'application web via :  
📍 `http://localhost:8080`

Les services Grafana, Prometheus et SonarQube sont également accessibles via port-forward ou IP Minikube.  
Consultez les fichiers YAML ou le script `deploy.sh` pour connaître les ports utilisés.

---

## 🔗 Projet lié

Ce projet est étroitement lié au dépôt GitLab contenant la chaîne CI/CD automatisée :  
➡️ [CI/CD GitLab](https://gitlab.com/Bloraze/CI-CD)

---

📌 *Projet développé dans le cadre d’un mémoire de fin d’alternance, avec l’objectif de maîtriser un déploiement automatisé local complet via GitLab CI/CD et Minikube.*
