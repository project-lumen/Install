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

A la fin du script on est connecté en ssh sur la vagrant.
Vous pouvez vous diriger vers le dossier script qui contient le script mongoBackup.sh et lancer la commande suivante 
```
cd /var/www/html/script && bash mongoBackup.sh
```  
Le script vous demande si vous avez demarré mongo, dans le cas échant vous pouvez le demarrer en suivant les indications.
Aprés cette etape vous pouvez importer un base de donnée qui contient l'architechture de notre bdd.


Pour finir, on peux se rendre sur l'adresse 192.168.33.10 qui pointe sur index.php 
La fenêtre affiche la version de LUMEN.

le back est prêt !! 

## Electron / The Big Bang Task

Ouvrir un terminal et se diriger a la racine du dossier front-electron téléchargé lors du lancement du script install.sh
executer ces deux lignes pour installer les paquets necessaire à electron et pour lancer l'application

```
npm install
``` 
```
npm start
``` 
L'application se lance en developpement, vous pouvez desormais l'utiliser !

