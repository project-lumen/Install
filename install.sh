#!/bin/bash
# ------------------------------------------------------------------
# [Adrien Fevre, Jeremie Sophikitis, Victor Anton]
# install.sh
# - Recupération des dossiers back & front
# - Genere un fichier Vagrantfile avec provisionning -> setup.sh
# -----------------------------------------------------------------



#### VERIF DOSSIER project  ####
  if [ ! -d back-lumen ];
  then
    ####### Clone reppo #######
     read -p "
    _______________________________________________________________
    | Menu : Choix branch back-lumen                                |
    | 1 - master (prod)                                             |
    | 2 - Develop                                                   |
    _______________________________________________________________
    " menu;
    if [[ $menu -eq 1 ]]
    then
      git clone https://github.com/project-lumen/back-lumen.git
      echo "OK"
    elif [[ $menu -eq 2 ]]
    then
      git clone -b dev https://github.com/project-lumen/back-lumen.git
      echo "OK"
    else
     echo "Saisie incorrecte";
   fi
      echo -e "
      \033[44mLe dossier back-lumen a été creer !\033[0m"
  else
      echo -e "
      \033[45mUn dossier back-lumen existe deja !\033[0m"
      cd ./back-lumen
      git pull
      cd ../
  fi


  #### VERIF DOSSIER front-electron  ####
  if [ ! -d front-electron ];
  then
    ####### SSH Installation reppo Electron-Front #######
       read -p "
      _______________________________________________________________
      | Menu : Choix branch front-electron                            |
      | 1 - master (Prod)                                             |
      | 2 - Develop                                                   |
      _______________________________________________________________
      " menu;
      if [[ $menu -eq 1 ]]
      then
        git clone https://github.com/project-lumen/front-electron.git
        echo "OK"
      elif [[ $menu -eq 2 ]]
      then
        git clone -b dev https://github.com/project-lumen/front-electron.git
        echo "OK"
      else
       echo "Saisie incorrecte";
     fi
      echo -e "
      \033[44mLe dossier front-electron a été creer !\033[0m"
  else
      echo -e "
      \033[45mUn dossier front-electron existe deja !\033[0m"
      cd ./front-electron
      git pull
      cd ../
  fi

  #### MODIF VAGRANT FILE ####

    #### VERIF VAGRANTFILE ####
    if [ ! -f Vagrantfile ];
    then

        echo "
        # -*- mode: ruby -*-
        # vi: set ft=ruby :
        Vagrant.configure(\"2\") do |config|
        config.vm.box = \"ubuntu/xenial64\"
        config.vm.synced_folder \"./back-lumen\", \"/var/www/html\"
        config.vm.network \"private_network\", ip: \"192.168.33.10\"
        config.vm.network \"forwarded_port\", guest: 8000, host: 8000
        config.vm.provision \"shell\", path: \"setup.sh\"
        end" > Vagrantfile

        echo -e "
        \033[44mLe fichier Vagrantfile a été généré !\033[0m"
        echo "Ip connection 192.168.33.10";
    else
        echo -e "
        \033[45mUn Vagrantfile existe déjà dans ce dossier !\033[0m"
        ####### Modification Vagrantfile #######
         read -p "
        _______________________________________________________________
        | Menu : Voulez vous le modifier                                |
        | 1 - Oui                                                       |
        | 2 - Non                                                       |
        _______________________________________________________________
        " menu;
        if [[ $menu -eq 1 ]]
        then
          echo "
          # -*- mode: ruby -*-
          # vi: set ft=ruby :
          Vagrant.configure(\"2\") do |config|
          config.vm.box = \"ubuntu/xenial64\"
          config.vm.synced_folder \"./back-lumen\", \"/var/www/html\"
          config.vm.network \"private_network\", ip: \"192.168.33.10\"
          config.vm.network \"forwarded_port\", guest: 8000, host: 8000
          config.vm.provision \"shell\", path:\"setup.sh\"
          end" > Vagrantfile
          echo "Ip connection 192.168.33.10";
        elif [[ $menu -eq 2 ]]
        then
          echo "Ok"
        else
         echo "Saisie incorrecte";
       fi
    fi


    vagrant up
    vagrant ssh
