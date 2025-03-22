FROM nginx:alpine

# Copier le fichier index.html dans le répertoire par défaut de nginx
COPY index.html /usr/share/nginx/html/index.html

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
