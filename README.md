# Vagrant Lumen / Apache2 / MongoDB

Script qui permet de récupérer nos dossiers back&front et d'initialiser une vagrant avec toutes les configurations nécessaires a l'utilisation de lumen, apache2 et mongoDB.

# Prérequis :
[VirtualBox](https://www.virtualbox.org/)
[Vagrant](https://www.vagrantup.com/)

## Utilisation  

Copier les fichiers setup.sh et install.sh dans le dossier spécifique au projet
Ouvrir le terminal et se rendre dans le dossier du projet
Lancer le script install.sh pour initialiser l'installation

```
bash install.sh
```  
Le script se lance en proposant dans un premier temps de récupérer le dossier back prod ou le back dev puis dans un second temps de télécharger le front prod ou le front dev.

Le script va générer un fichier Vagrantfile qui va servir à l'étape suivante lors du vagrant up.
Lors du vagrant up, le provisioning va lancer le script setup.sh

A la fin de celui-ci, on se rend sur l'adresse 192.168.33.10 qui pointe sur index.php 
La fenêtre affiche la version de LUMEN.
